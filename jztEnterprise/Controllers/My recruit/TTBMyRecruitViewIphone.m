//
//  TTBMyRecruitViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMyRecruitViewIphone.h"

@implementation TTBMyRecruitViewIphone

- (id)init
{
    self  = [super init];
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
    self.baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    self.baseTableView.delaysContentTouches = NO;
    view.backgroundColor = [UIColor clearColor];
    [self.baseTableView setTableFooterView:view];
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}


@end
