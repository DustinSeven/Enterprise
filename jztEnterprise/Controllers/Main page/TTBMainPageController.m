//
//  TTBSocialController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "TTBMainPageController.h"

@interface TTBMainPageController ()
{
    
    TTBSessionController *sessionController;
    TTBJobController *jobController;
    TTBUserCenterController *userCenterController;
}

@end

@implementation TTBMainPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.navigationController.navigationBarHidden = NO;
//        _baseView = [[TTBMainPageViewIphone alloc]init];
//        self.view = _baseView;
        
        [self initRootView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBar.hidden = NO;
}

- (void)initRootView
{
//    self.navigationItem.leftBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"编辑" target:self action:@selector(editBtnClicked:) spacing:-15];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tap_back"];
    [[UITabBar appearance] setBackgroundImage:[tabBarBackground resizableImageWithCapInsets:UIEdgeInsetsZero]];
    
    jobController = [[TTBJobController alloc]init];
    jobController.hidesBottomBarWhenPushed = NO;
    TTBBaseNavController *jobNav = [[TTBBaseNavController alloc]initWithRootViewController:jobController];
    jobController.title = @"工作";
    jobNav.tabBarItem.image = [UIImage imageNamed:@"tap_job_btn_icon_normal"];
    jobNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tap_job_btn_icon_pressed"];
    jobNav.tabBarItem.title = @"工作";
    
    userCenterController = [[TTBUserCenterController alloc]init];
    userCenterController.hidesBottomBarWhenPushed = NO;
    TTBBaseNavController *userCenterNav = [[TTBBaseNavController alloc]initWithRootViewController:userCenterController];
    userCenterController.title = @"我的";
    userCenterNav.tabBarItem.title = @"我的";
    userCenterNav.tabBarItem.image = [UIImage imageNamed:@"tap_user_center_btn_icon_normal"];
    userCenterNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tap_user_center_btn_icon_pressed"];
    
    sessionController = [[TTBSessionController alloc]init];
    sessionController.hidesBottomBarWhenPushed = NO;
    TTBBaseNavController *sessionNav = [[TTBBaseNavController alloc]initWithRootViewController:sessionController];
    sessionController.title = @"聊天";
    sessionNav.tabBarItem.title = @"聊天";
    sessionNav.tabBarItem.image = [UIImage imageNamed:@"tap_session_btn_icon_normal"];
    sessionNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tap_session_btn_icon_pressed"];
    
    self.viewControllers = [[NSArray alloc]initWithObjects:jobNav,sessionNav,userCenterNav, nil];
//    self.tabBar.translucent = YES;
    
    [self setSelectedIndex:0];
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
