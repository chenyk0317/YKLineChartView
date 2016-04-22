//
//  TimeLineChartViewController.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/12.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView
//

#import "TimeLineChartViewController.h"
#import "YKLineChart.h"

@interface TimeLineChartViewController ()<YKLineChartViewDelegate>

@property (weak, nonatomic) IBOutlet YKTimeLineView *timeLineView;


@end

@implementation TimeLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * path =[[NSBundle mainBundle]pathForResource:@"data.plist" ofType:nil];

    NSArray * sourceArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data3"];
    NSMutableArray * timeArray = [NSMutableArray array];
    for (NSDictionary * dic in sourceArray) {
        YKTimeLineEntity * e = [[YKTimeLineEntity alloc]init];
        e.currtTime = dic[@"curr_time"];
        e.preClosePx = [dic[@"pre_close_px"] doubleValue];
        e.avgPirce = [dic[@"avg_pirce"] doubleValue];
        e.lastPirce = [dic[@"last_px"]doubleValue];
        e.volume = [dic[@"last_volume_trade"]doubleValue];
        e.rate = dic[@"rise_and_fall_rate"];
        [timeArray addObject:e];
    }
    
    [self.timeLineView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.timeLineView.gridBackgroundColor = [UIColor whiteColor];
    self.timeLineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
    self.timeLineView.borderWidth = .5;
    self.timeLineView.uperChartHeightScale = 0.7;
    self.timeLineView.xAxisHeitht = 25;
    self.timeLineView.countOfTimes = 242;
    self.timeLineView.endPointShowEnabled = YES;
    
    YKTimeDataset * set  = [[YKTimeDataset alloc]init];
    set.data = timeArray;
    set.avgLineCorlor = [UIColor colorWithRed:253/255.0 green:179/255.0 blue:8/255.0 alpha:1.0];
    set.priceLineCorlor = [UIColor colorWithRed:24/255.0 green:96/255.0 blue:254/255.0 alpha:1.0];
    set.lineWidth = 1.f;
    set.highlightLineWidth = .8f;
    set.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    
    set.volumeTieColor = [UIColor grayColor];
    set.volumeRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
    set.volumeFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
    
    set.fillStartColor = [UIColor colorWithRed:24/255.0 green:96/255.0 blue:254/255.0 alpha:1.0];
    set.fillStopColor = [UIColor whiteColor];
    set.fillAlpha = .5f;
    set.drawFilledEnabled = YES;
    self.timeLineView.delegate = self;
    self.timeLineView.highlightLineShowEnabled = YES;
    [self.timeLineView setupData:set];
    
}

-(void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex
{
    
}

- (void)chartValueNothingSelected:(YKViewBase *)chartView
{
}

- (void)chartKlineScrollLeft:(YKViewBase *)chartView
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
