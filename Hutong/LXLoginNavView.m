//
//  LXLoginNavView.m
//  Fortune
//
//  Created by 王蕾 on 16/5/25.
//  Copyright © 2016年 Fortune. All rights reserved.
//

#import "LXLoginNavView.h"

@implementation LXLoginNavView


- (instancetype)initWithTitle:(NSString *)title andLeftImageName:(NSString *)imageName{
    self = [super initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    if (self) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 94)];
        backImage.image = [UIImage imageNamed:@"透明导航"];
        [self addSubview:backImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        self.titleLabel.center = CGPointMake(kSCREEN_WIDTH*0.5, 42);
        self.titleLabel.text = title;
        self.titleLabel.textColor = kSetColor(80, 80, 80);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.titleLabel];
        
        self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftbtn.frame = CGRectMake(0, 0, 60, 44);
        self.leftbtn.center = CGPointMake(30, 42);
        [self.leftbtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(leftbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftbtn];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title andLeftImageName:(NSString *)imageName andRightBtnText:(NSString *) rightText{
    self = [super initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    if (self) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 94)];
        backImage.image = [UIImage imageNamed:@"透明导航"];
        [self addSubview:backImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        self.titleLabel.center = CGPointMake(kSCREEN_WIDTH*0.5, 42);
        self.titleLabel.text = title;
        self.titleLabel.textColor = kSetColor(80, 80, 80);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.titleLabel];
        
        self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftbtn.frame = CGRectMake(0, 0, 60, 44);
        self.leftbtn.center = CGPointMake(30, 42);
        [self.leftbtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(leftbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftbtn];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)rightbtnClick{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)leftbtnClick{
    if (self.leftBlock) {
        self.leftBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
