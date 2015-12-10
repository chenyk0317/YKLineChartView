//
//  YKlineChartView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKLineChartViewBase.h"
#import "YKLineDataSet.h"
@interface YKlineChartView : YKLineChartViewBase


@property (nonatomic,assign)CGFloat candleWidth;
@property (nonatomic,assign)CGFloat candleMaxWidth;
@property (nonatomic,assign)CGFloat candleMinWidth;

- (void)setupData:(YKLineDataSet *)dataSet;

@end