//
//  YKTimeLineView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/10.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView

#import "YKLineChartViewBase.h"
#import "YKLineDataSet.h"

@interface YKTimeLineView : YKLineChartViewBase


@property (nonatomic,assign)CGFloat offsetMaxPrice;
@property (nonatomic,assign)NSInteger countOfTimes;

@property (nonatomic,assign)BOOL endPointShowEnabled;
@property (nonatomic,assign)BOOL isDrawAvgEnabled;

- (void)setupData:(YKTimeDataset *)dataSet;
@end
