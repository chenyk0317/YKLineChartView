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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
//    YKlineChartView * kline = [[YKlineChartView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
//    
//    kline.backgroundColor = [UIColor redColor];
//    [self.view addSubview:kline];
//    kline.center = CGPointMake(200, 200);
//    
//    kline.frame = CGRectMake(0, 0, 400, 400);
//    
//    NSLog(@"0 === %d",[kline isInBoundsX:10]);
    NSLog(@"0 === %d",[self.TestView isInBoundsX:400]);
    
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
    dataset.highlightLineColor = [UIColor redColor];
    dataset.highlightLineWidth = 0.5;
    dataset.candleRiseColor = [UIColor redColor];
    dataset.candleFallColor = [UIColor greenColor];
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor orangeColor];
    dataset.avgMA5Color = [UIColor blueColor];
    dataset.avgMA20Color = [UIColor purpleColor];
    dataset.candleTopBottmLineWidth = 1;
    
    [self.TestView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.TestView.gridBackgroundColor = [UIColor groupTableViewBackgroundColor];
    self.TestView.borderColor = [UIColor grayColor];
    self.TestView.borderWidth = .5;
    self.TestView.candleWidth = 8;
    self.TestView.candleMaxWidth = 30;
    self.TestView.candleMinWidth = 1;
    self.TestView.uperChartHeightScale = 0.7;
    self.TestView.xAxisHeitht = 25;
    [self.TestView setupData:dataset];
    
    
    NSArray * sourceArray2 = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data4"];
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
    self.timeView.gridBackgroundColor = [UIColor groupTableViewBackgroundColor];
    self.timeView.borderColor = [UIColor grayColor];
    self.timeView.borderWidth = .5;
    self.timeView.uperChartHeightScale = 0.7;
    self.timeView.xAxisHeitht = 25;
    self.timeView.countOfTimes = 242;
    
    YKTimeDataset * set  = [[YKTimeDataset alloc]init];
    set.data = timeArray;
    set.avgLineCorlor = [UIColor redColor];
    set.priceLineCorlor = [UIColor blueColor];
    set.lineWidth = 1.f;
    set.highlightLineWidth = .5f;
    set.highlightLineColor = [UIColor redColor];
    
    set.volumeTieColor = [UIColor grayColor];
    set.volumeRiseColor = [UIColor redColor];
    set.volumeFallColor = [UIColor greenColor];
    
    set.fillColor = [UIColor orangeColor];
    set.fillAlpha = .3;
    set.drawFilledEnabled = YES;
    [self.timeView setupData:set];
    

}



/*
- (UIPanGestureRecognizer *)panGesture
{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanGestureAction:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (UIPinchGestureRecognizer*)pinGesture
{
    if (!_pinGesture) {
        _pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(didPinchGestureAction:)];
        _panGesture.delegate = self;
    }
    return _pinGesture;
}

- (void)didPanGestureAction:(UIPanGestureRecognizer*)recognizer
{
    
    NSLog(@"平移");
    
}
- (void)didPinchGestureAction:(UIPinchGestureRecognizer*)recognizer
{
    NSLog(@"缩放");
    
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
