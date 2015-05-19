
//
//  TTBLoginController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBLoginController.h"
#import "TTBLoginViewIphone.h"
#import "TTBMainPageController.h"
#import "TTBForgetPwdController.h"
#import "TTBLoginParam.h"
#import "TTBLoginProgress.h"
#import "TTBUserEntity.h"

@interface TTBLoginController ()
{
    TTBLoginViewBase *_baseView;
    
    UITapGestureRecognizer *mainTap;
}

@end

@implementation TTBLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBLoginViewIphone alloc]init];
        self.view = _baseView;
        
        mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewTaped:)];
        [_baseView addGestureRecognizer:mainTap];
        
        [_baseView.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_baseView.forgetPwdBtn addTarget:self action:@selector(forgetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChange:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
    
    if(moveY < 0)
        moveY = - 120;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}

#pragma -mark registerBtnClicked
- (void)registerBtnClicked:(UIButton *)button
{
    TTBForgetPwdController *forgetPwdController = [[TTBForgetPwdController alloc]init];
    forgetPwdController.isRegister = YES;
    [self presentViewController:forgetPwdController animated:YES completion:^{
        
    }];
}

#pragma mark - forgetBtnClicked
- (void)forgetBtnClicked:(UIButton *)button
{
    TTBForgetPwdController *forgetPwdController = [[TTBForgetPwdController alloc]init];
    forgetPwdController.isRegister = NO;
    [self presentViewController:forgetPwdController animated:YES completion:^{
        
    }];
}

#pragma mark - loginBtnClicked
- (void)loginBtnClicked:(UIButton *)button
{
    TTBLoginParam *loginParam = [[TTBLoginParam alloc]init];
    loginParam.mobile = _baseView.accountText.text;
    loginParam.pwd = _baseView.pwdText.text;
    
    [[TTBLoginProgress shareInstance]loginWithParam:[loginParam getDictionary] parentView:_baseView success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        if(!(code == 200))
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    } getInfoSuccess:^(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject) {
        
        int code = [[getInfoResponseObject objectForKey:@"code"] intValue];
        if(code == 200)
        {
            NSArray *data = [getInfoResponseObject objectForKey:@"data"];
            NSDictionary *dic = (NSDictionary *)[data objectAtIndex:0];
            TTBUserEntity *user = [[TTBUserEntity alloc]init];
            user.identity = [dic objectForKey:@"id"];
            user.company =[dic objectForKey:@"company"];
            user.account = [dic objectForKey:@"account"];
            user.img = [dic objectForKey:@"img"];
            user.remark = [dic objectForKey:@"remark"];
            user.sex = [dic objectForKey:@"sex"];
            user.email = [dic objectForKey:@"email"];
            user.qq = [dic objectForKey:@"qq"];
            user.mobile = loginParam.mobile;
            user.pwd = loginParam.pwd;
            
            [TTBUtility saveUserDefaults:user key:USER_DEFAULT_ENTITY_KEY];
            
            TTBMainPageController *mainPageController = [[TTBMainPageController alloc]init];
            [self.navigationController pushViewController:mainPageController animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[getInfoResponseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
        
        
    } getInfoFailure:^(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
    
    [self mainViewTaped:nil];
}

#pragma mark - mainViewTaped
- (void)mainViewTaped:(UITapGestureRecognizer *)tap
{
    [_baseView.accountText resignFirstResponder];
    [_baseView.pwdText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
