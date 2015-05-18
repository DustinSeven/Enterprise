//
//  TTBBaseActionSheetView.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseActionSheetView.h"

@interface TTBBaseActionSheetView()<UIGestureRecognizerDelegate>

@end

@implementation TTBBaseActionSheetView

- (id)init
{
    self = [self initWithFrame:CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight)];
    if(self)
    {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.tag = 300;
    
    UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMainScreen:)];
    mainTap.delegate = self;
    [self addGestureRecognizer:mainTap];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)tapMainScreen:(UITapGestureRecognizer *)tap
{
    
}

- (void)showInParentView:(UIView *)parentView
{
    [parentView addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view.tag == 300)
    {
        return YES;
    }
    return NO;
}

@end
