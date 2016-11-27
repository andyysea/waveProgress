//
//  YHViewController.m
//  waveProgress
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHViewController.h"
#import "YHWaveProgressView.h"


@interface YHViewController ()

@end

@implementation YHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
 
    
    
//    [self setupUI];
    [self setupUII];
}




#pragma mark - 设置界面

/**
 
 缺陷,当显示两层波浪的时候,第二层波浪设置的颜色会覆盖第一个波浪在底部显示的颜色
 所以要设置两个波浪的颜色尽量接近,显示的视觉效果好点
 */

- (void)setupUI {
    YHWaveProgressView *waveProgressOne = [[YHWaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.view addSubview:waveProgressOne];
    waveProgressOne.progress = 0.2;
    waveProgressOne.speed = 1.0;
    waveProgressOne.waveHeight = 10;
    waveProgressOne.isShowSingleWave = YES;
    waveProgressOne.firstWaveColor = [UIColor redColor];
    waveProgressOne.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    
    YHWaveProgressView *waveProgressTwo = [[YHWaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:waveProgressTwo];
    waveProgressTwo.progress = 0.6;
    waveProgressTwo.isShowSingleWave = NO;
    waveProgressTwo.waveHeight = 8;
    waveProgressTwo.speed = 0.8;
    waveProgressTwo.center = CGPointMake(CGRectGetMidX(self.view.bounds), 400);
    waveProgressTwo.firstWaveColor = [UIColor redColor];
    waveProgressTwo.secondWaveColor = [UIColor orangeColor];
    
    
}




- (void)setupUII {
    YHWaveProgressView *progressView = [[YHWaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressView.center=CGPointMake(CGRectGetMidX(self.view.bounds), 150);
    progressView.progress = 0.3;
    progressView.speed = 0.5;
    [self.view addSubview:progressView];
    
    YHWaveProgressView *progressView1 = [[YHWaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressView1.center=CGPointMake(CGRectGetMidX(self.view.bounds), 270);
    progressView1.progress = 0.5;
    progressView1.waveHeight = 10;
    progressView1.speed = 1.0;
    progressView1.isShowSingleWave=YES;
    progressView1.firstWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:1];
    progressView1.secondWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:0.5];
    [self.view addSubview:progressView1];
    
    YHWaveProgressView *progressView2 = [[YHWaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progressView2.center=CGPointMake(CGRectGetMidX(self.view.bounds), 390);
    progressView2.progress = 0.7;
    progressView2.waveHeight = 5;
    progressView2.speed = 0.8;
    progressView2.firstWaveColor = [UIColor colorWithRed:134/255.0 green:216/255.0 blue:210/255.0 alpha:1];
    progressView2.secondWaveColor = [UIColor colorWithRed:134/255.0 green:216/255.0 blue:210/255.0 alpha:0.5];
    [self.view addSubview:progressView2];
    
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
