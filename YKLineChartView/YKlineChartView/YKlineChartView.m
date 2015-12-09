//
//  YKlineChartView.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKlineChartView.h"
#import "YKLineEntity.h"
@interface YKlineChartView()
@property (nonatomic,strong)YKLineDataSet * dataSet;
@property (nonatomic,assign)CGFloat maxPrice;
@property (nonatomic,assign)CGFloat minPrice;

@property (nonatomic,assign)CGFloat maxVolume;

@property (nonatomic,assign)CGFloat candleWidth;

@property (nonatomic,assign)CGFloat candleCoordsScale;
@property (nonatomic,assign)CGFloat volumeCoordsScale;

@property (nonatomic,assign)NSInteger countOfshowCandle;

@property (nonatomic,assign)NSInteger  startDrawIndex;

@property (nonatomic,strong)UIPanGestureRecognizer * panGesture;

@end
@implementation YKlineChartView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        
    }
    return self;
}


- (void)commonInit {
    
    [super commonInit];
    self.candleCoordsScale = 0.f;
    self.candleWidth = 5.f;
    [self addGestureRecognizer:self.panGesture];
}
- (NSInteger)countOfshowCandle{
    return self.contentWidth/(self.candleWidth);
}
- (void)setStartDrawIndex:(NSInteger)startDrawIndex
{
    if (startDrawIndex < 0) {
        startDrawIndex = 1;
    }
    if (startDrawIndex + self.countOfshowCandle > self.dataSet.data.count) {
        return;
    }
    _startDrawIndex = startDrawIndex;
}

-(void)setupData:(YKLineDataSet *)dataSet
{
    self.dataSet = dataSet;
}
- (void)setCurrentDataMaxAndMin
{
    
    if (0 == self.startDrawIndex) {
        self.startDrawIndex = self.dataSet.data.count - self.countOfshowCandle;
    }
    
    
    if (self.dataSet.data.count > 0) {
        self.maxPrice = CGFLOAT_MIN;
        self.minPrice = CGFLOAT_MAX;
        self.maxVolume = CGFLOAT_MIN;
        
        NSInteger idx = self.startDrawIndex;
        for (NSInteger i = idx; i < self.dataSet.data.count; i++) {
            YKLineEntity  * entity = [self.dataSet.data objectAtIndex:i];
            self.minPrice = self.minPrice < entity.low ? self.minPrice : entity.low;
            self.maxPrice = self.maxPrice > entity.high ? self.maxPrice : entity.high;
            self.maxVolume = self.maxVolume >entity.volume ? self.maxVolume : entity.volume;
        }
    }
    NSLog(@"%lf,%lf",self.minPrice,self.maxPrice);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    [self setCurrentDataMaxAndMin];

    CGContextRef optionalContext = UIGraphicsGetCurrentContext();
    
    [self drawGridBackground:optionalContext rect:rect];
    
    //[self drawHighlighted:optionalContext point:CGPointMake(50, 50)];
    [self drawCandle:optionalContext];
    
}

- (void)drawGridBackground:(CGContextRef)context
                      rect:(CGRect)rect;
{
    
    CGContextSetFillColorWithColor(context, self.gridBackgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    //画边框
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(self.contentLeft, self.contentTop, self.contentWidth, (self.uperChartHeightScale * self.contentHeight)));
    CGContextStrokeRect(context, CGRectMake(self.contentLeft, (self.uperChartHeightScale * self.contentHeight)+self.xAxisHeitht, self.contentWidth, (self.contentBottom - (self.uperChartHeightScale * self.contentHeight)-self.xAxisHeitht)));
    
    //画中间的线
    [self drawline:context startPoint:CGPointMake(self.contentLeft,(self.uperChartHeightScale * self.contentHeight)/2.0 + self.contentTop) stopPoint:CGPointMake(self.contentRight, (self.uperChartHeightScale * self.contentHeight)/2.0 + self.contentTop) color:self.borderColor lineWidth:self.borderWidth/2.0];

}

