//
//  AudioManager.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ListModel.h"

static NSString *UPDATETIMENotification = @"UPDATETIMENotification";

@interface AudioManager : NSObject

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)AVAudioPlayer *player;
@property (nonatomic, assign)BOOL playing;

+ (instancetype)shareManager;

- (void)newPlay;
- (BOOL)prepareToPlay;
- (BOOL)play;
- (void)pause;
- (void)stop;
- (void)playNext;
- (void)playPrevious;


@end
