//
//  TTBAdviceViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBAdviceViewIphone.h"

@interface TTBAdviceViewIphone()
{
    UIView *backView;
}

@end

@implementation TTBAdviceViewIphone

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
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addLineWithFrame:CGRectMake(0, AdviceBackViewHeight - 0.5, SCREEN_WIDTH , 0.5)];
    [self addSubview:backView];
    
    self.contentView = [[UITextView alloc]init];
    self.contentView.layer.cornerRadius = 3;
    self.contentView.layer.borderColor = SeparatorColor.CGColor;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.contentView.textColor = SeparatorColor;
    self.contentView.text = @"亲，有什么想说的呢？";
    self.contentView.returnKeyType = UIReturnKeySend;
    [backView addSubview:self.contentView];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.layer.cornerRadius = 3;
    self.submitBtn.layer.masksToBounds = YES;
    [self.submitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH - 2 * 12.5, AdviceBtnHeight)] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(SCREEN_WIDTH - 2 * 12.5, AdviceBtnHeight)] forState:UIControlStateHighlighted];
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.titleLabel.textColor = [UIColor whiteColor];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    [self addSubview:self.submitBtn];
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    backView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, AdviceBackViewHeight);
    
    self.contentView.frame = CGRectMake(AdviceMianHSpacing, AdviceMianVSpacing, SCREEN_WIDTH - 2 * AdviceMianHSpacing, AdviceBackViewHeight - 2 * AdviceMianVSpacing);
    
    self.submitBtn.frame = CGRectMake(AdviceMianHSpacing, CGRectGetMaxY(backView.frame) + AdviceMianVSpacing, SCREEN_WIDTH - 2 * AdviceMianHSpacing, AdviceBtnHeight);
}
@end
