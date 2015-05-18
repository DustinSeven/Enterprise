//
//  TTBGroupSendingViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBGroupSendingViewIphone.h"

@interface TTBGroupSendingViewIphone()
{
    UIView *backView;
    UILabel *toLab;
}

@end

@implementation TTBGroupSendingViewIphone

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

-(void)initWitgets
{
    self.backgroundColor = VIEW_BACKGROUND;
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addLineWithFrame:CGRectMake(0, GroupSendingBackViewHeight - 0.5, SCREEN_WIDTH, 0.5)];
    [self addSubview:backView];
    
    toLab = [[UILabel alloc]init];
    toLab.text = @"to:";
    toLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    toLab.textColor = APP_FONT_COLOR_NORMAL;
    [backView addSubview:toLab];
    
    self.userImg0 = [[UIImageView alloc]init];
    self.userImg0.backgroundColor = [UIColor clearColor];
    [backView addSubview:self.userImg0];
    
    self.userImg1 = [[UIImageView alloc]init];
    self.userImg1.backgroundColor = [UIColor clearColor];
    [backView addSubview:self.userImg1];
    
    self.userImg2 = [[UIImageView alloc]init];
    self.userImg2.backgroundColor = [UIColor clearColor];
    [backView addSubview:self.userImg2];
    
    self.userImg3 = [[UIImageView alloc]init];
    self.userImg3.backgroundColor = [UIColor clearColor];
    [backView addSubview:self.userImg3];
    
    self.userImg4 = [[UIImageView alloc]init];
    self.userImg4.backgroundColor = [UIColor clearColor];
    [backView addSubview:self.userImg4];
    
    self.userImg5 = [[UIImageView alloc]init];
    self.userImg5.backgroundColor = [UIColor clearColor];
    [backView addSubview:self.userImg5];
    
    self.moreLab = [[UILabel alloc]init];
    self.moreLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.moreLab.textColor = APP_FONT_COLOR_NORMAL;
    self.moreLab.text = @"···";
    [backView addSubview:self.moreLab];
    
    self.messageContentView = [[UITextView alloc]init];
    self.messageContentView.layer.borderColor = SeparatorColor.CGColor;
    self.messageContentView.layer.borderWidth = 0.5;
    self.messageContentView.layer.cornerRadius = 3;
    self.messageContentView.layer.masksToBounds = YES;
    self.messageContentView.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.messageContentView.textColor = SeparatorColor;
    self.messageContentView.text = @"请输入消息内容";
    self.messageContentView.returnKeyType = UIReturnKeySend;
    [backView addSubview:self.messageContentView];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.layer.cornerRadius = 3;
    self.sendBtn.layer.masksToBounds = YES;
    [self.sendBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH - 2 * GroupSendingHSpacing, GroupSendingSendBtnHeight)] forState:UIControlStateNormal];
    [self.sendBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(SCREEN_WIDTH - 2 * GroupSendingHSpacing, GroupSendingSendBtnHeight)] forState:UIControlStateHighlighted];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.titleLabel.textColor = [UIColor whiteColor];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self addSubview:self.sendBtn];
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    backView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, GroupSendingBackViewHeight);
    
    toLab.frame = CGRectMake(GroupSendingHSpacing, 0, 25, 2 * GroupSendingVSpacing + GroupSendingImgWidth);
    
    self.userImg0.frame = CGRectMake(CGRectGetMaxX(toLab.frame) + 5, GroupSendingVSpacing, GroupSendingImgWidth, GroupSendingImgWidth);
    self.userImg1.frame = CGRectMake(CGRectGetMaxX(self.userImg0.frame) + 5, GroupSendingVSpacing, GroupSendingImgWidth, GroupSendingImgWidth);
    self.userImg2.frame = CGRectMake(CGRectGetMaxX(self.userImg1.frame) + 5, GroupSendingVSpacing, GroupSendingImgWidth, GroupSendingImgWidth);
    self.userImg3.frame = CGRectMake(CGRectGetMaxX(self.userImg2.frame) + 5, GroupSendingVSpacing, GroupSendingImgWidth, GroupSendingImgWidth);
    self.userImg4.frame = CGRectMake(CGRectGetMaxX(self.userImg3.frame) + 5, GroupSendingVSpacing, GroupSendingImgWidth, GroupSendingImgWidth);
    self.userImg5.frame = CGRectMake(CGRectGetMaxX(self.userImg4.frame) + 5, GroupSendingVSpacing, GroupSendingImgWidth, GroupSendingImgWidth);
    
    self.moreLab.frame = CGRectMake(CGRectGetMaxX(self.userImg5.frame) + 5, 0, 25, 2 * GroupSendingVSpacing + GroupSendingImgWidth);
    
    self.messageContentView.frame = CGRectMake(GroupSendingHSpacing, CGRectGetMaxY(self.userImg0.frame) + GroupSendingVSpacing, SCREEN_WIDTH - 2 * GroupSendingHSpacing, GroupSendingBackViewHeight - GroupSendingVSpacing - (CGRectGetMaxY(self.userImg0.frame) + GroupSendingVSpacing));
    
    self.sendBtn.frame = CGRectMake(GroupSendingHSpacing, CGRectGetMaxY(backView.frame) + GroupSendingVSpacing, SCREEN_WIDTH - 2 * GroupSendingHSpacing, GroupSendingSendBtnHeight);
}

@end
