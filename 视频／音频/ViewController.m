//
//  ViewController.m
//  视频／音频
//
//  Created by small路飞nj on 16/7/7.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import "ViewController.h"
#import "SongVC.h"
#import "AppDelegate.h"
#import "VideoVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UIViewController attemptRotationToDeviceOrientation];

    
    self.title = @"目录";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.window.rootViewController = nav;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 20, 100, 100);
    [btn1 setTitle:@"播放歌曲" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(pressBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 140, 100, 100);
    [btn2 setTitle:@"播放视频" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(pressBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}

- (void)pressBtn1
{
    SongVC *song = [[SongVC alloc] init];
    song.title = @"播放歌曲";
    [self.navigationController pushViewController:song animated:YES];
}

- (void)pressBtn2
{
    
    
    VideoVC *video = [[VideoVC alloc] init];
    video.title = @"播放视频";
    [self.navigationController pushViewController:video animated:YES];
}

@end
