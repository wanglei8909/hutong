//
//  LXLoginNavView.h
//  Fortune
//
//  Created by 王蕾 on 16/5/25.
//  Copyright © 2016年 Fortune. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NavLeftClick)();

@interface LXLoginNavView : UIView

@property (nonatomic, copy) NavLeftClick leftBlock;
@property (nonatomic, copy) NavLeftClick rightBlock;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftbtn;


- (instancetype)initWithTitle:(NSString *)title andLeftImageName:(NSString *)imageName;

- (instancetype)initWithTitle:(NSString *)title andLeftImageName:(NSString *)imageName andRightBtnText:(NSString *) rightText;

@end
