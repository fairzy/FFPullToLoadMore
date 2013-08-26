//
//  ViewController.h
//  LoadMoreDemo
//
//  Created by fairzy on 13-8-26.
//  Copyright (c) 2013年 fairzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFPullToLoadMoreView.h"

@interface ViewController : UIViewController<FFPullToLoadMoreViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FFPullToLoadMoreView * loadMoreView;

@end
