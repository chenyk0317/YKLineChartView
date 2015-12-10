//
//  YKlineChartViewBase.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKViewBase.h"
@interface YKlineChartViewBase : YKViewBase


@property (nonatomic,assign) CGFloat uperChartHeightScale;
@property (nonatomic,assign) CGFloat xAxisHeitht;

@property (nonatomic,strong) UIColor *gridBackgroundColor;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;


@property (nonatomic,assign)CGFloat maxPrice;
@property (nonatomic,assign)CGFloat minPrice;
@property (nonatomic,assign)CGFloat maxVolume;
@property (nonatomic,assign)CGFloat candleCoordsScale;
@property (nonatomic,assign)CGFloat volumeCoordsScale;

@property (nonatomic,assign)NSInteger highlightLineCurrentIndex;
@property (nonatomic,assign)CGPoint highlightLineCurrentPoint;
@property (nonatomic,assign)BOOL highlightLineCurrentEnabled;



- (void)drawline:(CGContextRef)context
      startPoint:(CGPoint)startPoint
       stopPoint:(CGPoint)stopPoint
           color:(UIColor *)color
       lineWidth:(CGFloat)lineWitdth;

- (void)drawLabelPrice:(CGContextRef)context;


- (void)drawHighlighted:(CGContextRef)context
                  point:(CGPoint)point
                   idex:(NSInteger)idex
                  value:(id)value
                  color:(UIColor *)color
              lineWidth:(CGFloat)lineWidth;


- (void)drawLabel:(CGContextRef)context
   attributesText:(NSAttributedString *)attributesText
             rect:(CGRect)rect;

- (void)drawRect:(CGContextRef)context
            rect:(CGRect)rect
           color:(UIColor*)color;


- (void)drawGridBackground:(CGContextRef)context
                      rect:(CGRect)rect;



@end
