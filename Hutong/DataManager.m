//
//  DataManager.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "DataManager.h"


@implementation DataManager

+ (instancetype)shareManager{
    static DataManager *instance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] initSingLeton];
    });
    return instance;
}

- (instancetype)initSingLeton{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Data List" ofType:@"plist"]];
        for (int i = 0; i < array.count; i++) {
            ListModel *model = [[ListModel alloc] init];
            NSDictionary *dict = array[i];
            [model setUpWithDict:dict];
            [self.dataArray addObject:model];
        }
        self.playingModel = [self.dataArray objectAtIndex:0];
    }
    return self;
}

- (void)setPlayingModel:(ListModel *)playingModel{
    if (_playingModel) {
        _playingModel.playing = NO;
    }
    _playingModel = playingModel;
    _playingModel.playing = YES;
    
    _currentIndex = 0;
    _audioCount = _playingModel.Audios.count;
}

- (NSInteger)nextCurrentIndex{
    _currentIndex ++;
    if (_currentIndex >= _audioCount) {
        _currentIndex = 0;
    }
    return _currentIndex;
}

- (NSInteger)previousCurrentIndex{
    _currentIndex --;
    if (_currentIndex < 0) {
        _currentIndex = _audioCount - 1;
    }
    return _currentIndex;
}

- (BOOL)canPlayNext{
    return _currentIndex < _audioCount - 1;
}

@end








