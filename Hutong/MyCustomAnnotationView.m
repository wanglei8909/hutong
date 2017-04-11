//
//  MyCustomAnnotationView.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/28.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "MyCustomAnnotationView.h"

@implementation MyCustomAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 70, 45);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 37.5)];
        imageView.image = [UIImage imageNamed:@"icon-2-1.png"] ;
        [self addSubview:imageView];
        self.centerOffset = CGPointMake(self.frame.size.width * 0.5, -self.frame.size.height * 0.5);
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.5, 6, 75, 12)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        _pinyinLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 17, 74, 14)];
        _pinyinLabel.textAlignment = NSTextAlignmentCenter;
        _pinyinLabel.font = [UIFont systemFontOfSize:9];
        _pinyinLabel.textColor = [UIColor whiteColor];
        [self addSubview:_pinyinLabel];

        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
    }
    return self;
}

- (void)setContent:(NSString *)name{
    _titleLabel.text = name;
    _pinyinLabel.text = [Commom transform:name];
    _pinyinLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)click{
    NSLog(@"%@",self.mid);
    if (self.clickBlock) {
        self.clickBlock([self.mid integerValue]);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
