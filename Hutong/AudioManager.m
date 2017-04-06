//
//  AudioManager.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "AudioManager.h"

@interface AudioManager()<AVAudioPlayerDelegate>

@end

@implementation AudioManager


+ (instancetype)shareManager{
    static AudioManager *instance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[AudioManager alloc] initSingLeton];
    });
    return instance;
}

- (instancetype)initSingLeton{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRoteChange:) name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
        
        NSArray *Audios = DATAManager.playingModel.Audios;
        NSString *fieldName = [Audios objectAtIndex:0];
        NSString *filepath = [[NSBundle mainBundle] pathForResource:fieldName ofType:@"m4a"];
        BOOL fileexit = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
        if (!fileexit) {
            
        }
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filepath];
        NSError *error;
        self.player = [[AVAudioPlayer alloc] initWithData:data error:&error];
        self.player.delegate = self;
        [self prepareToPlay];
        
        self.timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateTimeDisplay) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        
    }
    return self;
}

- (void)newPlay{
    NSArray *Audios = DATAManager.playingModel.Audios;
    NSString *fieldName = [Audios objectAtIndex:DATAManager.currentIndex];
    [self setFieldPath:fieldName];
}

- (void)setFieldPath:(NSString *)fieldPath{
//    _fieldPath = fieldPath;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:fieldPath ofType:@"m4a"];
    BOOL fileexit = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    if (!fileexit) {
        
    }
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filepath];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    self.player.delegate = self;
    [self prepareToPlay];
    [self play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [[playGifView shareInstance] pause];
    if (flag && [DATAManager canPlayNext]) {
        [self playNext];
        [[playGifView shareInstance] play];
    }
}

- (void)handleRoteChange:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    AVAudioSessionRouteChangeReason reason = [info[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    if (reason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *previousRout = info[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *output = previousRout.outputs[0];
        NSString *portType = output.portType;
        if ([portType isEqualToString:AVAudioSessionPortHeadphones] ) {
            [self stop];
            
        }
    }
}

- (void)handleInterruption:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    if (type == AVAudioSessionInterruptionTypeBegan) {
        [self stop];
    }else{
        AVAudioSessionInterruptionOptions options = [info[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (options == AVAudioSessionInterruptionOptionShouldResume) {
            [self play];
            
        }
    }
}

- (void)updateTimeDisplay{
    if (!self.player) {
        return;
    }
    NSDictionary *dict = @{
                           @"progress"      :@(self.player.currentTime/self.player.duration),
                           @"currentTime"   :[self formattedCurrenttime:self.player.currentTime],
                           @"duration"      :[self formattedCurrenttime:self.player.duration]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATETIMENotification object:nil userInfo:dict];
}

- (NSString *)formattedCurrenttime:(NSTimeInterval) timeInterval {
    NSUInteger time = (NSUInteger)timeInterval;
//    NSInteger hours = (time / 3600);
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    
    NSString *format = @"%02i:%02i";
    return [NSString stringWithFormat:format,minutes,seconds];
}

- (BOOL)prepareToPlay{
    return [self.player prepareToPlay];
}
- (BOOL)play{
    return [self.player play];
}
- (void)pause{
    [[playGifView shareInstance] pause];
    [self.player pause];
}
- (void)stop{
    [[playGifView shareInstance] pause];
    [self.player stop];
}

- (BOOL)playing{
    return self.player.isPlaying;
}

- (void)playNext{
    [DATAManager nextCurrentIndex];
    [self newPlay];
}
- (void)playPrevious{
    [DATAManager previousCurrentIndex];
    [self newPlay];
}


@end
