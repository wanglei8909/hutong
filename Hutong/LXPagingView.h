//
//  LXPagingView.h
//  Fortune
//
//  Created by 王蕾 on 16/5/16.
//  Copyright © 2016年 Fortune. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LXPagingViewDelegate;

@interface LXPagingView : UIView<UIScrollViewDelegate>
{
    UIPageControl *mPageCtrl;
    UIScrollView *mScrollView;
    NSTimer *theTimer;
    NSInteger miOffsetIndex;
}

@property (nonatomic, strong) NSMutableArray *mRecycleList;
@property (nonatomic, strong) NSMutableArray *mVisibleList;
@property (nonatomic, weak) id<LXPagingViewDelegate> delegate;
@property (nonatomic, readonly) NSInteger pageCount;
@property (nonatomic, readonly) NSInteger curIndex;
@property (nonatomic, assign) BOOL isAutoPlay;    


- (void)reloadData;
- (UIView *)dequeueReusablePage;
- (void)startAutoScroll;
- (void)stopAutoScroll;

@end


@protocol LXPagingViewDelegate <NSObject>

- (NSInteger)numberOfPagesInPagingView:(LXPagingView *)pagingView;
- (UIView *)LXPagingView:(LXPagingView *)pagingView viewAtIndex:(NSInteger)index;

@optional

- (void)LXPagingView:(LXPagingView *)pagingView pageChangeToIndex:(NSInteger)index;

@end
