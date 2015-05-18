

//
//  TTBUserInfoViewController.m
//  jztEnterprise
//
//  Created by Lee on 15/5/18.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserInfoViewController.h"
#import "TTBUserInfoView.h"

@interface TTBUserInfoViewController ()
{
    TTBUserInfoView *_baseView;
}

@end

@implementation TTBUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBUserInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.view = _baseView;
        
        self.title = @"商家信息";
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
