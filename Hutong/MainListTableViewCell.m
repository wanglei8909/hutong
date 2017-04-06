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
        self.mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 60, 60)];
        self.mImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.mImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 16, kSCREEN_WIDTH - 96 - 16, 16)];
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
    
    if (model.playing && AUDIOManager.playing) {
        self.nameLabel.textColor = kColorRed;
    }else {
        self.nameLabel.textColor = kSetColor(51,51,51);
    }
    self.mImageView.image = [UIImage imageNamed:model.images[0]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    NSString *biaoqianStr = @"";
    for (int i = 0; i<model.biaoqian.count; i++) {
        NSString *biaoqian = [NSString stringWithFormat:@"#%@#  ",model.biaoqian[i]];
        biaoqianStr = [biaoqianStr stringByAppendingString:biaoqian];
    }
    self.desLabel.text = biaoqianStr;
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
