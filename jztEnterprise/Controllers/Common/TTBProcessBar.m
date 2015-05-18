//
//  TTBProcessBar.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBProcessBar.h"

@interface TTBProcessBar()
{
    UIImageView *processImg;
    UIImageView *processImgBac;
}

@end

@implementation TTBProcessBar

- (void)initWitgets
{
    processImgBac = [[UIImageView alloc]init];
    [self addSubview:processImgBac];
    
    processImg = [[UIImageView alloc]init];
    [processImgBac addSubview:processImg];
}

- (void)initFrame:(CGRect)frame
{
    processImgBac.image = [TTBUtility resizeImage:@"job_processing_bg"];
    processImgBac.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if(self)
//    {
//        [self initWitgets];
//        
//        [self initFrame:frame];
//    }
//    return self;
//}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self initFrame:frame];
}

- (void)setProcess:(float)process
{
    processImg.image = [TTBUtility resizeImage:@"job_processing_process"];
    processImg.frame = CGRectMake(0, 0, process * processImgBac.frame.size.width, processImgBac.frame.size.height);
}

@end
