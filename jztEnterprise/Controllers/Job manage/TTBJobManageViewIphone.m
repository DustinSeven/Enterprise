//
//  TTBJobManageViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobManageViewIphone.h"

@interface TTBJobManageViewIphone()
{
    NSArray *segmentedArray;
}

@end

@implementation TTBJobManageViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    segmentedArray = [[NSArray alloc]initWithObjects:@"信息",@"联系人",nil];
    self.segController = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segController.selectedSegmentIndex = 0;
    self.segController.tintColor = SeparatorColor;
    self.segController.momentary = YES;
    
    [self.segController setImage:[[UIImage imageNamed:@"job_manage_segment_job_detail_seg_bg_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  forSegmentAtIndex:0];
    [self.segController setImage:[[UIImage imageNamed:@"job_manage_segment_worker_seg_bg_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]  forSegmentAtIndex:1];
    [self.segController setBackgroundImage:[TTBUtility resizeImage:@"job_manage_segment_bg_img"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segController setBackgroundImage:[TTBUtility resizeImage:@"job_manage_segment_bg_img"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.segController setBackgroundImage:[TTBUtility resizeImage:@"job_manage_segment_bg_img"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segController setBackgroundColor:[UIColor whiteColor]];
    
    
    
//    [self.segController addNewInfoMarkPoint];
    
    //    [self.segController addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    [self addSubview:self.segController];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.segController.frame = CGRectMake(0,SCREEN_HEIGHT - JobManageSegHeight,SCREEN_WIDTH,JobManageSegHeight);
}

@end
