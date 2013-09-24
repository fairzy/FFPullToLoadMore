//
//  ViewController.m
//  LoadMoreDemo
//
//  Created by fairzy on 13-8-26.
//  Copyright (c) 2013年 fairzy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    BOOL _loadingMore;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // add as footer view
    FFPullToLoadMoreView * footview = [[FFPullToLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    footview.delegate = self;
    self.tableView.tableFooterView = footview;
    self.loadMoreView = footview;
    
    self.dataSource = [NSMutableArray arrayWithCapacity:50];
    for (int i = 0; i < 50; i++) {
        [self.dataSource addObject: [NSNumber numberWithInt:i]];
    }
}

- (void)requestData{
    [self performSelector:@selector(requestDone) withObject:nil afterDelay:2.0f];
}

- (void)requestDone{
    [self.loadMoreView ffLoadMoreViewDataSourceDidFinishedLoading:self.tableView];
    
    int oldrow = self.dataSource.count;
    
    NSArray *tmpArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:oldrow],
                         [NSNumber numberWithInt:oldrow+1], nil];
    NSMutableArray * paths = [NSMutableArray arrayWithCapacity:tmpArray.count];
    for (int i=0; i< tmpArray.count; i++) {
        NSIndexPath * path = [NSIndexPath indexPathForRow:oldrow+i inSection:0];
        [paths addObject:path];
    }
    [self.dataSource addObjectsFromArray:tmpArray];
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - UITableView
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.loadMoreView ffLoadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[self.loadMoreView ffLoadMoreScrollViewDidEndDragging:scrollView];
}

#pragma mark - Load more Methods
- (BOOL)ffPullToLoadMoreViewDataSourceIsLoading{
    return  _loadingMore;
}
- (void)ffPullToLoadMoreViewDidTriggerRefresh{
    [self requestData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
