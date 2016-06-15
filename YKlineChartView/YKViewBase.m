//
//  YKViewBase.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/10.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView

#import "YKViewBase.h"

@interface YKViewBase()
@property (nonatomic,assign)CGFloat offsetLeft;
@property (nonatomic,assign)CGFloat offsetTop;
@property (nonatomic,assign)CGFloat offsetRight;
@property (nonatomic,assign)CGFloat offsetBottom;
@end
@implementation YKViewBase

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver];
//        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver];
//        [self commonInit];

    }
    return self;
}
- (void)addObserver
{
    //@2016-5-16 by Liuk autolayout不会触发bounds, frame
//    [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}
//- (void)commonInit {
//    
//    //[self setChartDimens:self.bounds.size.width height:self.bounds.size.height];
//    
//}
- (void)dealloc
{
//    [self removeObserver:self forKeyPath:@"bounds"];
//    [self removeObserver:self forKeyPath:@"frame"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
//@2016-5-16 by Liuk autolayout不会触发bounds, frame
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"bounds"] || [keyPath isEqualToString: @"frame"])
//    {
//        CGRect  bounds = self.bounds;
//        
//        if ((bounds.size.width != self.chartWidth ||
//             bounds.size.height != self.chartHeight))
//        {
//            [self setChartDimens:bounds.size.width height:bounds.size.height];
//            [self notifyDataSetChanged];
//            
//        }
//    }
//    
//}

-(void)layoutSubviews{
    //@2016-5-16 byliukai， 布局调整
    CGRect  bounds = self.bounds;
    if ((bounds.size.width != self.chartWidth ||
         bounds.size.height != self.chartHeight))
    {
        [self setChartDimens:bounds.size.width height:bounds.size.height];
        [self notifyDataSetChanged];
        
    }
}
-(void) deviceOrientationDidChange:(NSNotification *) notification
{
    if([UIDevice currentDevice].orientation!=UIDeviceOrientationUnknown)
    {
        [self notifyDeviceOrientationChanged];
    }
}

- (void)notifyDeviceOrientationChanged
{
    
}
- (void)notifyDataSetChanged
{
    [self setNeedsDisplay];

}

- (void)setupChartOffsetWithLeft:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom
{
    self.offsetLeft = left;
    self.offsetRight = right;
    self.offsetTop = top;
    self.offsetBottom = bottom;
    //by LiuK 需要设置_contentRect
    [self restrainViewPort:left top:top right:right bottom:bottom];
    
}
- (void)setChartDimens:(CGFloat)width
                height:(CGFloat)height
{
    CGFloat offsetLeft = self.offsetLeft;
    CGFloat offsetTop = self.offsetTop;
    CGFloat offsetRight = self.offsetRight;
    CGFloat offsetBottom = self.offsetBottom;
    self.chartHeight = height;
    self.chartWidth = width;
    [self restrainViewPort:offsetLeft top:offsetTop right:offsetRight bottom:offsetBottom];
}
- (void)restrainViewPort:(CGFloat)offsetLeft
                     top:(CGFloat)offsetTop
                   right:(CGFloat)offsetRight
                  bottom:(CGFloat)offsetBottom
{
    _contentRect.origin.x = offsetLeft;
    _contentRect.origin.y = offsetTop;
    _contentRect.size.width = self.chartWidth - offsetLeft - offsetRight;
    _contentRect.size.height = self.chartHeight - offsetBottom - offsetTop;
}


- (BOOL)isInBoundsX:(CGFloat)x
{
    if ([self isInBoundsLeft:x] && [self isInBoundsRight:x])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isInBoundsY:(CGFloat)y
{
    if ([self isInBoundsTop:y] &&[self isInBoundsBottom:y])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isInBoundsX:(CGFloat)x y:(CGFloat)y
{
    if ([ self isInBoundsX:x] && [self isInBoundsY:y])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isInBoundsLeft:(CGFloat)x
{
    return _contentRect.origin.x <= x ? YES : NO;
}
- (BOOL)isInBoundsRight:(CGFloat)x
{
    CGFloat normalizedX = ((NSInteger)(x * 100.f))/100.f;
    return (_contentRect.origin.x + _contentRect.size.width) >= normalizedX ? YES : NO;
}
- (BOOL)isInBoundsTop:(CGFloat)y
{
    return _contentRect.origin.y <= y ? YES : NO;
}
- (BOOL)isInBoundsBottom:(CGFloat)y
{
    CGFloat normalizedY = ((NSInteger)(y * 100.f))/100.f;
    return (_contentRect.origin.y + _contentRect.size.height) >= normalizedY ? YES : NO;
    
}
- (CGFloat)contentTop
{
    return _contentRect.origin.y;
}

- (CGFloat)contentLeft
{
    return _contentRect.origin.x;
}
- (CGFloat)contentRight
{
    return _contentRect.origin.x + _contentRect.size.width;
}
- (CGFloat)contentBottom
{
    return _contentRect.origin.y + _contentRect.size.height;
}
- (CGFloat)contentWidth
{
    return _contentRect.size.width;
}
- (CGFloat)contentHeight
{
    return _contentRect.size.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
