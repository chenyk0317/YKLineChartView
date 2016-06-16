//
//  YKViewBase.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/10.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView

#import <UIKit/UIKit.h>
/**
 *  @author LiuK, 16-05-16 17:05:55
 *
 *  1、修复view在autolayout下计算Frame的BUG
 */
@interface YKViewBase : UIView
@property (nonatomic,assign) CGRect contentRect;
@property (nonatomic,assign) CGFloat chartHeight;
@property (nonatomic,assign) CGFloat chartWidth;




- (void)setupChartOffsetWithLeft:(CGFloat)left
                             top:(CGFloat)top
                           right:(CGFloat)right
                          bottom:(CGFloat)bottom;

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
