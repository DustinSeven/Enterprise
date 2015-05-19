//
//  TTBChangeInfoViewController.m
//  jztEnterprise
//
//  Created by Lee on 15/5/19.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChangeInfoViewController.h"
#import "TTBChangeInfoView.h"
#import "TTBChangeInfoParam.h"
#import "TTBUserEntity.h"
#import "TTBUserCenterProcess.h"

@interface TTBChangeInfoViewController ()
{
    TTBChangeInfoView *_baseView;
    TTBChangeInfoParam *param;
    TTBUserEntity *userEntity;
}

@end

@implementation TTBChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBChangeInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.view = _baseView;
        userEntity = [TTBUtility readUserDefaults:USER_DEFAULT_ENTITY_KEY];
        param = [[TTBChangeInfoParam alloc]init];
        param.identity = userEntity.identity;
        param.mobile = userEntity.mobile;
        param.pwd = userEntity.pwd;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"修改" target:self action:@selector(submitBtnClicked:) spacing:-15];
    self.navigationItem.leftBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:nil text:nil target:self action:@selector(backBtnClicked:) spacing:-35];
    
    if(_changeType == ChangeInfoType_Name)
    {
        self.title = @"修改姓名";
        _baseView.textField.placeholder = @"输入姓名";
    }
    if(_changeType == ChangeInfoType_Company)
    {
        self.title = @"修改公司名";
        _baseView.textField.placeholder = @"输入公司名";
    }
    if(_changeType == ChangeInfoType_Email)
    {
        self.title = @"修改邮箱";
        _baseView.textField.placeholder = @"输入邮箱";
    }
    if(_changeType == ChangeInfoType_QQ)
    {
        self.title = @"修改QQ";
        _baseView.textField.placeholder = @"输入QQ";
    }
}

#pragma -mark 返回按钮事件
- (void)backBtnClicked:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark 修改按钮事件
- (void)submitBtnClicked:(UIButton *)button
{
    if([[_baseView.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"您还未填写任何信息!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if(_changeType == ChangeInfoType_Name)
        {
            param.account = _baseView.textField.text;
        }
        if(_changeType == ChangeInfoType_Company)
        {
            param.company = _baseView.textField.text;
        }
        if(_changeType == ChangeInfoType_Email)
        {
            param.email = _baseView.textField.text;
        }
        if(_changeType == ChangeInfoType_QQ)
        {
            param.qq = _baseView.textField.text;
        }
        [[TTBUserCenterProcess shareInstance]updateInfoWithParam:[param getDictionary] parentView:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            int code = [[responseObject objectForKey:@"code"] intValue];
            if(code == 200)
            {
                if(_changeType == ChangeInfoType_Name)
                {
                    userEntity.account = param.account;
                }
                if(_changeType == ChangeInfoType_Company)
                {
                    userEntity.company = param.company;
                }
                if(_changeType == ChangeInfoType_Email)
                {
                    userEntity.email = param.email;
                }
                if(_changeType == ChangeInfoType_QQ)
                {
                    userEntity.qq = param.qq;
                }
                
                [TTBUtility removeUserDefaults:USER_DEFAULT_ENTITY_KEY];
                [TTBUtility saveUserDefaults:userEntity key:USER_DEFAULT_ENTITY_KEY];
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误，请检查您的网络连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }];
    }
    
    
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
