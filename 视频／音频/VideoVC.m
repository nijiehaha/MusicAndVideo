//
//  VideoVC.m
//  视频／音频
//
//  Created by small路飞nj on 16/7/12.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import "VideoVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface VideoVC ()

@property (strong, nonatomic) AVPlayer *player;

@property (strong, nonatomic) AVPlayerViewController *playerView;

@end

@implementation VideoVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 播放完成再次更改设备支持的方向
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    appDel.allowRotation = NO;
    
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"150511_JiveBike" ofType:@".mov"];
    
    //本地文件
    NSURL *playerPath = [NSURL fileURLWithPath:path];
    
//    NSString *path = @"http://video.szzhangchu.com/xiangcaozifanqieA.mp4#http://video.szzhangchu.com/xiangcaozifanqieB.mp4";
//    
//    NSURL *playerPath = [NSURL URLWithString:path];
    
    _playerView = [[AVPlayerViewController alloc] init];
    _playerView.view.backgroundColor = [UIColor greenColor];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:playerPath];
    
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    layer.frame = CGRectMake(0, 64, self.view.frame.size.width, 300);
    
    layer.backgroundColor = [UIColor blueColor].CGColor;

    layer.videoGravity = AVLayerVideoGravityResize;
    
    [self.view.layer addSublayer:layer];
    
    self.playerView.player = self.player;
    
    self.playerView.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self.playerView.player play];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)moviePlayDidEnd
{
    // 播放完成再次更改设备支持的方向
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    appDel.allowRotation = NO;
    
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 更改当前设备支持的方向
    //强制旋转竖屏
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    appDel.allowRotation = YES;
    
    
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
    
    [self showViewController:self.playerView sender:nil];
    

}

@end
