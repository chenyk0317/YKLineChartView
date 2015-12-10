//
//  YKTimeLineView.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/10.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKTimeLineView.h"
#import "YKLineEntity.h"
@interface YKTimeLineView()

@property (nonatomic,assign) CGFloat volumeWidth;
@property (nonatomic,strong)YKTimeDataset * dataset;
@property (nonatomic,strong)UILongPressGestureRecognizer * longPressGesture;
@property (nonatomic,strong)UITapGestureRecognizer * tapGesture;

@end
@implementation YKTimeLineView

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

- (CGFloat)volumeWidth
{
    return self.contentWidth/self.countOfTimes;
}
- (void)setupData:(YKTimeDataset *)dataSet
{
    self.dataset = dataSet;
}
- (void)commonInit {
    
    [super commonInit];
    self.candleCoordsScale = 0.f;
    
    [self addGestureRecognizer:self.longPressGesture];
    [self addGestureRecognizer:self.tapGesture];
}


- (void)setCurrentDataMaxAndMin
{
  
    if (self.dataset.data.count > 0) {
        self.maxPrice = CGFLOAT_MIN;
        self.minPrice = CGFLOAT_MAX;
        self.maxVolume = CGFLOAT_MIN;
        self.offsetMaxPrice = CGFLOAT_MIN;
        
        for (NSInteger i = 0; i < self.dataset.data.count; i++) {
            YKTimeLineEntity  * entity = [self.dataset.data objectAtIndex:i];
            
            self.offsetMaxPrice = self.offsetMaxPrice >fabs(entity.lastPirce-entity.preClosePx)?self.offsetMaxPrice:fabs(entity.lastPirce-entity.preClosePx);
            

            
            self.maxVolume = self.maxVolume >entity.volume ? self.maxVolume : entity.volume;
        }
        
        self.maxPrice =((YKTimeLineEntity *)[self.dataset.data firstObject]).preClosePx + self.offsetMaxPrice;
        self.minPrice =((YKTimeLineEntity *)[self.dataset.data firstObject]).preClosePx - self.offsetMaxPrice;
    }
    NSLog(@"%lf,%lf",self.minPrice,self.maxPrice);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setCurrentDataMaxAndMin];
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    [self drawGridBackground:context rect:rect];
    [self drawTimeLine:context];
    [self drawLabelPrice:context];

}

