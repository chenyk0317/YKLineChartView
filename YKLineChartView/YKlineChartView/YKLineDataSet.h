//
//  YKLineDataSet.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YKLineDataSet : NSObject
@property (nonatomic,strong)NSMutableArray * data;
@property (nonatomic,assign)CGFloat highlightLineWidth;
@property (nonatomic,strong)UIColor  * highlightLineColor;
@property (nonatomic,strong)UIColor * candleRiseColor;
@property (nonatomic,strong)UIColor * candleFallColor;
@property (nonatomic,strong)UIColor * avgMA5Color;
@property (nonatomic,strong)UIColor * avgMA10Color;
@property (nonatomic,strong)UIColor * avgMA20Color;
@property (nonatomic,assign)CGFloat  avgLineWidth;
@property (nonatomic,assign)CGFloat candleTopBottmLineWidth;
@property (nonatomic,assign)CGFloat candleWidth;
@property (nonatomic,assign)CGFloat candleMaxWidth;
@property (nonatomic,assign)CGFloat candleMinWidth;

@end
