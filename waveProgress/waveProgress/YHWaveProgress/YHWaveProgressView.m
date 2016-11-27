//
//  YHWaveProgressView.m
//  waveProgress
//
//  Created by 杨应海 on 2016/11/27.
//  Copyright © 2016年 YYH. All rights reserved.
//

#import "YHWaveProgressView.h"

#define YHFirstWaveColorDefault [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:1]
#define YHSecondWaveColorDefault [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:0.3]

@interface YHWaveProgressView ()

@property (nonatomic, assign) CGFloat yHeight;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;

@end

@implementation YHWaveProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounds = CGRectMake(0, 0, MIN(frame.size.width, frame.size.height), MIN(frame.size.width, frame.size.height));
        self.layer.cornerRadius = MIN(frame.size.width, frame.size.height) * 0.5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:248/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 5.0f;
        
        self.waveHeight = 5.0;
        self.firstWaveColor = YHFirstWaveColorDefault;
        self.secondWaveColor = YHSecondWaveColorDefault;
        self.yHeight = self.bounds.size.height;
        self.speed = 1.0;
        
        [self.layer addSublayer:self.firstWaveLayer];
        if (!self.isShowSingleWave) {
            [self.layer addSublayer:self.secondWaveLayer];
        }
        
        [self addSubview:self.progressLabel];
    }
    return self;
}


#pragma mark - 传入进度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    // 这里修改保留的小数点位数
    _progressLabel.text = [NSString stringWithFormat:@"%ld%%", [[NSNumber numberWithFloat:progress * 100] integerValue]];
    _progressLabel.textColor = [UIColor colorWithWhite:progress * 1.8 alpha:1];
    self.yHeight = self.bounds.size.height * (1 - progress);
    
    [self stopWaveAnimation];
    [self startWaveAnimation];
}

#pragma mark - 开始波动动画
- (void)startWaveAnimation {
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - 停止波动动画
- (void)stopWaveAnimation {
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 波动动画实现
- (void)waveAnimation {
    
    CGFloat waveHeight = self.waveHeight;
    if (self.progress == 0.0f || self.progress == 1.0f) {
        waveHeight = 0.f;  // .0f  0.f
    }
    
    self.offset += self.speed;
    
    // 第一个波纹
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startOffsetY = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
    CGFloat orignOffsetY = 0.0;
    CGPathMoveToPoint(pathRef, NULL, 0, startOffsetY);
    for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
        orignOffsetY = waveHeight * sinf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
        CGPathAddLineToPoint(pathRef, NULL, i, orignOffsetY);
    }
    
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, orignOffsetY);
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, startOffsetY);
    CGPathCloseSubpath(pathRef);
    self.firstWaveLayer.path = pathRef;
    self.firstWaveLayer.fillColor = self.firstWaveColor.CGColor;
    CGPathRelease(pathRef);
    
    // 第二个波纹
    if (!self.isShowSingleWave) {
        CGMutablePathRef pathRef1 = CGPathCreateMutable();
        CGFloat startOffsetY1 = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
        CGFloat orignOffsetY1 = 0.0;
        CGPathMoveToPoint(pathRef1, NULL, 0, startOffsetY1);
        for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
            orignOffsetY1 = waveHeight * cosf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
            CGPathAddLineToPoint(pathRef1, NULL, i, orignOffsetY1);
        }
        
        CGPathAddLineToPoint(pathRef1, NULL, self.bounds.size.width, orignOffsetY1);
        CGPathAddLineToPoint(pathRef1, NULL, self.bounds.size.width, self.bounds.size.height);
        CGPathAddLineToPoint(pathRef1, NULL, 0, self.bounds.size.height);
        CGPathAddLineToPoint(pathRef1, NULL, 0, startOffsetY1);
        CGPathCloseSubpath(pathRef1);
        self.secondWaveLayer.path = pathRef1;
        self.secondWaveLayer.fillColor = self.secondWaveColor.CGColor;
        
        CGPathRelease(pathRef1);
    }


}


#pragma mark - 懒加载属性
- (CAShapeLayer *)firstWaveLayer {
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.frame = self.bounds;
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondWaveLayer {
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.frame = self.bounds;
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
    }
    return _secondWaveLayer;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.text = @"0%";
        _progressLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
        _progressLabel.center = self.center;
        _progressLabel.font = [UIFont systemFontOfSize:20];
        _progressLabel.textColor = [UIColor colorWithWhite:0 alpha:1.0];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _progressLabel;
}


- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
    
    if (_firstWaveLayer) {
        [_firstWaveLayer removeFromSuperlayer];
        _firstWaveLayer = nil;
    }
    if (_secondWaveLayer) {
        [_secondWaveLayer removeFromSuperlayer];
        _secondWaveLayer = nil;
    }
}






@end
