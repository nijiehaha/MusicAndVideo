//
//  SongVC.m
//  视频／音频
//
//  Created by small路飞nj on 16/7/7.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import "SongVC.h"
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@interface SongVC () <AVAudioPlayerDelegate>

@property (strong, nonatomic) Song *song;

// 播放器
@property (strong, nonatomic) AVAudioPlayer *player;

// 暂停／播放按钮
@property (strong, nonatomic) UIButton *statutBtn;

@end

@implementation SongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _statutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _statutBtn.frame = CGRectMake(50, 100, 300, 100);
    [_statutBtn setTitle:@"开始播放“陈洁仪 - 从前的我”" forState:UIControlStateNormal];
    [_statutBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [_statutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_statutBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_statutBtn addTarget:self action:@selector(pressStatut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_statutBtn];
    
    _song = [[Song alloc] initWithFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 200)];
    _song.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_song];
}

- (void)pressStatut
{
    _statutBtn.selected = !_statutBtn.selected;
    
    if (_statutBtn.selected) {
        [self isPlay];
    } else {
        [self isPause];
    }
}

- (AVAudioPlayer *)player
{
    if (!_player) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"陈洁仪 - 从前的我" ofType:@".mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        _player.numberOfLoops = 0;
        
        _player.delegate = self;
        
        [_player prepareToPlay];
        
        if (error) {
            NSLog(@"初始化播放器发生错误");
            
            return nil;
        }
        
    }
    
    return _player;
}

// 播放音频
- (void)isPlay
{
    if (![self.player isPlaying]) {
        [self.player play];
        _song.player = self.player;
        _song.flag = YES;
        
    }
}

// 暂停音频
- (void)isPause
{
    if ([self.player isPlaying]) {
        [self.player pause];
        _song.flag = NO;
    }
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"播放音频完成");
}

- (void)dealloc
{
    [_player stop];
}

@end
