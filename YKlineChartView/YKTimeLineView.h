//
//  YKTimeLineView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/10.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKLineChartViewBase.h"
#import "YKLineDataSet.h"

@interface YKTimeLineView : YKLineChartViewBase


@property (nonatomic,assign)CGFloat offsetMaxPrice;
@property (nonatomic,assign)NSInteger countOfTimes;

@property (nonatomic,assign)BOOL endPointShowEnabled;

- (void)setupData:(YKTimeDataset *)dataSet;
@end
