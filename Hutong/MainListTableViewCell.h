//
//  MainListTableViewCell.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface MainListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *mImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *desLabel;


- (void)loadContent:(ListModel *)model;

@end
