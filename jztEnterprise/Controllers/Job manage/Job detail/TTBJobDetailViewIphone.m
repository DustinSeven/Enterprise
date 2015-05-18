//
//  TTBJobDetailViewIphone.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobDetailViewIphone.h"

@interface TTBJobDetailViewIphone()
{
    
    UIView *headBackView;
    UIView *midBackView1;
    UIView *midBackView2;
    UIView *footBackView;
    
    UILabel *processNoticeLab;
    
    UILabel *timeTitleLab;
    UILabel *addressTitleLab;
    UILabel *jobTypeTitleLab;
    
    UILabel *jobContentTitleLab;
}

@end

@implementation TTBJobDetailViewIphone

-(id)init
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
    
    self.baseScrollView = [[UIScrollView alloc]init];
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.delaysContentTouches = NO;
    [self addSubview:self.baseScrollView];
    
    headBackView = [[UIView alloc]init];
    headBackView.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:headBackView];
    
    self.dateLab = [[UILabel alloc]init];
    self.dateLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.dateLab.textColor = APP_FONT_COLOR_NORMAL;
    self.dateLab.textAlignment = NSTextAlignmentCenter;
    [headBackView addSubview:self.dateLab];
    
    self.signInStateLab = [[UILabel alloc]init];
    self.signInStateLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    self.signInStateLab.textColor = APP_FONT_COLOR_THIN;
    self.signInStateLab.textAlignment = NSTextAlignmentCenter;
    [headBackView addSubview:self.signInStateLab];
    
    midBackView1 = [[UIView alloc]init];
    midBackView1.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:midBackView1];
    
    self.jobImg = [[UIImageView alloc]init];
    [midBackView1 addSubview:self.jobImg];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 2];
    self.titleLab.backgroundColor = [UIColor clearColor];
    self.titleLab.textColor = APP_FONT_COLOR_NORMAL;
    self.titleLab.numberOfLines = 2;
    self.titleLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [midBackView1 addSubview:self.titleLab];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.statusLab.textColor = APP_FONT_COLOR_NORMAL;
    self.statusLab.textAlignment = NSTextAlignmentRight;
    [midBackView1 addSubview:self.statusLab];
    
    self.processIcon = [[UIImageView alloc]init];
    [midBackView1 addSubview:self.processIcon];
    
    self.processLab = [[UILabel alloc]init];
    self.processLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL + 2];
    self.processLab.textColor = APP_FONT_COLOR_THIN;
    [midBackView1 addSubview:self.processLab];
    
    processNoticeLab = [[UILabel alloc]init];
    processNoticeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    processNoticeLab.textColor = APP_FONT_COLOR_THIN;
    processNoticeLab.text = @"招募进度：";
    [midBackView1 addSubview:processNoticeLab];
    
    self.processBar = [[TTBProcessBar alloc]init];
    [midBackView1 addSubview:self.processBar];
    
    self.statusLab = [[UILabel alloc]init];
    self.statusLab.font = [UIFont systemFontOfSize:11];
    self.statusLab.textColor = APP_FONT_COLOR_THIN;
    self.statusLab.textAlignment = NSTextAlignmentRight;
    [midBackView1 addSubview:self.statusLab];
    
    midBackView2 = [[UIView alloc]init];
    midBackView2.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:midBackView2];
    
    timeTitleLab = [[UILabel alloc]init];
    timeTitleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    timeTitleLab.backgroundColor = [UIColor clearColor];
    timeTitleLab.textColor = APP_FONT_COLOR_THIN;
    timeTitleLab.text = @"时间：";
    [midBackView2 addSubview:timeTitleLab];
    
    addressTitleLab = [[UILabel alloc]init];
    addressTitleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    addressTitleLab.backgroundColor = [UIColor clearColor];
    addressTitleLab.textColor = APP_FONT_COLOR_THIN;
    addressTitleLab.text = @"地点：";
    [midBackView2 addSubview:addressTitleLab];
    
    jobTypeTitleLab = [[UILabel alloc]init];
    jobTypeTitleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    jobTypeTitleLab.backgroundColor = [UIColor clearColor];
    jobTypeTitleLab.textColor = APP_FONT_COLOR_THIN;
    jobTypeTitleLab.text = @"工种：";
    [midBackView2 addSubview:jobTypeTitleLab];
    
    self.timeLab= [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    self.timeLab.backgroundColor = [UIColor clearColor];
    self.timeLab.textColor = APP_FONT_COLOR_THIN;
    self.timeLab.numberOfLines = 0;
    self.timeLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [midBackView2 addSubview:self.timeLab];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    self.addressLab.backgroundColor = [UIColor clearColor];
    self.addressLab.textColor = APP_FONT_COLOR_THIN;
    self.addressLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    self.addressLab.numberOfLines = 0;
    [midBackView2 addSubview:self.addressLab];
    
    self.jobTypeLab = [[UILabel alloc]init];
    self.jobTypeLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    self.jobTypeLab.backgroundColor = [UIColor clearColor];
    self.jobTypeLab.textColor = APP_FONT_COLOR_THIN;
    self.jobTypeLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    self.jobTypeLab.numberOfLines = 0;
    [midBackView2 addSubview:self.jobTypeLab];
    
    footBackView = [[UIView alloc]init];
    footBackView.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:footBackView];
    
    jobContentTitleLab = [[UILabel alloc]init];
    jobContentTitleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    jobContentTitleLab.backgroundColor = [UIColor clearColor];
    jobContentTitleLab.textColor = APP_FONT_COLOR_NORMAL;
    jobContentTitleLab.text = @"工作内容";
    [footBackView addSubview:jobContentTitleLab];
    
    self.jobContentText = [[UITextView alloc]init];
    self.jobContentText.backgroundColor = [UIColor clearColor];
    self.jobContentText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL - 2];
    self.jobContentText.textColor = APP_FONT_COLOR_NORMAL;
    self.jobContentText.editable = YES;
    self.jobContentText.bounces = NO;
    [footBackView addSubview:self.jobContentText];
    
    self.editContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editContentBtn setImage:[UIImage imageNamed:@"job_detail_edit_btn_icon_normal"] forState:UIControlStateNormal];
    [self.editContentBtn addTarget:self action:@selector(editContentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footBackView addSubview:self.editContentBtn];
    
    self.editWorkerNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editWorkerNumBtn setImage:[UIImage imageNamed:@"job_detail_edit_btn_icon_normal"] forState:UIControlStateNormal];
    [midBackView1 addSubview:self.editWorkerNumBtn];
    
    self.editContentCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editContentCancelBtn setBackgroundImage:[TTBUtility imageWithColor:[UIColor whiteColor] size:CGSizeMake(JobDetailEnterBtnWidth, JobDetailEnterBtnHeight)] forState:UIControlStateNormal];
    [self.editContentCancelBtn setBackgroundImage:[TTBUtility imageWithColor:SeparatorColor size:CGSizeMake(JobDetailEnterBtnWidth, JobDetailEnterBtnHeight)] forState:UIControlStateHighlighted];
    [self.editContentCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.editContentCancelBtn setTitleColor:APP_FONT_COLOR_NORMAL forState:UIControlStateNormal];
    self.editContentCancelBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.editContentCancelBtn.layer.masksToBounds = YES;
    self.editContentCancelBtn.layer.cornerRadius = 3;
    self.editContentCancelBtn.layer.borderColor = SeparatorColor.CGColor;
    self.editContentCancelBtn.layer.borderWidth = 0.5;
    self.editContentCancelBtn.hidden = YES;
    [self.baseScrollView addSubview:self.editContentCancelBtn];
    
    self.editContentEnterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editContentEnterBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(JobDetailEnterBtnWidth, JobDetailEnterBtnHeight)] forState:UIControlStateNormal];
    [self.editContentEnterBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(JobDetailEnterBtnWidth, JobDetailEnterBtnHeight)] forState:UIControlStateHighlighted];
    [self.editContentEnterBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.editContentEnterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.editContentEnterBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.editContentEnterBtn.layer.masksToBounds = YES;
    self.editContentEnterBtn.layer.cornerRadius = 3;
    self.editContentEnterBtn.layer.borderColor = SeparatorColor.CGColor;
    self.editContentEnterBtn.layer.borderWidth = 0.5;
    self.editContentEnterBtn.hidden = YES;
    [self.baseScrollView addSubview:self.editContentEnterBtn];
    
    self.signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signInBtn setBackgroundImage:[TTBUtility imageWithColor:JobDetailSignInBtnColorNormal size:CGSizeMake(JobDetailSignInBtnWidth, JobDetailSignInBtnHeight)] forState:UIControlStateNormal];
    [self.signInBtn setBackgroundImage:[TTBUtility imageWithColor:JobDetailSignInBtnColorPressed size:CGSizeMake(JobDetailSignInBtnWidth, JobDetailSignInBtnHeight)] forState:UIControlStateHighlighted];
    [self.signInBtn setTitle:@"签到" forState:UIControlStateNormal];
    [self.signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signInBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.signInBtn.layer.masksToBounds = YES;
    self.signInBtn.layer.cornerRadius = 3;
//    self.signInBtn.hidden = YES;
    [self.baseScrollView addSubview:self.signInBtn];
    
    self.stopRecruitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.stopRecruitBtn setBackgroundImage:[TTBUtility imageWithColor:JobDetailSignInBtnColorNormal size:CGSizeMake(JobDetailSignInBtnWidth, JobDetailSignInBtnHeight)] forState:UIControlStateNormal];
    [self.stopRecruitBtn setBackgroundImage:[TTBUtility imageWithColor:JobDetailSignInBtnColorPressed size:CGSizeMake(JobDetailSignInBtnWidth, JobDetailSignInBtnHeight)] forState:UIControlStateHighlighted];
    [self.stopRecruitBtn setTitle:@"停止招募" forState:UIControlStateNormal];
    [self.stopRecruitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.stopRecruitBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    self.stopRecruitBtn.layer.masksToBounds = YES;
    self.stopRecruitBtn.layer.cornerRadius = 3;
    self.stopRecruitBtn.hidden = YES;
    [self.baseScrollView addSubview:self.stopRecruitBtn];
}

