//
//  TTBSignInViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSignInViewIphone.h"

@interface TTBSignInViewIphone()
{
    UILabel *noticeLab;
    
    UILabel *importLab;
}

@end

@implementation TTBSignInViewIphone

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
    
    noticeLab = [[UILabel alloc]init];
    noticeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    noticeLab.textColor = APP_FONT_COLOR_NORMAL;
    noticeLab.numberOfLines = 0;
    noticeLab.lineBreakMode = NSLineBreakByWordWrapping;
    noticeLab.text = @"请学生打开自己的APP签到功能，扫描该二维码，对于无法完成扫码的学生，请在人员列表内完成手动签到。";
    [self addSubview:noticeLab];
    
    importLab = [[UILabel alloc]init];
    importLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL + 1];
    importLab.textColor = MainColorNormal;
    importLab.textAlignment = NSTextAlignmentCenter;
    importLab.text = @"※请妥善保管好自己的二维码，防止学生偷拍！";
    [self addSubview:importLab];
    
    self.qrImg = [[UIImageView alloc]init];
    [self addSubview:self.qrImg];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    noticeLab.frame = CGRectMake(12.5, 20 + HeadViewHeight, SCREEN_WIDTH - 2 * 12.5, 60);
    
    importLab.frame = CGRectMake(0, CGRectGetMaxY(noticeLab.frame) + 20, SCREEN_WIDTH, 20);
    
    self.qrImg.frame = CGRectMake(30, CGRectGetMaxY(importLab.frame) + 10, SCREEN_WIDTH - 60, SCREEN_WIDTH - 60);
}

@end
