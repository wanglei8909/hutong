//
//  DispalyPicView.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/29.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureView.h"

@interface DispalyPicView : UIView


@property (nonatomic, strong) NSMutableArray *mRecycleList;
@property (nonatomic, readonly) NSInteger pageCount;
@property (nonatomic, readonly) NSInteger curIndex;


- (void)setContent:(NSArray *)picArray;

@end
