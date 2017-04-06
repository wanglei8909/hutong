//
//  MyCustomAnnotationView.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/28.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <MapKit/MapKit.h>

typedef void(^MyCustomAnnotationViewClickBlock)(NSInteger index);
@interface MyCustomAnnotationView : MKAnnotationView

@property (nonatomic, copy)NSString *mid;
@property (nonatomic, copy)MyCustomAnnotationViewClickBlock clickBlock;
@property (nonatomic, strong)UILabel *titleLabel;

@end
