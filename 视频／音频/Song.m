//
//  Song.m
//  视频／音频
//
//  Created by small路飞nj on 16/7/8.
//  Copyright © 2016年 倪杰. All rights reserved.
//

#import "Song.h"

@implementation Song

{
    // 时间
    NSMutableArray *_times;
    // 歌词
    NSMutableArray *_lyrics;
}

static int i = 0;
static BOOL isStop = NO;

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self == [super initWithFrame:frame]) {
        [self readLrc];
        if (_lyrics.count != 0) {
            i = 0;
        }
        
    }
    
    return self;
}

- (CGFloat)spacingTime
{
    if (i == 0) {
        _spacingTime = [_times[0] floatValue];
    }
    else {
        _spacingTime = [_times[i] floatValue] - [_times[i - 1] floatValue];
    }
    return _spacingTime;
}

- (NSTimeInterval)useTime{
    return _useTime;
}

- (void)setFlag:(BOOL)flag
{
    NSLog(@"我的useTime %f",_useTime);
    
    _flag = flag;
    if (_flag) {
        [self start];
        if (i == 0) {
            [self performSelector:@selector(myLabelText) withObject:nil afterDelay:self.spacingTime];
        }
    } else {
        [self stop];
    }
}

- (void)myLabelText
{
    //问题在这，不停调用，没有判断
    NSLog(@"应该需要的时间 %@，暂停的时间%f",_times[i], self.player.currentTime);
    CGFloat time = [_times[i] floatValue];
    if (isStop && time > self.player.currentTime) {
        NSTimeInterval nextTime = time - self.player.currentTime;
        NSLog(@"%f",nextTime);
        //计算暂停之后的时间误差，然后调整。
        //感觉如果需要加上一个倒退功能这边还要升级
        //这个再来 pull request
        _timer = [NSTimer scheduledTimerWithTimeInterval:nextTime target:self selector:@selector(myLabelText) userInfo:nil repeats:NO];
        return;
    }
    
    self.lab.text = _lyrics[i];
    i++;
    while (i == _lyrics.count - 1) {
        i = 0;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.spacingTime target:self selector:@selector(myLabelText) userInfo:nil repeats:NO];
}
- (void)start
{
    
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)stop
{
    if (!isStop) {
        isStop = YES;
    }
    [_timer setFireDate:[NSDate distantFuture]];
}




- (UILabel *)lab
{
    if (_lab == nil) {
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        _lab.textAlignment = 1;
        _lab.font = [UIFont boldSystemFontOfSize:20];
        _lab.numberOfLines = 0;
        _lab.textColor = [UIColor blackColor];
        [self addSubview:_lab];
    }
    return _lab;
}

- (void)readLrc
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"从前的我" ofType:@".lrc"];
    NSError *error = nil;
    NSString *context = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    _times = [[NSMutableArray alloc] initWithCapacity:0];
    _lyrics = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *lrcArr = [self createComLcrArrWith:context];
    [self createTimeArrWith:lrcArr];
    [self createLyricArrWith:lrcArr];
}

- (NSArray *)createComLcrArrWith:(NSString *)context
{
    NSArray *lrcArr = [context componentsSeparatedByString:@"\n"];
    return lrcArr;
}

// 处理时间
- (void)createTimeArrWith:(NSArray *)lrcArr
{
    for (NSString *lrcStr in lrcArr) {
        if (lrcStr.length != 0) {
            NSRange startRange = [lrcStr rangeOfString:@"["];
            NSRange endRange = [lrcStr rangeOfString:@"]"];
            NSString *timeLineArr = [lrcStr substringWithRange:NSMakeRange(startRange.location + 1, endRange.location - startRange.location - 1)];
            NSArray *arr = [timeLineArr componentsSeparatedByString:@":"];
            NSString *min = arr[0];
            NSString *second = arr[1];
            CGFloat songTime = [min floatValue] * 60 + [second floatValue];
            NSString *lrc = [NSString stringWithFormat:@"%f", songTime];
            [_times addObject:lrc];
        }
    }
}

// 处理歌词
- (void)createLyricArrWith:(NSArray *)lrcArr
{
    for (NSString *lrcStr in lrcArr) {
        if (lrcStr.length != 0) {
            NSArray *arr = [lrcStr componentsSeparatedByString:@"]"];
            NSString *songStr = arr[1];
            if (songStr.length == 0) {
                songStr = @"。。。";
            }
            [_lyrics addObject:songStr];
        }
    }
}


//移除定时器
- (void)dealloc
{
    [_timer invalidate];
    
}
@end
