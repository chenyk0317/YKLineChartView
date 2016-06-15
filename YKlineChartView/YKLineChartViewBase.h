//
//  YKLineChartViewBase.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView

#import <UIKit/UIKit.h>
#import "YKViewBase.h"


@protocol YKLineChartViewDelegate <NSObject>

@optional
- (void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex;
- (void)chartValueNothingSelected:(YKViewBase *)chartView;

- (void)chartKlineScrollLeft:(YKViewBase *)chartView;


@end

@interface YKLineChartViewBase : YKViewBase


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

@property (nonatomic,strong)NSDictionary * leftYAxisAttributedDic;
@property (nonatomic,strong)NSDictionary * xAxisAttributedDic;
@property (nonatomic,strong)NSDictionary * highlightAttributedDic;
@property (nonatomic,strong)NSDictionary * defaultAttributedDic;

@property (nonatomic,assign)BOOL highlightLineShowEnabled;
@property (nonatomic,assign)BOOL scrollEnabled;
@property (nonatomic,assign)BOOL zoomEnabled;

@property (nonatomic,assign)BOOL leftYAxisIsInChart;
@property (nonatomic,assign)BOOL rightYAxisDrawEnabled;

@property (nonatomic,assign)id<YKLineChartViewDelegate>  delegate;


@property (nonatomic,assign)BOOL isETF;


- (void)drawline:(CGContextRef)context
      startPoint:(CGPoint)startPoint
       stopPoint:(CGPoint)stopPoint
           color:(UIColor *)color
       lineWidth:(CGFloat)lineWitdth;

- (void)drawLabelPrice:(CGContextRef)context;

//圆点
-(void)drawCiclyPoint:(CGContextRef)context
                point:(CGPoint)point
               radius:(CGFloat)radius
                color:(UIColor*)color;
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
