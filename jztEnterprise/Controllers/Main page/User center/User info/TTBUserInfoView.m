

//
//  TTBUserInfoView.m
//  jztEnterprise
//
//  Created by Lee on 15/5/18.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserInfoView.h"

@implementation TTBUserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initWidgets];
    }
    return self;
}

- (void)initWidgets
{
    self.backgroundColor = VIEW_BACKGROUND;
}

@end
