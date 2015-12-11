//
//  ViewController.m
//  YKLineChartView
//
//  Created by chenyk on 15/12/8.
//  Copyright © 2015年 chenyk. All rights reserved.
//

#import "ViewController.h"
#import "YKLineEntity.h"
#import "YKLineDataSet.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()<YKLineChartViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
 
    
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
    [self.klineView setupData:dataset];
    
    
    NSArray * sourceArray2 = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data3"];
    NSMutableArray * timeArray = [NSMutableArray array];
    for (NSDictionary * dic in sourceArray2) {
        YKTimeLineEntity * e = [[YKTimeLineEntity alloc]init];
        e.currtTime = dic[@"curr_time"];
        e.preClosePx = [dic[@"pre_close_px"] doubleValue];
        e.avgPirce = [dic[@"avg_pirce"] doubleValue];
        e.lastPirce = [dic[@"last_px"]doubleValue];
        e.volume = [dic[@"last_volume_trade"]doubleValue];
        e.rate = dic[@"rise_and_fall_rate"];
        [timeArray addObject:e];
    }

    [self.timeView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.timeView.gridBackgroundColor = [UIColor whiteColor];
    self.timeView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
    self.timeView.borderWidth = .5;
    self.timeView.uperChartHeightScale = 0.7;
    self.timeView.xAxisHeitht = 25;
    self.timeView.countOfTimes = 242;
    
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
    self.timeView.delegate = self;
    [self.timeView setupData:set];
    
    
}

-(void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex
{
   
}

- (void)chartValueNothingSelected:(YKViewBase *)chartView
{
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
