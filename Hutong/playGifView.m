//
//  playGifView.m
//  NavCtrlTest
//
//  Created by 王蕾 on 2017/3/21.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "playGifView.h"

@implementation playGifView
{
    UIView *line1;
    UIView *line2;
    UIView *line3;
    UIView *line4;
    BOOL play;
}

+ (instancetype)shareInstance{
    static playGifView *instance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[playGifView alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(kSCREEN_WIDTH - 46, 20, 30, 44)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        play = NO;
        line1 = [[UIView alloc] initWithFrame:CGRectMake(0 + 5, 24, 2, 10)];
        line1.backgroundColor = [UIColor whiteColor];
        [self addSubview:line1];
        
        line2 = [[UIView alloc] initWithFrame:CGRectMake(7 + 5, 12, 2, 22)];
        line2.backgroundColor = [UIColor whiteColor];
        [self addSubview:line2];
        
        line3 = [[UIView alloc] initWithFrame:CGRectMake(14 + 5, 20, 2, 14)];
        line3.backgroundColor = [UIColor whiteColor];
        [self addSubview:line3];
        
        line4 = [[UIView alloc] initWithFrame:CGRectMake(21 + 5, 16, 2, 18)];
        line4.backgroundColor = [UIColor whiteColor];
        [self addSubview:line4];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPlayVC)]];
    }
    return self;
}

- (void)goPlayVC{
    UINavigationController *nVC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nVC presentViewController:[PlayerViewController shareInstance] animated:YES completion:nil];
}

- (void)play{
    if (play) {
        return;
    }
    play = YES;
    [self animateUp];
}

- (void)animateUp{
    if (!play) {
        line1.frame = CGRectMake(0 + 5, 24, 2, 10);
        line2.frame = CGRectMake(7 + 5, 12, 2, 22);
        line3.frame = CGRectMake(14 + 5, 20, 2, 14);
        line4.frame = CGRectMake(21 + 5, 16, 2, 18);
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        line1.frame = CGRectMake(0 + 5, 24 - 14, 2, 10 + 14);
        line2.frame = CGRectMake(7 + 5, 12 + 14, 2, 22 - 14);
        line3.frame = CGRectMake(14 + 5, 20 - 14, 2, 14 + 14);
        line4.frame = CGRectMake(21 + 5, 16 + 14, 2, 18 - 14);
    } completion:^(BOOL finished) {
        [self animateDown];
    }];
}

- (void)animateDown{
    [UIView animateWithDuration:0.2 animations:^{
        line1.frame = CGRectMake(0 + 5, 24, 2, 10);
        line2.frame = CGRectMake(7 + 5, 12, 2, 22);
        line3.frame = CGRectMake(14 + 5, 20, 2, 14);
        line4.frame = CGRectMake(21 + 5, 16, 2, 18);
    } completion:^(BOOL finished) {
        [self animateUp];
    }];
}

- (void)pause{
    play = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
