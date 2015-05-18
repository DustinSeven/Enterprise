//
//  UIView+NewInfo.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/21.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "UIView+NewInfo.h"

@implementation UIView(NewInfo)

- (void)addNewInfoMarkPoint
{
    UIImageView *newInfoImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 4, -4, 8, 8)];
    newInfoImg.image = [UIImage imageNamed:@"new_info_point_icon"];
    newInfoImg.tag = 10000;
    [self addSubview:newInfoImg];
}

- (void)addNewInfoMarkPointAtLoc:(CGPoint)point
{
    UIImageView *newInfoImg = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, point.y, 8, 8)];
    newInfoImg.image = [UIImage imageNamed:@"new_info_point_icon"];
    newInfoImg.tag = 10000;
    [self addSubview:newInfoImg];
}

- (void)removeNewInfoMarkPoint
{
    UIView *newInfoImg = [self viewWithTag:10000];
    [newInfoImg removeFromSuperview];
}

- (void)addNewInfoMarkImg
{
    UIImageView *newInfoImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width , -10, 20, 11)];
    newInfoImg.image = [UIImage imageNamed:@"new_info_img_icon"];
    newInfoImg.tag = 20000;
    [self addSubview:newInfoImg];
}

- (void)removeNewInfoMarkImg
{
    UIView *newInfoImg = [self viewWithTag:20000];
    [newInfoImg removeFromSuperview];
}

- (void)addLineWithFrame:(CGRect)frame
{
    int viewTag = 30000;
    UIView *line = [[UIView alloc]initWithFrame:frame];
    while ([self viewWithTag:viewTag])
    {
        viewTag++;
    }
    line.tag = viewTag;
    line.backgroundColor = SeparatorColor;
    [self addSubview:line];
}

- (void)removeLines
{
    int viewTag = 30000;
    UIView *line;
    while ((line = [self viewWithTag:viewTag]))
    {
        [line removeFromSuperview];
        viewTag++;
    }
}

@end
