

//
//  TTBLoginViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBLoginViewIphone.h"

@interface TTBLoginViewIphone()
{
    UIImageView *backImg;
    UIImageView *logoImg;
    
    UIView *line;
}

@end

@implementation TTBLoginViewIphone

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
    
    backImg = [[UIImageView alloc]init];
    backImg.userInteractionEnabled = YES;
    backImg.image = [UIImage imageNamed:@"login_back_img"];
    [self addSubview:backImg];
    
    logoImg = [[UIImageView alloc]init];
    logoImg.image = [UIImage imageNamed:@"login_logo_img"];
    [self addSubview:logoImg];
    
    self.accountText = [[UITextField alloc]init];
    self.accountText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.accountText.textColor = APP_FONT_COLOR_NORMAL;
    self.accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, LoginTextHeight)];
    leftV.backgroundColor = [UIColor clearColor];
    UIImageView *accountTextLeftImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, (LoginTextHeight - 16.5) / 2, 11, 16.5)];
    accountTextLeftImg.image = [UIImage imageNamed:@"acc_text_left_icon"];
    [leftV addSubview:accountTextLeftImg];
    [self.accountText setLeftView:leftV];
    self.accountText.leftViewMode = UITextFieldViewModeAlways;
    self.accountText.keyboardType = UIKeyboardTypeEmailAddress;
    self.accountText.placeholder = @"用户名";
    self.accountText.background = [TTBUtility resizeImage:@"login_text_back_fillet_up"];
    [self addSubview:self.accountText];
    
    self.pwdText = [[UITextField alloc]init];
    self.pwdText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.pwdText.textColor = APP_FONT_COLOR_NORMAL;
    self.pwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdText.secureTextEntry = YES;
    leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, LoginTextHeight)];
    leftV.backgroundColor = [UIColor clearColor];
    UIImageView *pwdTextLeftImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, (LoginTextHeight - 16.5) / 2, 11, 16.5)];
    pwdTextLeftImg.image = [UIImage imageNamed:@"pwd_text_left_icon"];
    [leftV addSubview:pwdTextLeftImg];
    [self.pwdText setLeftView:leftV];
    self.pwdText.leftViewMode = UITextFieldViewModeAlways;
    self.pwdText.placeholder = @"密码";
    self.pwdText.background = [TTBUtility resizeImage:@"login_text_back_fillet_down"];
    [self addSubview:self.pwdText];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[TTBUtility resizeImage:@"login_btn_img"] forState:UIControlStateNormal];
    [self addSubview:self.loginBtn];
    
    self.forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self.forgetPwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.forgetPwdBtn setTitleColor:SeparatorColor forState:UIControlStateHighlighted];
    self.forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.forgetPwdBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 20, 0);
    [self addSubview:self.forgetPwdBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:SeparatorColor forState:UIControlStateHighlighted];
    self.registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.registerBtn];
    
    line = [[UIView alloc]init];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    backImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    logoImg.frame = CGRectMake((SCREEN_WIDTH - (LoginLogoWidth - 25)) / 2, 70, LoginLogoWidth, LoginLogoHeight);
    
    self.accountText.frame = CGRectMake(LoginMainSpacing, CGRectGetMaxY(logoImg.frame) + 35, (SCREEN_WIDTH - 2 * LoginMainSpacing), LoginTextHeight);
    self.pwdText.frame = CGRectMake(LoginMainSpacing, CGRectGetMaxY(self.accountText.frame) + 1, (SCREEN_WIDTH - 2 * LoginMainSpacing), LoginTextHeight);
    
    self.loginBtn.frame = CGRectMake(LoginMainSpacing, CGRectGetMaxY(self.pwdText.frame) + 15, (SCREEN_WIDTH - 2 * LoginMainSpacing), LoginBtnHeight);
    
    self.forgetPwdBtn.frame = CGRectMake(SCREEN_WIDTH - 100 - LoginMainSpacing, CGRectGetMaxY(self.loginBtn.frame) + 5, 100, LoginBtnHeight);
    
    self.registerBtn.frame = CGRectMake((SCREEN_WIDTH - LoginRegisterBtnWidth) / 2, SCREEN_HEIGHT - LoginBtnHeight - 20, LoginRegisterBtnWidth, LoginBtnHeight);
    
    line.frame = CGRectMake(LoginMainSpacing,  CGRectGetMaxY(self.accountText.frame), (SCREEN_WIDTH - 2 * LoginMainSpacing), 1);

}

@end
