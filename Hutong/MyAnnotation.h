//
//  MyAnnotation.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/27.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic, strong, nullable) NSString *mid;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;


- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
- (void)setTitle:(NSString * _Nullable)title;
- (void)setSubtitle:(NSString * _Nullable)subtitle;

@end
