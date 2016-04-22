//
//  KLineChartViewController.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/12.
//  Copyright © 2015年 chenyk. All rights reserved.
//  https://github.com/chenyk0317/YKLineChartView
//

#import "KLineChartViewController.h"
#import "YKLineChart.h"
@interface KLineChartViewController ()<YKLineChartViewDelegate>
@property (weak, nonatomic) IBOutlet YKLineChartView *klineView;

@end

@implementation KLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * path =[[NSBundle mainBundle]pathForResource:@"data.plist" ofType:nil];
    NSArray * sourceArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data"];
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * dic in sourceArray) {
        
        YKLineEntity * entity = [[YKLineEntity alloc]init];
        entity.high = [dic[@"high_px"] doubleValue];
        entity.open = [dic[@"open_px"] doubleValue];
        
        entity.low = [dic[@"low_px"] doubleValue];
        
        entity.close = [dic[@"close_px"] doubleValue];
        
        entity.date = dic[@"date"];
        entity.ma5 = [dic[@"avg5"] doubleValue];
        entity.ma10 = [dic[@"avg10"] doubleValue];
        entity.ma20 = [dic[@"avg20"] doubleValue];
        entity.volume = [dic[@"total_volume_trade"] doubleValue];
        [array addObject:entity];
        //YTimeLineEntity * entity = [[YTimeLineEntity alloc]init];
    }
    [array addObjectsFromArray:array];
    YKLineDataSet * dataset = [[YKLineDataSet alloc]init];
    dataset.data = array;
    dataset.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    dataset.highlightLineWidth = 0.7;
    dataset.candleRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
    dataset.candleFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];
    dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];
    dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];
    dataset.candleTopBottmLineWidth = 1;
    
    [self.klineView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.klineView.gridBackgroundColor = [UIColor whiteColor];
    self.klineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
    self.klineView.borderWidth = .5;
    self.klineView.candleWidth = 8;
    self.klineView.candleMaxWidth = 30;
    self.klineView.candleMinWidth = 1;
    self.klineView.uperChartHeightScale = 0.7;
    self.klineView.xAxisHeitht = 25;
    self.klineView.delegate = self;
    self.klineView.highlightLineShowEnabled = YES;
    self.klineView.zoomEnabled = YES;
    self.klineView.scrollEnabled = YES;
    [self.klineView setupData:dataset];
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
