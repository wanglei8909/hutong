//
//  DetailTableViewCell.m
//  Hutong
//
//  Created by 王蕾 on 2017/4/10.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
{
    UILabel *nameLabel;
    UILabel *numLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 40)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textColor = kSetColor(51, 51, 51);
        numLabel.font = [UIFont systemFontOfSize:13];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:numLabel];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kSCREEN_WIDTH - 200, 40)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = kSetColor(51, 51, 51);
        nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:nameLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40, 39.3, kSCREEN_WIDTH, 0.7)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
    }
    
    return self;
}

- (void)loadContent:(NSString *)name :(NSString *)num{
    nameLabel.text = name;
    numLabel.text = num;
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
