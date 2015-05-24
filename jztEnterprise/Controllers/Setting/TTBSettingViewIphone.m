//
//  TTBSettingViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSettingViewIphone.h"

@interface TTBSettingViewIphone()
{
    UIView *line1;
}
@end

@implementation TTBSettingViewIphone

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
    
    self.baseTableView = [[UITableView alloc]init];
    self.baseTableView.bounces = NO;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.baseTableView];
    
    line1 = [[UIView alloc]init];
    line1.backgroundColor = SettingListSeparatorColor;
    [self addSubview:line1];
    
    self.logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.logoutBtn.layer.cornerRadius = 3;
    self.logoutBtn.layer.masksToBounds = YES;
    self.logoutBtn.backgroundColor = [UIColor clearColor];
    [self.logoutBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SettingLogoutBtnWidth, SettingLogoutBtnHeight)] forState:UIControlStateNormal];
    [self.logoutBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(SettingLogoutBtnWidth, SettingLogoutBtnHeight)] forState:UIControlStateHighlighted];
    [self addSubview:self.logoutBtn];
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight + 10, SCREEN_WIDTH, SettingListCellHeight);
    
    line1.frame = CGRectMake(0, self.baseTableView.frame.origin.y - 0.5, SCREEN_WIDTH, 0.5);
    
    self.logoutBtn.frame = CGRectMake((SCREEN_WIDTH - SettingLogoutBtnWidth) / 2, self.baseTableView.frame.origin.y + self.baseTableView.frame.size.height + 15, SettingLogoutBtnWidth, SettingLogoutBtnHeight);
    
    
}


@end
