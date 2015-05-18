//
//  TTBMemberViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberViewIphone.h"

@interface TTBMemberViewIphone()
{
    UIView *headBackView;
}

@end

@implementation TTBMemberViewIphone

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
    
    headBackView = [[UIView alloc]init];
    headBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headBackView];
    
    self.jobTimeLab = [[UILabel alloc]init];
    self.jobTimeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 3];
    self.jobTimeLab.textAlignment = NSTextAlignmentCenter;
    self.jobTimeLab.textColor = APP_FONT_COLOR_NORMAL;
    [headBackView addSubview:self.jobTimeLab];
    
    self.processLab = [[UILabel alloc]init];
    self.processLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.processLab.textAlignment = NSTextAlignmentCenter;
    self.processLab.textColor = APP_FONT_COLOR_NORMAL;
    [headBackView addSubview:self.processLab];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:@"member_back_btn_icon_normal"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"member_back_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [headBackView addSubview:self.backBtn];
    
    self.forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forwardBtn setImage:[UIImage imageNamed:@"member_forward_btn_icon_normal"] forState:UIControlStateNormal];
    [self.forwardBtn setImage:[UIImage imageNamed:@"member_forward_btn_icon_pressed"] forState:UIControlStateHighlighted];
    [headBackView addSubview:self.forwardBtn];
    
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    //    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.baseTableView setTableFooterView:view];
    [self addSubview:self.baseTableView];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JobManageSegHeight);
    
    headBackView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, MemeberHeadView);
    [headBackView addLineWithFrame:CGRectMake(0, MemeberHeadView - 0.5, SCREEN_WIDTH, 0.5)];
    
    self.jobTimeLab.frame = CGRectMake((SCREEN_WIDTH - LabWidth) / 2, 5, LabWidth, 20);
    self.processLab.frame = CGRectMake((SCREEN_WIDTH - LabWidth) / 2, CGRectGetMaxY(self.jobTimeLab.frame), LabWidth, 20);
    
    self.backBtn.frame = CGRectMake(CGRectGetMinX(self.jobTimeLab.frame) - MemberBackBtnWidth, 0, MemberBackBtnWidth, MemberBackBtnHeight);
    self.forwardBtn.frame = CGRectMake(CGRectGetMaxX(self.jobTimeLab.frame), 0, MemberBackBtnWidth, MemberBackBtnHeight);
    
    self.baseTableView.frame = CGRectMake(0, CGRectGetMaxY(headBackView.frame) + 10, SCREEN_WIDTH, SCREEN_HEIGHT - JobManageSegHeight - (CGRectGetMaxY(headBackView.frame) + 10) );
}

@end
