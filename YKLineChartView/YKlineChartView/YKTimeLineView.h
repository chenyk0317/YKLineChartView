//
//  YKTimeLineView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/10.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKlineChartViewBase.h"
#import "YKLineDataSet.h"

@interface YKTimeLineView : YKlineChartViewBase


@property (nonatomic,assign)CGFloat offsetMaxPrice;
@property (nonatomic,assign)NSInteger countOfTimes;

- (void)setupData:(YKTimeDataset *)dataSet;
@end
