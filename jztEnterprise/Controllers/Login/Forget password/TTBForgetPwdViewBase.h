//
//  TTBForgetPwdViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ForgetPwdCloseBtnWidth 50

#define ForgetPwdTextHeight 45
#define ForgetPwdBtnHeight 40

#define ForgetPwdMainSpacing 25

#define ForgetPwdRegisterBtnWidth 100

#define ForgetPwdVeriCodeBtnWidth 67
#define ForgetPwdVeriCodeBtnHeight 25

@interface TTBForgetPwdViewBase : UIView

@property (nonatomic , strong) UITextField *accountText;
@property (nonatomic , strong) UITextField *pwdText;
@property (nonatomic , strong) UITextField *pwdAgainText;
@property (nonatomic , strong) UIButton *submitBtn;
@property (nonatomic , strong) UIButton *closeBtn;

@end
