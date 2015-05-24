//
//  TTBSelectInterviewViewController.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSelectInterviewViewController.h"
#import "TTBSelectInterviewView.h"

@interface TTBSelectInterviewViewController ()
{
    TTBSelectInterviewView *_baseView;
}

@end

@implementation TTBSelectInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBSelectInterviewView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.view = _baseView;
        
        [_baseView.submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.title = @"面试信息";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"不需要" target:self action:@selector(noNeedBtnClicked:) spacing:-15];
}

#pragma -mark 不需要按钮事件
- (void)noNeedBtnClicked:(UIButton *)button
{
    if([_delegate respondsToSelector:@selector(didFinishInputInterviewTime:address:)])
    {
        [_delegate didFinishInputInterviewTime:nil address:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma -mark 确认按钮事件
- (void)submitBtnClicked:(UIButton *)button
{
    NSString *time = [_baseView.timeText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *address = [_baseView.addreText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(([time isEqualToString:@""] && ![address isEqualToString:@""]) || (![time isEqualToString:@""] && [address isEqualToString:@""]))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"您未完成输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if([_delegate respondsToSelector:@selector(didFinishInputInterviewTime:address:)])
        {
            [_delegate didFinishInputInterviewTime:time address:address];
            [self.navigationController popViewControllerAnimated:YES];
        }
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
