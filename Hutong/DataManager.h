//
//  DataManager.h
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListModel.h"

@interface DataManager : NSObject

@property (nonatomic, strong) ListModel *playingModel;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, readonly, assign) NSInteger audioCount;
@property (nonatomic, strong) NSMutableArray *dataArray;


+ (instancetype)shareManager;

- (NSInteger)nextCurrentIndex;
- (NSInteger)previousCurrentIndex;
- (BOOL)canPlayNext;

@end
