//
//  SublistView.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/30.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^sublistViewCallback)();
@interface SublistView : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, copy)sublistViewCallback callBack;

@end
