//
//  ListModel.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject


@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *lat;
@property (nonatomic, copy)NSString *lon;
@property (nonatomic, copy)NSString *signin;
@property (nonatomic, copy)NSString *praise;
@property (nonatomic, copy)NSArray *relationships;
@property (nonatomic, copy)NSArray *biaoqian;
@property (nonatomic, copy)NSArray *Audios;
@property (nonatomic, copy)NSArray *images;

@property (nonatomic, assign) BOOL playing;
@property (nonatomic, assign) CGFloat percent;

- (void)setUpWithDict:(NSDictionary *)dict;

@end
