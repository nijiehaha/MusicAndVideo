//
//  Song.h
//  视频／音频
//
//  Created by small路飞nj on 16/7/8.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Song : UIView

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UILabel *lab;
@property (assign, nonatomic) BOOL flag;
@property (assign, nonatomic) CGFloat spacingTime;

@property (assign, nonatomic) NSTimeInterval useTime;
// 播放器
@property (strong, nonatomic) AVAudioPlayer *player;

- (void)start;
- (void)stop;


@end