- (void)drawGridBackground:(CGContextRef)context rect:(CGRect)rect
{
    [super drawGridBackground:context rect:rect];
}
- (void)drawTimeLine:(CGContextRef)context
{
    CGContextSaveGState(context);
    
    NSLog(@"%.2f",self.contentWidth);
    NSLog(@"%.2f",self.volumeWidth);
    NSLog(@"%ld",self.countOfTimes);
    
    self.candleCoordsScale = (self.uperChartHeightScale * self.contentHeight)/(self.maxPrice-self.minPrice);
    self.volumeCoordsScale = (self.contentHeight - (self.uperChartHeightScale * self.contentHeight)-self.xAxisHeitht)/(self.maxVolume - 0);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    
    

    for (NSInteger i = 0 ; i< self.dataset.data.count; i ++) {
        
        YKTimeLineEntity  * entity  = [self.dataset.data objectAtIndex:i];
        
        CGFloat left = (self.volumeWidth * i + self.contentLeft) + self.volumeWidth / 6.0;
        
        CGFloat candleWidth = self.volumeWidth - self.volumeWidth / 6.0;
        CGFloat startX = left + candleWidth/2.0 ;
        CGFloat  yPrice = 0;
        
        UIColor * color = self.dataset.volumeRiseColor;
        
        
        
        if (i > 0){
            
            YKTimeLineEntity * lastEntity = [self.dataset.data objectAtIndex:i -1];
            CGFloat lastX = startX - self.volumeWidth;
            
            CGFloat lastYPrice = (self.maxPrice - lastEntity.lastPirce)*self.candleCoordsScale + self.contentTop;
            
            yPrice = (self.maxPrice - entity.lastPirce)*self.candleCoordsScale  + self.contentTop;
            
            [self drawline:context startPoint:CGPointMake(lastX, lastYPrice) stopPoint:CGPointMake(startX, yPrice) color:self.dataset.priceLineCorlor lineWidth:self.dataset.lineWidth];
            
            CGFloat lastYAvg = (self.maxPrice - lastEntity.avgPirce)*self.candleCoordsScale  + self.contentTop;
            CGFloat  yAvg = (self.maxPrice - entity.avgPirce)*self.candleCoordsScale  + self.contentTop;
            [self drawline:context startPoint:CGPointMake(lastX, lastYAvg) stopPoint:CGPointMake(startX, yAvg) color:self.dataset.avgLineCorlor lineWidth:self.dataset.lineWidth];
            
            if (entity.lastPirce > lastEntity.lastPirce) {
                color = self.dataset.volumeRiseColor;
            }else if (entity.lastPirce < lastEntity.lastPirce){
                color = self.dataset.volumeFallColor;
            }else{
                color = self.dataset.volumeTieColor;
            }
            
            if (1 == i) {
                CGPathMoveToPoint(fillPath, NULL, self.contentLeft, (self.uperChartHeightScale * self.contentHeight) + self.contentTop);
                CGPathAddLineToPoint(fillPath, NULL, self.contentLeft,lastYPrice);
                CGPathAddLineToPoint(fillPath, NULL, lastX, lastYPrice);
            }else{
                CGPathAddLineToPoint(fillPath, NULL, startX, yPrice);
            }
            if ((self.dataset.data.count - 1) == i) {
                CGPathAddLineToPoint(fillPath, NULL, startX, yPrice);
                CGPathAddLineToPoint(fillPath, NULL, startX, (self.uperChartHeightScale * self.contentHeight) + self.contentTop);
                CGPathCloseSubpath(fillPath);
            }
        }
        

        
        
    
        
        
        
        //成交量
        CGFloat volume = ((entity.volume - 0) * self.volumeCoordsScale);
        [self drawRect:context rect:CGRectMake(left, self.contentBottom - volume , candleWidth, volume) color:color];
        
        //十字线
        if (self.highlightLineCurrentEnabled) {
            if (i == self.highlightLineCurrentIndex) {
                if (i == 0) {
                    yPrice = (self.maxPrice - entity.lastPirce)*self.candleCoordsScale  + self.contentTop;
                }
                
                YKTimeLineEntity * entity;
                if (i < self.dataset.data.count) {
                    entity = [self.dataset.data objectAtIndex:i];
                }
                [self drawHighlighted:context point:CGPointMake(startX, yPrice) idex:i value:entity color:self.dataset.highlightLineColor lineWidth:self.dataset.highlightLineWidth ];
            }
        }
        
        
    }
    
    
    if (self.dataset.drawFilledEnabled) {
        [self drawLinearGradient:context path:fillPath alpha:self.dataset.fillAlpha startColor:self.dataset.fillColor.CGColor endColor:[UIColor whiteColor].CGColor];
    }
    CGPathRelease(fillPath);
 
    CGContextRestoreGState(context);
}


- (UILongPressGestureRecognizer *)longPressGesture
{
    if (!_longPressGesture) {
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGestureAction:)];
        _longPressGesture.minimumPressDuration = 0.5;
    }
    return _longPressGesture;
}
- (void)handleLongPressGestureAction:(UIPanGestureRecognizer *)recognizer
{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint  point = [recognizer locationInView:self];
        
        if (point.x > self.contentLeft && point.x < self.contentRight && point.y >self.contentTop && point.y<self.contentBottom) {
            self.highlightLineCurrentEnabled = YES;
            [self getHighlightByTouchPoint:point];
        }
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint  point = [recognizer locationInView:self];
        
        if (point.x > self.contentLeft && point.x < self.contentRight && point.y >self.contentTop && point.y<self.contentBottom) {
            self.highlightLineCurrentEnabled = YES;
            [self getHighlightByTouchPoint:point];
        }
    }
}

- (void)getHighlightByTouchPoint:(CGPoint) point
{
    
    self.highlightLineCurrentIndex = (NSInteger)((point.x - self.contentLeft)/self.volumeWidth);
    [self setNeedsDisplay];
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongTapGestureAction:)];
    }
    return _tapGesture;
}
- (void)handleLongTapGestureAction:(UITapGestureRecognizer *)recognizer
{
    if (self.highlightLineCurrentEnabled) {
        self.highlightLineCurrentEnabled = NO;
    }
    [self setNeedsDisplay];
}
- (void)notifyDataSetChanged
{
    [super notifyDataSetChanged];
    [self setNeedsDisplay];
}
- (void)notifyDeviceOrientationChanged
{
    [super notifyDeviceOrientationChanged];
}



- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                     alpha:(CGFloat)alpha
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextSetAlpha(context, self.dataset.fillAlpha);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}
@end
