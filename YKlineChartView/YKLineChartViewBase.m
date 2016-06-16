//
//  YKLineChartViewBase.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView

#import "YKLineChartViewBase.h"
#import "YKLineEntity.h"
@interface YKLineChartViewBase()


@end
@implementation YKLineChartViewBase
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //        [self commonInit];
        
    }
    return self;
}

//- (void)commonInit {
//
//
//}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}
- (void)drawGridBackground:(CGContextRef)context
                      rect:(CGRect)rect;
{
    UIColor * backgroundColor = self.gridBackgroundColor?:[UIColor whiteColor];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    //画边框
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(self.contentLeft, self.contentTop, self.contentWidth, (self.uperChartHeightScale * self.contentHeight)));
    
    CGContextStrokeRect(context, CGRectMake(self.contentLeft, (self.uperChartHeightScale * self.contentHeight)+self.xAxisHeitht, self.contentWidth, (self.contentBottom - (self.uperChartHeightScale * self.contentHeight)-self.xAxisHeitht)));
    
    //画中间的线
    [self drawline:context startPoint:CGPointMake(self.contentLeft,(self.uperChartHeightScale * self.contentHeight)/2.0 + self.contentTop) stopPoint:CGPointMake(self.contentRight, (self.uperChartHeightScale * self.contentHeight)/2.0 + self.contentTop) color:self.borderColor lineWidth:self.borderWidth/2.0];
    
}

- (void)drawLabelPrice:(CGContextRef)context
{
    
    UIColor * labelBGColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    NSDictionary * drawAttributes = self.leftYAxisAttributedDic?:self.defaultAttributedDic;
    //@2016-5-12 by Liuk, 价格统一往左移2个像素，价格标签把图标的线遮挡了
    NSString * maxPriceStr = [self handleStrWithPrice:self.maxPrice];
    NSMutableAttributedString * maxPriceAttStr = [[NSMutableAttributedString alloc]initWithString:maxPriceStr attributes:drawAttributes];
    CGSize sizeMaxPriceAttStr = [maxPriceAttStr size];
    CGRect maxPriceRect = CGRectMake(self.contentLeft - (self.leftYAxisIsInChart?0:sizeMaxPriceAttStr.width+2), self.contentTop, sizeMaxPriceAttStr.width, sizeMaxPriceAttStr.height);
    [self drawRect:context rect:maxPriceRect color:labelBGColor];
    [self drawLabel:context attributesText:maxPriceAttStr rect:maxPriceRect];
    
    NSString * midPriceStr = [self handleStrWithPrice:(self.maxPrice+self.minPrice)/2.0];
    NSMutableAttributedString * midPriceAttStr = [[NSMutableAttributedString alloc]initWithString:midPriceStr attributes:drawAttributes];
    CGSize sizeMidPriceAttStr = [midPriceAttStr size];
    CGRect midPriceRect = CGRectMake(self.contentLeft - (self.leftYAxisIsInChart?0:sizeMidPriceAttStr.width+2), ((self.uperChartHeightScale * self.contentHeight)/2.0 + self.contentTop)-sizeMidPriceAttStr.height/2.0, sizeMidPriceAttStr.width, sizeMidPriceAttStr.height);
    [self drawRect:context rect:midPriceRect color:labelBGColor];
    [self drawLabel:context attributesText:midPriceAttStr rect:midPriceRect];
    
    NSString * minPriceStr = [self handleStrWithPrice:self.minPrice];
    NSMutableAttributedString * minPriceAttStr = [[NSMutableAttributedString alloc]initWithString:minPriceStr attributes:drawAttributes];
    CGSize sizeMinPriceAttStr = [minPriceAttStr size];
    CGRect minPriceRect = CGRectMake(self.contentLeft - (self.leftYAxisIsInChart?0:sizeMinPriceAttStr.width+2), ((self.uperChartHeightScale * self.contentHeight) + self.contentTop - sizeMinPriceAttStr.height ), sizeMinPriceAttStr.width, sizeMinPriceAttStr.height);
    [self drawRect:context rect:minPriceRect color:labelBGColor];
    [self drawLabel:context attributesText:minPriceAttStr rect:minPriceRect];
    
    NSMutableAttributedString * zeroVolumeAttStr = [[NSMutableAttributedString alloc]initWithString:[self handleShowWithVolume:self.maxVolume] attributes:drawAttributes];
    CGSize zeroVolumeAttStrSize = [zeroVolumeAttStr size];
    CGRect zeroVolumeRect = CGRectMake(self.contentLeft - (self.leftYAxisIsInChart?0:zeroVolumeAttStrSize.width+2), self.contentBottom - zeroVolumeAttStrSize.height, zeroVolumeAttStrSize.width, zeroVolumeAttStrSize.height);
    [self drawRect:context rect:zeroVolumeRect color:labelBGColor];
    [self drawLabel:context attributesText:zeroVolumeAttStr rect:zeroVolumeRect];
    
    NSString * maxVolumeStr = [self handleShowNumWithVolume:self.maxVolume];
    NSMutableAttributedString * maxVolumeAttStr = [[NSMutableAttributedString alloc]initWithString:maxVolumeStr attributes:drawAttributes];
    CGSize maxVolumeAttStrSize = [maxVolumeAttStr size];
    CGRect maxVolumeRect = CGRectMake(self.contentLeft - (self.leftYAxisIsInChart?0:maxVolumeAttStrSize.width+2), (self.uperChartHeightScale * self.contentHeight)+self.xAxisHeitht, maxVolumeAttStrSize.width, maxVolumeAttStrSize.height);
    [self drawRect:context rect:maxVolumeRect color:labelBGColor];
    [self drawLabel:context attributesText:maxVolumeAttStr rect:maxVolumeRect];
    
    
    if (self.rightYAxisDrawEnabled) {
        NSString * maxRateStr = [self handleRateWithPrice:self.maxPrice originPX:(self.maxPrice+self.minPrice)/2.0];
        NSMutableAttributedString * maxRateAttStr = [[NSMutableAttributedString alloc]initWithString:maxRateStr attributes:drawAttributes];
        CGSize sizeMaxRateAttStr = [maxRateAttStr size];
        CGRect maxRateRect = CGRectMake(self.contentRight- (self.leftYAxisIsInChart?sizeMaxRateAttStr.width:0), self.contentTop, sizeMaxRateAttStr.width, sizeMaxRateAttStr.height);
        [self drawRect:context rect:maxRateRect color:labelBGColor];
        [self drawLabel:context attributesText:maxRateAttStr rect:maxRateRect];
        
        NSString * minRateStr = [self handleRateWithPrice:self.minPrice originPX:(self.maxPrice+self.minPrice)/2.0];
        NSMutableAttributedString * minRateAttStr = [[NSMutableAttributedString alloc]initWithString:minRateStr attributes:drawAttributes];
        CGSize sizeMinRateAttStr = [minRateAttStr size];
        CGRect minRateRect = CGRectMake(self.contentRight-(self.leftYAxisIsInChart?sizeMinRateAttStr.width:0), ((self.uperChartHeightScale * self.contentHeight) + self.contentTop - sizeMinRateAttStr.height ), sizeMinRateAttStr.width, sizeMinRateAttStr.height);
        [self drawRect:context rect:minRateRect color:labelBGColor];
        [self drawLabel:context attributesText:minRateAttStr rect:minRateRect];
    }
    
}


