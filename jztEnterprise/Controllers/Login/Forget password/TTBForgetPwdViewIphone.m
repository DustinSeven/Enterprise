//
//  TTBForgetPwdViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBForgetPwdViewIphone.h"

@interface TTBForgetPwdViewIphone()
{
    UIImageView *backImg;
    
    UIView *line0;
    UIView *line2;
}

@end

@implementation TTBForgetPwdViewIphone

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
    backImg = [[UIImageView alloc]init];
    backImg.userInteractionEnabled = YES;
    backImg.image = [UIImage imageNamed:@"login_back_img"];
    [self addSubview:backImg];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"login_close_btn_icon_normal"] forState:UIControlStateNormal];
    [self addSubview:self.closeBtn];
    
    self.accountText = [[UITextField alloc]init];
    self.accountText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.accountText.textColor = APP_FONT_COLOR_NORMAL;
    self.accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, ForgetPwdTextHeight)];
    leftV.backgroundColor = [UIColor clearColor];
    UIImageView *accountTextLeftImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, (ForgetPwdTextHeight - 16.5) / 2, 11, 16.5)];
    accountTextLeftImg.image = [UIImage imageNamed:@"acc_text_left_icon"];
    [leftV addSubview:accountTextLeftImg];
    [self.accountText setLeftView:leftV];
    self.accountText.leftViewMode = UITextFieldViewModeAlways;
    self.accountText.keyboardType = UIKeyboardTypeEmailAddress;
    self.accountText.placeholder = @"旧密码";
    self.accountText.background = [TTBUtility resizeImage:@"login_text_back_fillet_up"];
    [self addSubview:self.accountText];
    
    self.pwdText = [[UITextField alloc]init];
    self.pwdText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdText.textColor = APP_FONT_COLOR_NORMAL;
    self.pwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdText.secureTextEntry = YES;
    leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, ForgetPwdTextHeight)];
    leftV.backgroundColor = [UIColor clearColor];
    UIImageView *pwdTextLeftImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, (ForgetPwdTextHeight - 16.5) / 2, 11, 16.5)];
    pwdTextLeftImg.image = [UIImage imageNamed:@"pwd_text_left_icon"];
    [leftV addSubview:pwdTextLeftImg];
    [self.pwdText setLeftView:leftV];
    self.pwdText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdText.placeholder = @"新密码";
    self.pwdText.background = [TTBUtility resizeImage:@"login_text_back_boxer"];
    [self addSubview:self.pwdText];
    
    self.pwdAgainText = [[UITextField alloc]init];
    self.pwdAgainText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdAgainText.textColor = APP_FONT_COLOR_NORMAL;
    self.pwdAgainText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdAgainText.secureTextEntry = YES;
    leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, ForgetPwdTextHeight)];
    leftV.backgroundColor = [UIColor clearColor];
    UIImageView *pwdAgainTextLeftImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, (ForgetPwdTextHeight - 16.5) / 2, 11, 16.5)];
    pwdAgainTextLeftImg.image = [UIImage imageNamed:@"pwd_text_left_icon"];
    [leftV addSubview:pwdAgainTextLeftImg];
    [self.pwdAgainText setLeftView:leftV];
    self.pwdAgainText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdAgainText.placeholder = @"再次输入新密码";
    self.pwdAgainText.background = [TTBUtility resizeImage:@"login_text_back_fillet_down"];
    [self addSubview:self.pwdAgainText];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[TTBUtility resizeImage:@"login_btn_img"] forState:UIControlStateNormal];
    [self addSubview:self.submitBtn];
    
    line0 = [[UIView alloc]init];
    line0.backgroundColor = [UIColor whiteColor];
    [self addSubview:line0];
    
    line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor whiteColor];
    [self addSubview:line2];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    backImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.closeBtn.frame = CGRectMake(SCREEN_WIDTH - ForgetPwdCloseBtnWidth - 10, 30, ForgetPwdCloseBtnWidth, ForgetPwdCloseBtnWidth);
    
    self.accountText.frame = CGRectMake(ForgetPwdMainSpacing, 120, SCREEN_WIDTH - 2 * ForgetPwdMainSpacing, ForgetPwdTextHeight);
    self.pwdText.frame = CGRectMake(ForgetPwdMainSpacing,CGRectGetMaxY(self.accountText.frame) + 1, SCREEN_WIDTH - 2 * ForgetPwdMainSpacing, ForgetPwdTextHeight);
    self.pwdAgainText.frame = CGRectMake(ForgetPwdMainSpacing,CGRectGetMaxY(self.pwdText.frame) + 1, SCREEN_WIDTH - 2 * ForgetPwdMainSpacing, ForgetPwdTextHeight);
    
    self.submitBtn.frame = CGRectMake(ForgetPwdMainSpacing, CGRectGetMaxY(self.pwdAgainText.frame) + 15, (SCREEN_WIDTH - 2 * ForgetPwdMainSpacing), ForgetPwdBtnHeight);
    
    line0.frame = CGRectMake(ForgetPwdMainSpacing,  CGRectGetMaxY(self.accountText.frame), (SCREEN_WIDTH - 2 * ForgetPwdMainSpacing), 1);
    line2.frame = CGRectMake(ForgetPwdMainSpacing,  CGRectGetMaxY(self.pwdText.frame), (SCREEN_WIDTH - 2 * ForgetPwdMainSpacing), 1);
}
@end
