//
//  TTBSessionViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "TTBSessionViewIphone.h"

@implementation TTBSessionViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.backgroundColor = [UIColor clearColor];
//    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    self.baseTableView.delaysContentTouches = NO;
    view.backgroundColor = [UIColor clearColor];
    [self.baseTableView setTableFooterView:view];
    self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0,TabBarHeight, 0);
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

@end
