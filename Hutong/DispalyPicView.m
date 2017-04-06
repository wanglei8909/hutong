//
//  DispalyPicView.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/29.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "DispalyPicView.h"

#define DISPLAY_TIME 5

@implementation DispalyPicView
{
    NSTimer *theTimer;
    PictureView *currentPage;
    PictureView *hiddenPage;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.mRecycleList = [[NSMutableArray alloc] initWithCapacity:10];
        
        currentPage = [[PictureView alloc] initWithFrame:self.bounds];
        hiddenPage  = [[PictureView alloc] initWithFrame:self.bounds];
        hiddenPage.alpha = 0;
        [self addSubview:hiddenPage];
        [self addSubview:currentPage];
    }
    return self;
}

- (void)stopAutoScroll{
    if (theTimer) {
        [theTimer invalidate];
        theTimer = nil;
    }
}

- (void)startAutoScroll{
    [self stopAutoScroll];
    theTimer = [NSTimer scheduledTimerWithTimeInterval:DISPLAY_TIME target:self selector:@selector(autoDisPlay) userInfo:nil repeats:YES];
}

- (void)autoDisPlay{
    
    [UIView animateWithDuration:0.5 animations:^{
        currentPage.alpha = 0;
    }];
    hiddenPage.image = [UIImage imageNamed:self.mRecycleList[_curIndex]];
    [UIView animateWithDuration:0.5 animations:^{
        hiddenPage.alpha = 1;
    }];
    
    PictureView *mView = currentPage;
    currentPage = hiddenPage;
    hiddenPage = mView;
    
    _curIndex += 1;
    if (_curIndex == self.mRecycleList.count) _curIndex = 0;
}

- (void)setContent:(NSArray *)picArray{
    [self stopAutoScroll];
    _pageCount = picArray.count;
    [self.mRecycleList removeAllObjects];
    [self.mRecycleList addObjectsFromArray:picArray];
    _curIndex = 0;
    currentPage.image = [UIImage imageNamed:self.mRecycleList[_curIndex]];
    _curIndex = 1;
    if (_pageCount > 1) {
        [self startAutoScroll];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
