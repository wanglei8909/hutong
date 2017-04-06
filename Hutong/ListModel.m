//
//  ListModel.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)setUpWithDict:(NSDictionary *)dict{
    for (NSString *key in dict) {
        [self setValue:dict[key] forKey:key];
    }
    self.playing = NO;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"setValueforUndefinedKey:%@",key);
}

@end
