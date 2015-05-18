//
//  TTBJobDetailController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobDetailController.h"
#import "TTBSignInController.h"
#import "TTBEditWorkerNumController.h"

@interface TTBJobDetailController ()<UITextViewDelegate>
{
    TTBJobDetailViewBase *_baseView;
    
    
    TTBJobDetailEntity *jobDetailEntity;
}

@end

@implementation TTBJobDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBJobDetailViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.jobContentText.delegate = self;
        
        jobDetailEntity = [[TTBJobDetailEntity alloc]init];
        
        [_baseView.signInBtn addTarget:self action:@selector(signInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.editWorkerNumBtn addTarget:self action:@selector(editWorkerNumBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self initRootView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initRootView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)initRootView
{
    jobDetailEntity.jobName = @"兼职名称长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    jobDetailEntity.jobState = @"未完成签到";
    jobDetailEntity.jobProcess = @"16/20人";
    jobDetailEntity.jobTime = @"时间：长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长期";
    jobDetailEntity.jobAddress =  @"地点：地址长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    jobDetailEntity.jobType = @"工种：类型长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    jobDetailEntity.jobContent = @"工作内容长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";

    
    _baseView.dateLab.text = @"12月13日";
    _baseView.signInStateLab.text = @"签到比例：6/6人(已完成)";
    _baseView.jobImg.image = [UIImage imageNamed:@"work"];
    
    _baseView.titleLab.text = @"杭州兼职兔招聘APP试玩人员（仔细阅读备注信息）";
    _baseView.processIcon.image = [UIImage imageNamed:@"job_process_finish_icon"];
    _baseView.processLab.text = @"已完成";
    _baseView.processBar.process = 0.65;
    _baseView.statusLab.text = @"64%";
    _baseView.timeLab.text = @"长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    _baseView.addressLab.text = @"地址长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    _baseView.jobTypeLab.text = @"类型长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    _baseView.jobContentText.text = @"长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长";
    [_baseView setNeedsLayout];
}

#pragma  mark - editWorkerNumBtnClicked
- (void)editWorkerNumBtnClicked:(UIButton *)button
{
    TTBEditWorkerNumController *editWorkerNumController = [[TTBEditWorkerNumController alloc]init];
    [self.navigationController pushViewController:editWorkerNumController animated:YES];
}

#pragma mark - signInBtnClicked
- (void)signInBtnClicked:(UIButton *)button
{
    TTBSignInController *signInController = [[TTBSignInController alloc]init];
    TTBBaseNavController *signInNav = [[TTBBaseNavController alloc]initWithRootViewController:signInController];
    [self.navigationController presentViewController:signInNav animated:YES completion:^{
        
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -170);
    }];
    
    [_baseView.baseScrollView setContentOffset:CGPointMake(0, _baseView.baseScrollView.contentSize.height - (SCREEN_HEIGHT - JobManageSegHeight)) animated:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
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
