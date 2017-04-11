//
//  PictureView.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/29.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "PictureView.h"

@implementation PictureView
{
    UIImageView *imageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT * 0.5)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
    }
    return self;
}


- (void)setImage:(UIImage *)image{
    [super setImage:image];
    imageView.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
