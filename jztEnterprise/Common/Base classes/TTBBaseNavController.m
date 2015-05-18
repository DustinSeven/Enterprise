//
//  TTBBaseNavController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseNavController.h"

@interface TTBBaseNavController ()

@end

@implementation TTBBaseNavController

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        self.navigationBarHidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH, HeadViewHeight)];
    UIEdgeInsets edgeInsets;
    edgeInsets.left = 0.0f;
    edgeInsets.top = 0.0f;
    edgeInsets.right = 0.0f;
    edgeInsets.bottom = 0.0f;
    image = [image resizableImageWithCapInsets:edgeInsets];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 5]}];
    
    //    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;

    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
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
