//
//  TTBLoginViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginLogoWidth 112.5
#define LoginLogoHeight 124

#define LoginMainSpacing 25

#define LoginTextHeight 45

#define LoginBtnHeight 40

#define LoginRegisterBtnWidth 100

@interface TTBLoginViewBase : UIView

@property (nonatomic , strong) UITextField *accountText;
@property (nonatomic , strong) UITextField *pwdText;
@property (nonatomic , strong) UIButton *loginBtn;
@property (nonatomic , strong) UIButton *forgetPwdBtn;
@property (nonatomic , strong) UIButton *registerBtn;



@end
