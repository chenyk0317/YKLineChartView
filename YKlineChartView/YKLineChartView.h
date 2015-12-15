//
//  YKLineChartView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "YKLineChartViewBase.h"

@class  YKLineDataSet;
@interface YKLineChartView : YKLineChartViewBase


@property (nonatomic,assign)CGFloat candleWidth;
@property (nonatomic,assign)CGFloat candleMaxWidth;
@property (nonatomic,assign)CGFloat candleMinWidth;


@property (nonatomic,strong)NSDictionary * avgLabelAttributedDic;


- (void)setupData:(YKLineDataSet *)dataSet;

- (void)addDataSetWithArray:(NSArray *)array;
@end