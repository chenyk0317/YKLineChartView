//
//  YKlineChartView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKlineChartViewBase.h"
#import "YKLineDataSet.h"
@interface YKlineChartView : YKlineChartViewBase

- (void)setupData:(YKLineDataSet *)dataSet;

@end