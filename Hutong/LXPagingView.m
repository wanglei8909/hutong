//
//  LXPagingView.m
//  Fortune
//
//  Created by 王蕾 on 16/5/16.
//  Copyright © 2016年 Fortune. All rights reserved.
//

#import "LXPagingView.h"

@implementation LXPagingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.mRecycleList = [[NSMutableArray alloc] initWithCapacity:10];
        self.mVisibleList = [[NSMutableArray alloc] initWithCapacity:10];
        
        mScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        mScrollView.backgroundColor = [UIColor clearColor];
        mScrollView.delegate = self;
        mScrollView.pagingEnabled = YES;
        mScrollView.contentSize = CGSizeMake(3 * mScrollView.width, mScrollView.height);
        mScrollView.contentOffset = CGPointMake(mScrollView.width, 0);
        mScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:mScrollView];
        
        mPageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.height-60, self.width, 20)];
        mPageCtrl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        mPageCtrl.userInteractionEnabled = NO;
        mPageCtrl.currentPageIndicatorTintColor = kColorRed;
        [self addSubview:mPageCtrl];
        
        miOffsetIndex = 1;
        _isAutoPlay = YES;
    }
    return self;
}

- (void)dealloc{
    [self stopAutoScroll];
    self.mRecycleList = nil;
    self.mVisibleList = nil;
}

- (void)reloadData{
    [self stopAutoScroll];
    
    _pageCount = [_delegate numberOfPagesInPagingView:self];
    
    @autoreleasepool {
        for (UIView *pageView in _mVisibleList) {
            [_mRecycleList addObject:pageView];
            [pageView removeFromSuperview];
        
        }
        [_mVisibleList removeAllObjects];
    }
    
    if (_pageCount == 1) {
        _isAutoPlay = NO;
        mScrollView.scrollEnabled = NO;
        mPageCtrl.numberOfPages = 0;
        
        UIView *pageView = [_delegate LXPagingView:self viewAtIndex:0];
        pageView.frame = CGRectMake(mScrollView.width, 0, mScrollView.width, mScrollView.height);
        [_mVisibleList addObject:pageView];
        [mScrollView addSubview:pageView];
        return;
    }
    
    _curIndex = 0;
    miOffsetIndex = 1;
    mScrollView.contentOffset = CGPointMake(mScrollView.width, 0);
    mScrollView.scrollEnabled = YES;
    
    mPageCtrl.currentPage = 0;
    mPageCtrl.numberOfPages = _pageCount;
    
    [self refreshAllView];
    
    if (_isAutoPlay) {
        theTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
    }
}

- (void)autoScrollView{
    if (_pageCount <= 1) {
        return;
    }
    if (!mScrollView.isDecelerating && !mScrollView.isDragging) {
        [mScrollView setContentOffset:CGPointMake(2 * mScrollView.width, 0) animated:YES];
    
    }
}

- (void)stopAutoScroll{
    if (theTimer) {
        [theTimer invalidate];
        theTimer = nil;
    }
}

- (void)startAutoScroll{
    mScrollView.scrollEnabled = YES;
    [self stopAutoScroll];
    _isAutoPlay = YES;
    theTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
}

- (void)refreshAllView{
    if(_pageCount == 0){
        return;
    }
    mPageCtrl.currentPage = _curIndex;
    
    @autoreleasepool {
        NSMutableArray *removeArray = [NSMutableArray array];
        NSInteger iFirst = miOffsetIndex - 1 ? miOffsetIndex - 1 : 0;
        NSInteger iLast = miOffsetIndex + 1;
        for (UIView *tView in _mVisibleList) {
            if (tView.left < iFirst * mScrollView.width || tView.left > iLast * mScrollView.width) {
                [removeArray addObject:tView];
                [_mRecycleList addObject:tView];
                [tView removeFromSuperview];
            }
        }
        [_mVisibleList removeObjectsInArray:removeArray];
    }
    
    if (_mVisibleList.count == 0) {
        NSInteger lastIndex = [self getRealIndexValue:_curIndex - 1];
        NSInteger nextIndex = [self getRealIndexValue:_curIndex + 1];
        UIView *pageView = [_delegate LXPagingView:self viewAtIndex:lastIndex];
        [_mVisibleList addObject:pageView];
        
        pageView = [_delegate LXPagingView:self viewAtIndex:_curIndex];
        [_mVisibleList addObject:pageView];
        
        pageView = [_delegate LXPagingView:self viewAtIndex:nextIndex];
        [_mVisibleList addObject:pageView];
    }else{
        if (miOffsetIndex == 0) {
            NSInteger lastIndex = [self getRealIndexValue:_curIndex - 1];
            UIView *tView = [_delegate LXPagingView:self viewAtIndex:lastIndex];
//            [_mVisibleList insertObject:tView atIndexe:0];
            [_mVisibleList insertObject:tView atIndex:0];
        }else{
            if (_delegate && [_delegate respondsToSelector:@selector(LXPagingView:viewAtIndex:)]) {
                NSInteger nextIndex = [self getRealIndexValue:_curIndex + 1];
                UIView *tView = [_delegate LXPagingView:self viewAtIndex:nextIndex];
                [_mVisibleList addObject:tView];
                
            }
        }
    }
    
    for (int i = 0; i < 3 ; i ++) {
        UIView *pageView = _mVisibleList[i];
        pageView.frame = CGRectMake(i * mScrollView.width, 0, mScrollView.width, mScrollView.height);
        [mScrollView addSubview:pageView];
    }
    mScrollView.contentOffset = CGPointMake(mScrollView.width, 0);
}

- (NSInteger)getRealIndexValue:(NSInteger)aIndex{
    if (aIndex < 0) {
        return _pageCount - 1;
    }
    if (aIndex >= _pageCount) {
        return 0;
    }
    return aIndex;
}

- (UIView *)dequeueReusablePage{
    if (_mRecycleList.count > 0) {
        UIView *pageView = _mRecycleList[0];
        [_mRecycleList removeObject:pageView];
        return pageView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float fOffX = scrollView.contentOffset.x;
    if (fOffX >= 2 * scrollView.width) {
        _curIndex = [self getRealIndexValue:_curIndex+1];
        miOffsetIndex = 2;
        [self refreshAllView];
    }
    if (fOffX <= 0 ) {
        _curIndex = [self getRealIndexValue:_curIndex - 1];
        miOffsetIndex = 0;
        [self refreshAllView];
    }
}


@end















