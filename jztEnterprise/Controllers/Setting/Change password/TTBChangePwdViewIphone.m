//
//  TTBChangePwdViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChangePwdViewIphone.h"

@implementation TTBChangePwdViewIphone

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
    self.baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.baseTableView setTableFooterView:view];
    self.baseTableView.bounces = NO;
    [self addSubview:self.baseTableView];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.layer.cornerRadius = 3;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH - 2 * 12.5, ChangePwdBtnHeight)] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(SCREEN_WIDTH - 2 * 12.5, ChangePwdBtnHeight)] forState:UIControlStateHighlighted];
    [self.submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.textColor = [UIColor whiteColor];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self addSubview:self.submitBtn];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, 12.5 + HeadViewHeight, SCREEN_WIDTH, 3 * ChangePwdCellHeight);
    
    self.submitBtn.frame = CGRectMake(12.5, CGRectGetMaxY(self.baseTableView.frame) + 12.5, SCREEN_WIDTH - 2 * 12.5, ChangePwdBtnHeight);
}

@end
