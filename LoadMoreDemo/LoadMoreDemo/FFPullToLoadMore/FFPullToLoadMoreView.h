//
//  FFPullToLoadMoreView.h
//
//  Created by mac  on 13-8-26.
//  Copyright (c) 2013年 fairzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

enum FFPullToLoadMoreState {
    FFPullToLoadMoreStateNormal = 0,  // normal
    FFPullToLoadMoreStatePulling,      // pulling
    FFPullToLoadMoreStateLoading
    };

@protocol FFPullToLoadMoreViewDelegate <NSObject>

- (BOOL)ffPullToLoadMoreViewDataSourceIsLoading;
- (void)ffPullToLoadMoreViewDidTriggerRefresh;

@end

@interface FFPullToLoadMoreView : UIView{
    enum FFPullToLoadMoreState _loadState;
    CALayer *_arrowImage;
}

@property (nonatomic, weak) id<FFPullToLoadMoreViewDelegate> delegate;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIActivityIndicatorView * loadingIndicator;

- (void)ffLoadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)ffLoadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)ffLoadMoreViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
