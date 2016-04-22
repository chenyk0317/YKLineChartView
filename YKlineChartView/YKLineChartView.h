//
//  YKLineChartView.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/9.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView

#import "YKLineChartViewBase.h"

@class  YKLineDataSet;
@interface YKLineChartView : YKLineChartViewBase


@property (nonatomic,assign)CGFloat candleWidth;
@property (nonatomic,assign)CGFloat candleMaxWidth;
@property (nonatomic,assign)CGFloat candleMinWidth;

@property (nonatomic,assign)BOOL isShowAvgMarkerEnabled;

@property (nonatomic,strong)NSDictionary * avgLabelAttributedDic;


- (void)setupData:(YKLineDataSet *)dataSet;

- (void)addDataSetWithArray:(NSArray *)array;
@end