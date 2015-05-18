//
//  TTBBaseController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseController.h"

@interface TTBBaseController ()

@end

@implementation TTBBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
//        self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.navigationController.childViewControllers.count > 1)
    {
        self.navigationItem.leftBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:nil target:self action:@selector(backBtnClicked:) spacing:-35];
    }
}

#pragma mark - back btn clicked
- (void)backBtnClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
