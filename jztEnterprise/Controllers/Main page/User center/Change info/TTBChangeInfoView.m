
//
//  TTBChangeInfoView.m
//  jztEnterprise
//
//  Created by Lee on 15/5/19.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChangeInfoView.h"

@implementation TTBChangeInfoView

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
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(0,  10, SCREEN_WIDTH, 45)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.rightViewMode = UITextFieldViewModeWhileEditing;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    _textField.textColor = APP_FONT_COLOR_NORMAL;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_textField];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    view.backgroundColor = [UIColor whiteColor];
    _textField.leftView = view;
}

@end
