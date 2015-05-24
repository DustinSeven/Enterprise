

//
//  TTBSelectInterviewView.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSelectInterviewView.h"

@implementation TTBSelectInterviewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initWidgets];
    }
    return self;
}

- (void)initWidgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    _timeText = [[UITextField alloc]initWithFrame:CGRectMake(0, HeadViewHeight + 10, SCREEN_WIDTH, 45)];
    _timeText.textColor = APP_FONT_COLOR_NORMAL;
    _timeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _timeText.leftViewMode = UITextFieldViewModeAlways;
    _timeText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    _timeText.backgroundColor = [UIColor whiteColor];
    _timeText.placeholder = @"输入面试时间";
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    _timeText.leftView = view;
    [self addSubview:_timeText];
    
    _addreText = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timeText.frame) + 10, SCREEN_WIDTH, 45)];
    _addreText.textColor = APP_FONT_COLOR_NORMAL;
    _addreText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addreText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    _addreText.backgroundColor = [UIColor whiteColor];
    _addreText.placeholder = @"输入面试地点";
    _addreText.leftViewMode = UITextFieldViewModeAlways;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    _addreText.leftView = view1;
    [self addSubview:_addreText];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake((SCREEN_WIDTH - ReleaseJobFootCellReleaseBtnWidth) / 2, CGRectGetMaxY(_addreText.frame) + 20, ReleaseJobFootCellReleaseBtnWidth, ReleaseJobFootCellReleaseBtnHeight);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ReleaseJobFootCellReleaseBtnWidth, ReleaseJobFootCellReleaseBtnHeight)] forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ReleaseJobFootCellReleaseBtnWidth, ReleaseJobFootCellReleaseBtnHeight)] forState:UIControlStateNormal];
    [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.layer.masksToBounds = YES;
    [self addSubview:_submitBtn];
}

@end