- (void)drawHighlighted:(CGContextRef)context
                  point:(CGPoint)point
                   idex:(NSInteger)idex
                  value:(id)value
                  color:(UIColor *)color
              lineWidth:(CGFloat)lineWidth
{
    
    NSString * leftMarkerStr = @"";
    NSString * bottomMarkerStr = @"";
    NSString * rightMarkerStr = @"";
    NSString * volumeMarkerStr = @"";
    
    
    if ([value isKindOfClass:[YKTimeLineEntity class]]) {
        YKTimeLineEntity * entity = value;
        leftMarkerStr = [self handleStrWithPrice:entity.lastPirce];
        bottomMarkerStr = entity.currtTime;
        rightMarkerStr = entity.rate;
        
    }else if([value isKindOfClass:[YKLineEntity class]]){
        YKLineEntity * entity = value;
        leftMarkerStr = [self handleStrWithPrice:entity.close];
        bottomMarkerStr = entity.date;
        volumeMarkerStr = [NSString stringWithFormat:@"%@%@",[self handleShowNumWithVolume:entity.volume],[self handleShowWithVolume:entity.volume]];
    }else{
        return;
    }
    
    if (nil == leftMarkerStr || nil == bottomMarkerStr || nil == rightMarkerStr) {
        return;
    }
    bottomMarkerStr = [[@" " stringByAppendingString:bottomMarkerStr] stringByAppendingString:@" "];
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, point.x, self.contentTop);
    CGContextAddLineToPoint(context, point.x, self.contentBottom);
    CGContextStrokePath(context);
    
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.contentLeft, point.y);
    CGContextAddLineToPoint(context, self.contentRight, point.y);
    CGContextStrokePath(context);
    
    CGFloat radius = 3.0;
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(point.x-(radius/2.0), point.y-(radius/2.0), radius, radius));
    
    
    NSDictionary * drawAttributes = self.highlightAttributedDic?:self.defaultAttributedDic;
    
    
    NSMutableAttributedString * leftMarkerStrAtt = [[NSMutableAttributedString alloc]initWithString:leftMarkerStr attributes:drawAttributes];
    
    CGSize leftMarkerStrAttSize = [leftMarkerStrAtt size];
    [self drawLabel:context attributesText:leftMarkerStrAtt rect:CGRectMake(self.contentLeft - leftMarkerStrAttSize.width,point.y - leftMarkerStrAttSize.height/2.0, leftMarkerStrAttSize.width, leftMarkerStrAttSize.height)];
    
    
    NSMutableAttributedString * bottomMarkerStrAtt = [[NSMutableAttributedString alloc]initWithString:bottomMarkerStr attributes:drawAttributes];
    
    CGSize bottomMarkerStrAttSize = [bottomMarkerStrAtt size];
    CGRect rect = CGRectMake(point.x - bottomMarkerStrAttSize.width/2.0,  ((self.uperChartHeightScale * self.contentHeight) + self.contentTop), bottomMarkerStrAttSize.width, bottomMarkerStrAttSize.height);
    if (rect.size.width + rect.origin.x > self.contentRight) {
        rect.origin.x = self.contentRight -rect.size.width;
    }
    if (rect.origin.x < self.contentLeft) {
        rect.origin.x = self.contentLeft;
    }
    [self drawLabel:context attributesText:bottomMarkerStrAtt rect:rect];
    
    
    NSMutableAttributedString * rightMarkerStrAtt = [[NSMutableAttributedString alloc]initWithString:rightMarkerStr attributes:drawAttributes];
    CGSize rightMarkerStrAttSize = [rightMarkerStrAtt size];
    [self drawLabel:context attributesText:rightMarkerStrAtt rect:CGRectMake(self.contentRight, point.y - rightMarkerStrAttSize.height/2.0, rightMarkerStrAttSize.width, rightMarkerStrAttSize.height)];
    
    NSMutableAttributedString * volumeMarkerStrAtt = [[NSMutableAttributedString alloc]initWithString:volumeMarkerStr attributes:drawAttributes];
    CGSize volumeMarkerStrAttSize = [volumeMarkerStrAtt size];
    [self drawLabel:context attributesText:volumeMarkerStrAtt rect:CGRectMake(self.contentLeft,  self.contentHeight * self.uperChartHeightScale+self.xAxisHeitht, volumeMarkerStrAttSize.width, volumeMarkerStrAttSize.height)];
    
    
    
}

