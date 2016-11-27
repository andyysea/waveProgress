//
//  YHWaveProgressView.h
//  waveProgress
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHWaveProgressView : UIView

/**
 *  进度 0-1 , '必传'属性,有进度才能开启 '波浪动画' 效果
 */
@property (nonatomic, assign) CGFloat progress;


/**
 *  波动速度，默认 1
 */
@property (nonatomic, assign) CGFloat speed;


/**
 *  波纹填充颜色
 */
@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;


/**
 *  波动幅度，默认 5
 */
@property (nonatomic, assign) CGFloat waveHeight;


/**
 *  进度文字
 */
@property (nonatomic, strong) UILabel *progressLabel;


/**
 *  是否显示单层波浪，默认NO
 */
@property (nonatomic,assign)BOOL isShowSingleWave;


/** 重写系统接口,要传入frame */
- (instancetype)initWithFrame:(CGRect)frame;

@end



