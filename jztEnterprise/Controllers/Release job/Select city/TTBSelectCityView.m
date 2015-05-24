//
//  TTBSelectCityView.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSelectCityView.h"

@implementation TTBSelectCityView

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.baseTableView = [InfiniteTreeView loadFromXib];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
    [self addSubview:self.baseTableView];
}

@end
