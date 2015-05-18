//
//  TTBHistoryDropListView.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/27.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBDropListView.h"

@interface TTBDropListView()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backGroundView;
    
    UITableView *baseTableView;
    
    NSArray *tableTitlesArr;
}

@end

@implementation TTBDropListView

- (id)init
{
    self = [super init];
    if(self)
    {
        backGroundView = [[UIView alloc]init];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        backGroundView = [[UIView alloc]init];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];
        
        self.tag = 400;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)tapMainScreen:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.2 animations:^{
        
        backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        baseTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        self.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)showWithTitlesArrAsHistoryList:(NSArray *)titlesArr parentView:(UIView *)parentView
{
    tableTitlesArr = titlesArr;
    baseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.showsVerticalScrollIndicator = YES;
    UIView *view = [UIView new];
    baseTableView.delaysContentTouches = NO;
    view.backgroundColor = [UIColor clearColor];
    [baseTableView setTableFooterView:view];
    baseTableView.bounces = NO;
    baseTableView.dataSource = self;
    baseTableView.delegate = self;
    [backGroundView addSubview:baseTableView];
    
    backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    [UIView animateWithDuration:0.2 animations:^{
        
        [parentView addSubview:self];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 5 * DropListRowHeight);
        baseTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 5 * DropListRowHeight);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableTitlesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DropListCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [tableTitlesArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = APP_FONT_COLOR_NORMAL;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DropListRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    [self.delegate clickedOnItemOnIndex:(int)indexPath.row ofDropList:self];
    
    [self tapMainScreen:nil];
}


@end
