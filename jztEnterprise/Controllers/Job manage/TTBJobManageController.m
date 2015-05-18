//
//  TTBJobManageController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobManageController.h"
#import "TTBJobDetailController.h"
#import "TTBMemberController.h"
#import "TTBReleaseJobController.h"
#import "TTBMemberChoiseController.h"

@interface TTBJobManageController ()
{
    TTBJobManageViewBase *_baseView;
    
    TTBJobDetailController *jobDetailController;
    TTBMemberController *membreController;
}

@end

@implementation TTBJobManageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBJobManageViewIphone alloc]init];
        self.view = _baseView;
        
        [self initRootView];
        
        self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"发布招募" target:self action:@selector(releaseJobBtnClicked) spacing:-15];
    }
}

- (void)initRootView
{
    self.title = @"招募详情";
//    self.navigationItem.leftBarButtonItems = [ZGUtility customBarButtonItemWithNormalImg:[UIImage imageNamed:@"back_btn_icon_normal"] pressedImg:[UIImage imageNamed:@"back_btn_icon_pressed"] text:@"" target:self action:@selector(menuBtnClicked:) spacing:-15];
    
    jobDetailController = [[TTBJobDetailController alloc]init];
    membreController = [[TTBMemberController alloc]init];
    [membreController.view setNeedsLayout];
    
    [self addChildViewController:jobDetailController];
    [self addChildViewController:membreController];
    [self.view addSubview:jobDetailController.view];
    
    [_baseView.segController addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)segChange:(id)sender
{
    int index = (int)_baseView.segController.selectedSegmentIndex;
    
    if(index == 0)
    {
        [self transitionFromViewController:membreController toViewController:jobDetailController duration:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
        } completion:^(BOOL finished) {
            
            self.title = @"招募详情";
            self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"发布招募" target:self action:@selector(releaseJobBtnClicked) spacing:-15];
            [_baseView.segController setImage:[[UIImage imageNamed:@"job_manage_segment_job_detail_seg_bg_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  forSegmentAtIndex:0];
            [_baseView.segController setImage:[[UIImage imageNamed:@"job_manage_segment_worker_seg_bg_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  forSegmentAtIndex:1];
            
        }];
    }
    
    if(index == 1)
    {
        [self transitionFromViewController:jobDetailController toViewController:membreController duration:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
        } completion:^(BOOL finished) {
            
            self.title = @"报名人员";
            [_baseView.segController setImage:[[UIImage imageNamed:@"job_manage_segment_job_detail_seg_bg_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  forSegmentAtIndex:0];
            [_baseView.segController setImage:[[UIImage imageNamed:@"job_manage_segment_worker_seg_bg_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  forSegmentAtIndex:1];
            self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"群发通知" target:self action:@selector(groupSendingBtnClicked) spacing:-15];
        }];
    }
}

- (void)releaseJobBtnClicked
{
    TTBReleaseJobController *releaseJobController = [[TTBReleaseJobController alloc]init];
    [self.navigationController pushViewController:releaseJobController animated:YES];
}

- (void)groupSendingBtnClicked
{
    TTBMemberChoiseController *memberChoiseController = [[TTBMemberChoiseController alloc]init];
    [self.navigationController pushViewController:memberChoiseController animated:YES];
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
