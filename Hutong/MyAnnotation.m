//
//  MyAnnotation.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/27.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation


- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

- (void)setTitle:(NSString * _Nullable)title{
    _title = title;
}

- (void)setSubtitle:(NSString * _Nullable)subtitle{
    _subtitle = subtitle;
}

@end