- (void)drawCandle:(CGContextRef)context
{
    CGContextSaveGState(context);

    NSInteger idex = self.startDrawIndex;
    self.candleCoordsScale = (self.uperChartHeightScale * self.contentHeight)/(self.maxPrice-self.minPrice);
    self.volumeCoordsScale = (self.contentHeight - (self.uperChartHeightScale * self.contentHeight)-self.xAxisHeitht)/(self.maxVolume - 0);
    for (NSInteger i = idex ; i< self.dataSet.data.count; i ++) {
        
        YKLineEntity  * entity  = [self.dataSet.data objectAtIndex:i];
        
        CGFloat open = ((self.maxPrice - entity.open) * self.candleCoordsScale) + self.contentTop;
        CGFloat close = ((self.maxPrice - entity.close) * self.candleCoordsScale) + self.contentTop;
        CGFloat high = ((self.maxPrice - entity.high) * self.candleCoordsScale) + self.contentTop;
        CGFloat low = ((self.maxPrice - entity.low) * self.candleCoordsScale) + self.contentTop;
        CGFloat left = (self.candleWidth * (i - idex) + self.contentLeft) + self.candleWidth / 6.0;
        
        CGFloat candleWidth = self.candleWidth - self.candleWidth / 6.0;
        CGFloat startX = left + candleWidth/2.0 ;
        
        UIColor * color = self.dataSet.candleRiseColor;
        if (open < close) {
            color = self.dataSet.candleFallColor;
            
            [self drawRect:context rect:CGRectMake(left, open, candleWidth, close-open) color:color];
            [self drawline:context startPoint:CGPointMake(startX, high) stopPoint:CGPointMake(startX, low) color:color lineWidth:self.dataSet.candleTopBottmLineWidth];
        }
        else if (open == close) {
            if (i > 1) {
                YKLineEntity * lastEntity = [self.dataSet.data objectAtIndex:i-1];
                if (lastEntity.close > entity.close) {
                    color = self.dataSet.candleFallColor;
                }
            }
            [self drawRect:context rect:CGRectMake(left, open, candleWidth, 1.5) color:color];
            [self drawline:context startPoint:CGPointMake(startX, high) stopPoint:CGPointMake(startX, low) color:color lineWidth:self.dataSet.candleTopBottmLineWidth];
        } else {
            color = self.dataSet.candleRiseColor;
            [self drawRect:context rect:CGRectMake(left, close, candleWidth, open-close) color:color];
            [self drawline:context startPoint:CGPointMake(startX, high) stopPoint:CGPointMake(startX, low) color:color lineWidth:self.dataSet.candleTopBottmLineWidth];
        }
       
        
        if (i > 0){
            YKLineEntity * lastEntity = [self.dataSet.data objectAtIndex:i -1];
            CGFloat lastX = startX - self.candleWidth;
            
            CGFloat lastY5 = (self.maxPrice - lastEntity.ma5)*self.candleCoordsScale + self.contentTop;
            CGFloat  y5 = (self.maxPrice - entity.ma5)*self.candleCoordsScale  + self.contentTop;
            [self drawline:context startPoint:CGPointMake(lastX, lastY5) stopPoint:CGPointMake(startX, y5) color:self.dataSet.avgMA5Color lineWidth:self.dataSet.avgLineWidth];
            
            CGFloat lastY10 = (self.maxPrice - lastEntity.ma10)*self.candleCoordsScale  + self.contentTop;
            CGFloat  y10 = (self.maxPrice - entity.ma10)*self.candleCoordsScale  + self.contentTop;
            [self drawline:context startPoint:CGPointMake(lastX, lastY10) stopPoint:CGPointMake(startX, y10) color:self.dataSet.avgMA10Color lineWidth:self.dataSet.avgLineWidth];
            
            CGFloat lastY20 = (self.maxPrice - lastEntity.ma20)*self.candleCoordsScale  + self.contentTop;
            CGFloat  y20 = (self.maxPrice - entity.ma20)*self.candleCoordsScale  + self.contentTop;
            [self drawline:context startPoint:CGPointMake(lastX, lastY20) stopPoint:CGPointMake(startX, y20) color:self.dataSet.avgMA20Color lineWidth:self.dataSet.avgLineWidth];
        }
        
        //成交量
        CGFloat volume = ((entity.volume - 0) * self.volumeCoordsScale);
        [self drawRect:context rect:CGRectMake(left, self.contentBottom - volume , candleWidth, volume) color:color];
        
    }


    CGContextRestoreGState(context);
}

- (void)drawRect:(CGContextRef)context
            rect:(CGRect)rect
           color:(UIColor*)color
{
    if ((rect.origin.x + rect.size.width) > self.contentRight) {
        return;
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
}

- (void)drawline:(CGContextRef)context
      startPoint:(CGPoint)startPoint
       stopPoint:(CGPoint)stopPoint
           color:(UIColor *)color
       lineWidth:(CGFloat)lineWitdth
{
    if (startPoint.x < self.contentLeft ||stopPoint.x >self.contentRight || startPoint.y <self.contentTop || stopPoint.y < self.contentTop) {
        return;
    }
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, lineWitdth);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, stopPoint.x,stopPoint.y);
    CGContextStrokePath(context);
}

- (void)drawHighlighted:(CGContextRef)context
                point:(CGPoint)point
{
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, .5);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, point.x, self.contentTop);
    CGContextAddLineToPoint(context, point.x, self.contentBottom);
    CGContextStrokePath(context);
    
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.contentLeft, point.y);
    CGContextAddLineToPoint(context, self.contentRight, point.y);
    CGContextStrokePath(context);
}

- (UIPanGestureRecognizer *)panGesture
{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGestureAction:)];
    }
    return _panGesture;
}
- (void)handlePanGestureAction:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint point = [recognizer translationInView:self];
    NSLog(@"平移,%lf,%lf",point.x,point.y);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (point.x > 0) {
            self.startDrawIndex -= point.x/self.candleWidth;
        }else{
            self.startDrawIndex += (-point.x)/self.candleWidth;
        }
        [self notifyDataSetChanged];
    }
}
- (void)notifyDataSetChanged
{
    [super notifyDataSetChanged];
    [self setNeedsDisplay];
}
- (void)notifyDeviceOrientationChanged
{
    [super notifyDeviceOrientationChanged];
    self.startDrawIndex = self.dataSet.data.count - self.countOfshowCandle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
