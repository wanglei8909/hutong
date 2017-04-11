//
//  MainListTableViewCell.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "MainListTableViewCell.h"

@implementation MainListTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 70, 70)];
        self.mImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.mImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 10, kSCREEN_WIDTH - 96 - 16, 16)];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = kSetColor(51,51,51);
        [self.contentView addSubview:self.nameLabel];
        
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, self.nameLabel.bottom + 5, kSCREEN_WIDTH - 96 - 16, 40)];
        self.desLabel.numberOfLines = 0;
        //self.desLabel.backgroundColor = [UIColor yellowColor];
        self.desLabel.font = [UIFont systemFontOfSize:14];
        self.desLabel.textColor = kSetColor(50, 141, 255);
        [self.contentView addSubview:self.desLabel];
    }
    return self;
}

- (void)loadContent:(ListModel *)model{
    
    @autoreleasepool {
        for (UIView *view  in self.contentView.subviews) {
            if (view == self.nameLabel || view == self.mImageView) {
                continue;
            }
            [view removeFromSuperview];
        }
    }
    
    if (model.playing && AUDIOManager.playing) {
        self.nameLabel.textColor = kColorRed;
    }else {
        self.nameLabel.textColor = kSetColor(51,51,51);
    }
    self.mImageView.image = [UIImage imageNamed:model.images[0]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    CGFloat iX = 96;
    CGFloat iW = 75;
    CGFloat iY = 50;
    if (model.biaoqian.count > 3) {
        iY = 35;
    }
    for (int i = 0; i<model.biaoqian.count; i++) {
        iX = 96 + i * (iW + 10);
        if (iX > kSCREEN_WIDTH - 16 - iW) {
            iX = 96;
            iY += 25;
        }
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(iX, iY, iW, 20)];
        image.image = [UIImage imageNamed:@"icon-2"];
        [self.contentView addSubview:image];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, iW - 10, 20)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        [image addSubview:label];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = [model.biaoqian objectAtIndex:i];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
