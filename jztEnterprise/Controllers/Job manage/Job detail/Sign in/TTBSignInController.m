//
//  TTBSignInController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSignInController.h"
#import "TTBSignInViewIphone.h"
#import "QRCodeGenerator.h"

@interface TTBSignInController ()
{
    TTBSignInViewBase *_baseView;
}

@end

@implementation TTBSignInController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBSignInViewIphone alloc]init];
        self.view = _baseView;
        
        self.title = @"签到";
        
        self.navigationItem.leftBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:nil target:self action:@selector(backBtnClicked:) spacing:-35];
        
        _baseView.qrImg.image = [QRCodeGenerator qrImageForString:@"dsadsadsaddssdsadsad13254654654354432$%^&*%#$%^&*$&*&*(&%^$%^%&*^&*$%^$&^^(*&*(fdsfdsfdsfdfdafdfdsa放大师傅呢反倒是安抚你多少啦泛利大厦发的发的啥发的啥发的啥发的啥发的啥发的啥发的啥发的啥发的啥发的啥啊sadasd" imageSize:(SCREEN_WIDTH - 60) * 2];
    }
}

#pragma mark - back btn clicked
- (void)backBtnClicked:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
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
