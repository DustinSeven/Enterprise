//
//  TTBForgetPwdController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBForgetPwdController.h"
#import "TTBForgetPwdViewIphone.h"
#import "TTBLoginProgress.h"
#import "TTBLoginParam.h"
#import "TTBUserEntity.h"
#import "TTBChanePwdParam.h"

@interface TTBForgetPwdController ()
{
    TTBForgetPwdViewBase *_baseView;
    
    UITapGestureRecognizer *mainTap;
}

@end

@implementation TTBForgetPwdController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBForgetPwdViewIphone alloc]init];
        self.view = _baseView;
        
        [_baseView.closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewTaped:)];
        [_baseView addGestureRecognizer:mainTap];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.isRegister)
    {
        _baseView.accountText.placeholder = @"手机号";
        _baseView.pwdText.placeholder = @"密码";
        _baseView.pwdAgainText.placeholder = @"再次输入密码";
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
        moveY = - 90;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}


- (BOOL)check
{
    NSString *mobile = [_baseView.accountText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd = [_baseView.pwdText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwdAgain = [_baseView.pwdAgainText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(![TTBUtility checkTel:mobile])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"请输入正确的手机号！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }else if(![pwd isEqualToString:pwdAgain])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"两次输入的密码不一致！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }else if([pwd isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"请输入密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    else
    {
        return YES;
    }

}


#pragma -mark submitBtnClicked
- (void)submitBtnClicked:(UIButton *)button
{
    if(_isRegister)
    {
        if([self check])
        {
            TTBLoginParam *param = [[TTBLoginParam alloc]init];
            param.mobile = _baseView.accountText.text;
            param.pwd = _baseView.pwdText.text;
            
            [[TTBLoginProgress shareInstance]registerWithParam:[param getDictionary] parentView:_baseView success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                int code = [[responseObject objectForKey:@"code"] intValue];
                if(code == 200)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[responseObject objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }];
        }
    }
    else
    {
        
    }
}

#pragma -mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - mainViewTaped
- (void)mainViewTaped:(UITapGestureRecognizer *)tap
{
    [_baseView.accountText resignFirstResponder];
    [_baseView.pwdText resignFirstResponder];
    [_baseView.pwdAgainText resignFirstResponder];
}

#pragma mark - closeBtnClicked
- (void)closeBtnClicked:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
