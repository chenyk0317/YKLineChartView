//
//  ViewController.h
//  YKLineChartView
//
//  Created by chenyk on 15/12/8.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKlineChartView/YKLineChart.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet YKLineChartView *TestView;
@property (weak, nonatomic) IBOutlet YKTimeLineView *timeView;
@property (weak, nonatomic) IBOutlet UIButton *testbutton;

@end

