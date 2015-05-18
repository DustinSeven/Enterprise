//
//  TTBUserCenterViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserCenterViewIphone.h"

@interface TTBUserCenterViewIphone()
{
    UIImageView *topBackImg;
    UIView *enterImgBackView;
    
    UIView *whiteBackView;
}

@end

@implementation TTBUserCenterViewIphone

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
    
    topBackImg = [[UIImageView alloc]init];
    topBackImg.image = [UIImage imageNamed:@"user_center_top_back_img"];
    [self addSubview:topBackImg];
    
    whiteBackView = [[UIView alloc]init];
    whiteBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteBackView];
    
    enterImgBackView = [[UIView alloc]init];
    enterImgBackView.backgroundColor = [UIColor clearColor];
    enterImgBackView.layer.borderWidth = 3;
    enterImgBackView.layer.cornerRadius = 5;
    enterImgBackView.layer.borderColor = [UIColor colorWithRed:237 / 255 green:237 / 255 blue:237 / 255 alpha:0.1].CGColor;
    [self addSubview:enterImgBackView];
    
    self.enterImg = [[UIImageView alloc]init];
    self.enterImg.userInteractionEnabled = YES;
    [enterImgBackView addSubview:self.enterImg];
    
    self.enterName = [[UILabel alloc]init];
    self.enterName.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL + 5];
    self.enterName.textColor = APP_FONT_COLOR_NORMAL;
    self.enterName.lineBreakMode = NSLineBreakByWordWrapping;
    self.enterName.numberOfLines = 0;
    [self addSubview:self.enterName];
    
    self.menuTableView = [[UITableView alloc]init];
    self.menuTableView.showsVerticalScrollIndicator = NO;
    self.menuTableView.bounces = NO;
    [self addSubview:self.menuTableView];

}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    topBackImg.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, MyTopBackImgHeight);
    
    whiteBackView.frame = CGRectMake(0, CGRectGetMaxY(topBackImg.frame), SCREEN_WIDTH, 100);
    
    enterImgBackView.frame = CGRectMake(32.5 - 3, 110 - 3 + HeadViewHeight, EnterImgHeight + 6, EnterImgWidth + 6);
    self.enterImg.frame = CGRectMake(3, 3 , EnterImgHeight, EnterImgWidth);
    
    self.enterName.frame = CGRectMake(CGRectGetMaxX(enterImgBackView.frame) + 10, CGRectGetMaxY(topBackImg.frame), SCREEN_WIDTH - CGRectGetMaxX(self.enterImg.frame) - 10 - 10, 30);
    
    self.menuTableView.frame = CGRectMake(0, CGRectGetMaxY(enterImgBackView.frame) + 10, SCREEN_WIDTH, 2 *UserCenterCellHeight + MenuTitleViewHeight);
}

@end
