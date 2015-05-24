//
//  TTBReleaseJobViewIphone.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/24.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBReleaseJobViewIphone.h"

@interface TTBReleaseJobViewIphone()
{
}

@end

@implementation TTBReleaseJobViewIphone

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
    self.backgroundColor = SeparatorColor;
    
    self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    //    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    self.baseTableView.delaysContentTouches = NO;
    view.backgroundColor = [UIColor clearColor];
    [self.baseTableView setTableFooterView:view];
    [self addSubview:self.baseTableView];
    
    self.nameText = [[UITextField alloc]init];
    self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameText.textAlignment = NSTextAlignmentRight;
    self.nameText.textColor = APP_FONT_COLOR_NORMAL;
    self.nameText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.nameText.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing, ReleaseJobCellHeight);
    [self.nameText setKeyboardType:UIKeyboardTypeDefault];
    self.nameText.placeholder = @"请输入标题";
    
    self.payText = [[UITextField alloc]init];
    self.payText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.payText.textAlignment = NSTextAlignmentRight;
    self.payText.textColor = APP_FONT_COLOR_NORMAL;
    self.payText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.payText.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing -  85, ReleaseJobCellHeight);
    [self.payText setKeyboardType:UIKeyboardTypeDecimalPad];
    self.payText.placeholder = @"请输入薪资";
    
    self.timeText = [[UITextField alloc]init];
    self.timeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.timeText.textAlignment = NSTextAlignmentRight;
    self.timeText.textColor = APP_FONT_COLOR_NORMAL;
    self.timeText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.timeText.hidden = NO;
    self.timeText.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing, ReleaseJobCellHeight);
    [self.timeText setKeyboardType:UIKeyboardTypeDefault];
    self.timeText.placeholder = @"请输入工作时间";
    
    self.numText = [[UITextField alloc]init];
    self.numText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numText.textAlignment = NSTextAlignmentRight;
    self.numText.textColor = APP_FONT_COLOR_NORMAL;
    self.numText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.numText.hidden = NO;
    self.numText.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing, ReleaseJobCellHeight);
    [self.numText setKeyboardType:UIKeyboardTypeNumberPad];
    self.numText.placeholder = @"请输入整人数";
    
    self.addressText = [[UITextField alloc]init];
    self.addressText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.addressText.textAlignment = NSTextAlignmentRight;
    self.addressText.textColor = APP_FONT_COLOR_NORMAL;
    self.addressText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.addressText.hidden = NO;
    self.addressText.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing, ReleaseJobCellHeight);
    [self.addressText setKeyboardType:UIKeyboardTypeDefault];
    self.addressText.placeholder = @"请输入工作地址";
    
    self.payTipLab = [[UILabel alloc]init];
    self.payTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.payTipLab.textAlignment = NSTextAlignmentRight;
    self.payTipLab.textColor = APP_FONT_COLOR_NORMAL;
    self.payTipLab.frame = CGRectMake(SCREEN_WIDTH - ReleaseJobMainSpacing -  85 + 0.5 + 5, 0, SCREEN_WIDTH - (SCREEN_WIDTH - ReleaseJobMainSpacing -  85 + 0.5 + 5) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    self.payTipLab.text = @"元/时";
    
    self.jobTypeTipLab = [[UILabel alloc]init];
    self.jobTypeTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.jobTypeTipLab.textAlignment = NSTextAlignmentRight;
    self.jobTypeTipLab.text = @"点击选择";
    self.jobTypeTipLab.textColor = SeparatorColor;
    self.jobTypeTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
    self.countTypeTipLab = [[UILabel alloc]init];
    self.countTypeTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.countTypeTipLab.textAlignment = NSTextAlignmentRight;
    self.countTypeTipLab.hidden = NO;
    self.countTypeTipLab.text = @"点击选择";
    self.countTypeTipLab.textColor = SeparatorColor;
    self.countTypeTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
    self.deadlineTipLab = [[UILabel alloc]init];
    self.deadlineTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.deadlineTipLab.textAlignment = NSTextAlignmentRight;
    self.deadlineTipLab.text = @"点击选择日期";
    self.deadlineTipLab.textColor = SeparatorColor;
    
    self.workDaysTipLab = [[UILabel alloc]init];
    self.workDaysTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.workDaysTipLab.textAlignment = NSTextAlignmentRight;
    self.workDaysTipLab.text = @"点击选择日期";
    self.workDaysTipLab.textColor = SeparatorColor;
    
    self.areaTipLab = [[UILabel alloc]init];
    self.areaTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.areaTipLab.textAlignment = NSTextAlignmentRight;
    self.areaTipLab.hidden = NO;
    self.areaTipLab.text = @"点击选择工作区域";
    self.areaTipLab.textColor = SeparatorColor;
    self.areaTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
    self.sexTipLab = [[UILabel alloc]init];
    self.sexTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.sexTipLab.textAlignment = NSTextAlignmentRight;
    self.sexTipLab.hidden = NO;
    self.sexTipLab.text = @"无限制";
    self.sexTipLab.textColor = APP_FONT_COLOR_NORMAL;
    self.sexTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
    self.heightTipLab = [[UILabel alloc]init];
    self.heightTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.heightTipLab.textAlignment = NSTextAlignmentRight;
    self.heightTipLab.text = @"无限制";
    self.heightTipLab.textColor = APP_FONT_COLOR_NORMAL;
    self.heightTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
    self.healthTipLab = [[UILabel alloc]init];
    self.healthTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.healthTipLab.textAlignment = NSTextAlignmentRight;
    self.healthTipLab.text = @"不需要";
    self.healthTipLab.textColor = APP_FONT_COLOR_NORMAL;
    self.healthTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
    self.interviewTipLab = [[UILabel alloc]init];
    self.interviewTipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.interviewTipLab.textAlignment = NSTextAlignmentRight;
    self.interviewTipLab.text = @"不需要";
    self.interviewTipLab.textColor = APP_FONT_COLOR_NORMAL;
    self.interviewTipLab.frame = CGRectMake(ReleaseJobTitleWidth, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
    
   
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.baseTableView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - HeadViewHeight);
}

@end