- (void)drawLabel:(CGContextRef)context
   attributesText:(NSAttributedString *)attributesText
             rect:(CGRect)rect
{
    [attributesText drawInRect:rect];
    //[self drawRect:context rect:rect color:[UIColor clearColor]];
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
-(void)drawCiclyPoint:(CGContextRef)context
                point:(CGPoint)point
               radius:(CGFloat)radius
                color:(UIColor*)color{
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);//线的宽度
    CGContextAddArc(context, point.x, point.y, radius, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
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


- (NSString *)handleRateWithPrice:(CGFloat)price
                         originPX:(CGFloat)originPX
{
    
    if (0 == originPX) {
        return @"--";
    }
    CGFloat rate = (price - originPX)/originPX *100.00;
    if(rate >0){
        return [NSString stringWithFormat:@"+%.2f%@",rate,@"%"];
        
    }
    return [NSString stringWithFormat:@"%.2f%@",rate,@"%"];
}

- (NSString *)handleStrWithPrice:(CGFloat)price
{
    if (self.isETF) {
        return [NSString stringWithFormat:@"%.3f ",price];
    }
    return [NSString stringWithFormat:@"%.2f ",price];
}
- (NSString *)handleShowWithVolume:(CGFloat)volume
{
    volume = volume/100.0;
    
    if (volume < 10000.0) {
        return @"手 ";
    }else if (volume > 10000.0 && volume < 100000000.0){
        return @"万手 ";
    }else{
        return @"亿手 ";
    }
}
- (NSString *)handleShowNumWithVolume:(CGFloat)volume
{
    volume = volume/100.0;
    if (volume < 10000.0) {
        return [NSString stringWithFormat:@"%.0f ",volume];
    }else if (volume > 10000.0 && volume < 100000000.0){
        return [NSString stringWithFormat:@"%.2f ",volume/10000.0];
    }else{
        return [NSString stringWithFormat:@"%.2f ",volume/100000000.0];
    }
}

- (NSDictionary *)defaultAttributedDic
{
    if (!_defaultAttributedDic) {
        _defaultAttributedDic = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSBackgroundColorAttributeName:[UIColor clearColor]};
    }
    return _defaultAttributedDic;
}

- (void)setHighlightLineCurrentEnabled:(BOOL)highlightLineCurrentEnabled
{
    
    if (_highlightLineCurrentEnabled != highlightLineCurrentEnabled) {
        _highlightLineCurrentEnabled = highlightLineCurrentEnabled;
        if ( NO == highlightLineCurrentEnabled) {
            if ([self.delegate respondsToSelector:@selector(chartValueNothingSelected:)]) {
                [self.delegate chartValueNothingSelected:self];
            }
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
