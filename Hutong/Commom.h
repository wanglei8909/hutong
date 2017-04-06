//
//  Commom.h
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UIView+Frame.h"
#import <CommonCrypto/CommonDigest.h>


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface Commom : NSObject

//通过颜色获取图片
+(UIImage*) imageWithColor:(UIColor*)color;

+(UIImage*) imageWithColorbtnimage:(UIColor*)color;

+ (UIViewController *)getCurrentViewController;

//+ (UIView *)getLine:(CGRect)rect;


@end










