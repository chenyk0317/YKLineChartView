//
//  YKlineChartViewBase.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKlineChartViewBase : UIView


@property (nonatomic,assign) CGRect contentRect;
@property (nonatomic,assign) CGFloat uperChartHeightScale;
@property (nonatomic,assign) CGFloat xAxisHeitht;
@property (nonatomic,assign) CGFloat chartHeight;
@property (nonatomic,assign) CGFloat chartWidth;
@property (nonatomic,strong) UIColor *gridBackgroundColor;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;


- (void)setupChartOffsetWithLeft:(CGFloat)left
                             top:(CGFloat)top
                           right:(CGFloat)right
                          bottom:(CGFloat)bottom;

- (void)commonInit;

- (void)notifyDataSetChanged;

- (void)notifyDeviceOrientationChanged;
- (BOOL)isInBoundsX:(CGFloat)x;

- (BOOL)isInBoundsY:(CGFloat)y;

- (BOOL)isInBoundsX:(CGFloat)x
                  y:(CGFloat)y;

- (BOOL)isInBoundsLeft:(CGFloat)x;
- (BOOL)isInBoundsRight:(CGFloat)x;

- (BOOL)isInBoundsTop:(CGFloat)y;

- (BOOL)isInBoundsBottom:(CGFloat)y;

- (CGFloat)contentTop;
- (CGFloat)contentLeft;
- (CGFloat)contentRight;
- (CGFloat)contentBottom;
- (CGFloat)contentWidth;
- (CGFloat)contentHeight;

@end