#pragma mark - editContentBtnClicked
- (void)editContentBtnClicked:(UIButton *)button
{
    self.jobContentText.editable = YES;
    [self.jobContentText becomeFirstResponder];
    
    self.editContentEnterBtn.hidden = NO;
    self.editContentCancelBtn.hidden = NO;
}

- (void)layoutSubviews
{
    [midBackView2 removeLines];
    [footBackView removeLines];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JobManageSegHeight);
    self.baseScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - JobManageSegHeight);
    
    headBackView.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, JobDetailHeadBackViewHeight);
    [headBackView addLineWithFrame:CGRectMake(0, JobDetailHeadBackViewHeight - 0.5, SCREEN_WIDTH, 0.5)];
    [headBackView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    
    self.dateLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    self.signInStateLab.frame = CGRectMake(0, CGRectGetMaxY(self.dateLab.frame), SCREEN_WIDTH, JobDetailHeadBackViewHeight - CGRectGetMaxY(self.dateLab.frame));
    
    if(headBackView.hidden)
        midBackView1.frame = CGRectMake(0, HeadViewHeight, SCREEN_WIDTH, JobDetailMidView1Height);
    else
        midBackView1.frame = CGRectMake(0, CGRectGetMaxY(headBackView.frame) + JobDetailMainSpacing, SCREEN_WIDTH, JobDetailMidView1Height);
    [midBackView1 addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [midBackView1 addLineWithFrame:CGRectMake(0, JobDetailMidView1Height - 0.5, SCREEN_WIDTH, 0.5)];
    
    self.jobImg.frame = CGRectMake(JobDetailMainSpacing, JobDetailMainSpacing, 101, 101);
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 15, CGRectGetMinY(self.jobImg.frame), SCREEN_WIDTH - (CGRectGetMaxX(self.jobImg.frame) + 15) - JobDetailMainSpacing, 40);
    
    self.processIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 15, 65, 15.5, 13.5);
    self.processLab.frame = CGRectMake(CGRectGetMaxX(self.processIcon.frame) + 5, CGRectGetMinY(self.processIcon.frame) + (CGRectGetHeight(self.processIcon.frame) - 20) / 2, 150, 20);
    
    processNoticeLab.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 15, 92.5, 100, 10);
    
    self.processBar.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 15, CGRectGetMaxY(self.jobImg.frame) - 4, SCREEN_WIDTH - (CGRectGetMaxX(self.jobImg.frame) + 15) - 45, 4);
    
    self.statusLab.frame = CGRectMake(SCREEN_WIDTH - 65 ,CGRectGetMinY(self.processBar.frame) + (CGRectGetHeight(self.processBar.frame) - 10) / 2, 55, 10);
    
    self.editWorkerNumBtn.frame = CGRectMake(SCREEN_WIDTH - JobDetailMainSpacing - 30, CGRectGetMinY(self.processLab.frame) + (CGRectGetHeight(self.processLab.frame) - 40) / 2, 40, 40);
    
    CGSize timeLabSize = [self.timeLab sizeThatFits:CGSizeMake(SCREEN_WIDTH - (CGRectGetMaxX(timeTitleLab.frame) + 5) - JobDetailMainSpacing, CGFLOAT_MIN)];
    self.timeLab.frame = CGRectMake(15 + JobDetailTitleLabWidth + 5, 10, timeLabSize.width, timeLabSize.height);
    
    CGSize adressLabSize = [self.addressLab sizeThatFits:CGSizeMake(SCREEN_WIDTH - (CGRectGetMaxX(addressTitleLab.frame) + 5) - JobDetailMainSpacing, CGFLOAT_MIN)];
    self.addressLab.frame = CGRectMake(CGRectGetMinX(self.timeLab.frame), CGRectGetMaxY(self.timeLab.frame) + 5, adressLabSize.width, adressLabSize.height);
    
    CGSize jobTypeLabSize = [self.jobTypeLab sizeThatFits:CGSizeMake(SCREEN_WIDTH - (CGRectGetMaxX(jobTypeTitleLab.frame) + 5) - JobDetailMainSpacing, CGFLOAT_MIN)];
    self.jobTypeLab.frame = CGRectMake(CGRectGetMinX(self.addressLab.frame), CGRectGetMaxY(self.addressLab.frame) + 5, jobTypeLabSize.width, jobTypeLabSize.height);
    
    timeTitleLab.frame = CGRectMake(JobDetailMainSpacing, 10, JobDetailTitleLabWidth, 15);
    addressTitleLab.frame = CGRectMake(CGRectGetMinX(timeTitleLab.frame), CGRectGetMaxY(self.timeLab.frame) + 5, CGRectGetWidth(timeTitleLab.frame), CGRectGetHeight(timeTitleLab.frame));
    jobTypeTitleLab.frame = CGRectMake(CGRectGetMinX(addressTitleLab.frame), CGRectGetMaxY(self.addressLab.frame) + 5, CGRectGetWidth(addressTitleLab.frame), CGRectGetHeight(addressTitleLab.frame));
    
    midBackView2.frame = CGRectMake(0, CGRectGetMaxY(midBackView1.frame), SCREEN_WIDTH, timeLabSize.height + adressLabSize.height + jobTypeLabSize.height + 30);
    [midBackView2 addLineWithFrame:CGRectMake(0, CGRectGetHeight(midBackView2.frame) - 0.5, SCREEN_WIDTH, 0.5)];
    
    jobContentTitleLab.frame = CGRectMake(JobDetailMainSpacing, 15, 100, 20);
    
    CGSize jobContentFieldSize = [self.jobContentText sizeThatFits:CGSizeMake(SCREEN_WIDTH - (JobDetailMainSpacing + 5) * 2, CGFLOAT_MIN)];
    self.jobContentText.frame = CGRectMake(JobDetailMainSpacing + 5, CGRectGetMaxY(jobContentTitleLab.frame) + 5, SCREEN_WIDTH - (JobDetailMainSpacing + 5) * 2, jobContentFieldSize.height);
    
    self.editContentBtn.frame = CGRectMake(SCREEN_WIDTH - JobDetailMainSpacing - 30, CGRectGetMinY(jobContentTitleLab.frame) + (CGRectGetHeight(jobContentTitleLab.frame) - 40) / 2, 40, 40);
    
    footBackView.frame = CGRectMake(0, CGRectGetMaxY(midBackView2.frame) + JobDetailMainSpacing, SCREEN_WIDTH, CGRectGetMaxY(self.jobContentText.frame) + 15);
    [footBackView addLineWithFrame:CGRectMake(0,CGRectGetHeight(footBackView.frame) - 0.5, SCREEN_WIDTH, 0.5)];
    [footBackView addLineWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
    
    self.editContentCancelBtn.frame = CGRectMake((SCREEN_WIDTH - JobDetailEnterBtnWidth * 2 - 10) / 2, CGRectGetMaxY(footBackView.frame) + JobDetailMainSpacing, JobDetailEnterBtnWidth, JobDetailEnterBtnHeight);
    self.editContentEnterBtn.frame = CGRectMake((SCREEN_WIDTH - JobDetailEnterBtnWidth * 2 - 10) / 2 + JobDetailEnterBtnWidth + JobDetailMainSpacing, CGRectGetMaxY(footBackView.frame) + JobDetailMainSpacing, JobDetailEnterBtnWidth, JobDetailEnterBtnHeight);
    
    self.signInBtn.frame = CGRectMake((SCREEN_WIDTH - JobDetailSignInBtnWidth) / 2 , CGRectGetMaxY(footBackView.frame) + JobDetailMainSpacing, JobDetailSignInBtnWidth, JobDetailSignInBtnHeight);
    self.stopRecruitBtn.frame = CGRectMake((SCREEN_WIDTH - JobDetailSignInBtnWidth) / 2 , CGRectGetMaxY(footBackView.frame) + JobDetailMainSpacing, JobDetailSignInBtnWidth, JobDetailSignInBtnHeight);
    
    self.baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(footBackView.frame) + JobDetailMainSpacing + JobDetailMainSpacing +  JobDetailEnterBtnHeight);
    
}

@end
