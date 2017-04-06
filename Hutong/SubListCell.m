//
//  SubListCell.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/31.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "SubListCell.h"

@implementation SubListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
        bView.backgroundColor = [UIColor grayColor];
        self.selectedBackgroundView = bView;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, 39.5, kSCREEN_WIDTH - 16, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kSCREEN_WIDTH * 0.5, 40)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 36, 10, 20, 20)];
        self.mImageView.image = [UIImage imageNamed:@"laba"];
        [self.contentView addSubview:self.mImageView];
    }
    return self;
}

- (void)loadContent:(NSString *)name{
    self.nameLabel.text = name;
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
