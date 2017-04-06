//
//  SubListCell.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/31.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubListCell : UITableViewCell

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *mImageView;

- (void)loadContent:(NSString *)name;

@end
