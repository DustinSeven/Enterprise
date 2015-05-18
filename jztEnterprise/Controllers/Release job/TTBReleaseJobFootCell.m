//
//  TTBReleaseJobFootCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBReleaseJobFootCell.h"

@implementation TTBReleaseJobFootCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = SeparatorColor;
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectBtn setImage:[UIImage imageNamed:@"release_job_read_icon"] forState:UIControlStateSelected];
        [self.selectBtn setImage:[UIImage imageNamed:@"release_job_not_read_icon"] forState:UIControlStateNormal];
        self.selectBtn.frame = CGRectMake((SCREEN_WIDTH - ReleaseJobFootCellSelectBtnWidth - ReleaseJobFootCellCheckLabWidth - ReleaseJobFootCellCheckBtnWidth) / 2, 10, ReleaseJobFootCellSelectBtnWidth, ReleaseJobFootCellSelectBtnWidth);
        self.selectBtn.selected = YES;
        [self.selectBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.selectBtn];
        
        self.checkLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selectBtn.frame), 10, ReleaseJobFootCellCheckLabWidth, ReleaseJobFootCellSelectBtnWidth)];
        self.checkLab.text = @"我已阅读并且同意";
        self.checkLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.checkLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.checkLab];
        
        self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkBtn.frame = CGRectMake(CGRectGetMaxX(self.checkLab.frame), 10, ReleaseJobFootCellCheckBtnWidth, ReleaseJobFootCellSelectBtnWidth);
        [self.checkBtn setTitle:@"企业服务条款" forState:UIControlStateNormal];
        [self.checkBtn setTitleColor:MainColorNormal forState:UIControlStateNormal];
        [self.checkBtn setTitleColor:MainColorHeavy forState:UIControlStateHighlighted];
        self.checkBtn.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.checkBtn];
        
        self.releseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.releseBtn.frame = CGRectMake((SCREEN_WIDTH - ReleaseJobFootCellReleaseBtnWidth) / 2, CGRectGetMaxY(self.selectBtn.frame), ReleaseJobFootCellReleaseBtnWidth, ReleaseJobFootCellReleaseBtnHeight);
        [self.releseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.releseBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ReleaseJobFootCellReleaseBtnWidth, ReleaseJobFootCellReleaseBtnHeight)] forState:UIControlStateNormal];
        [self.releseBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ReleaseJobFootCellReleaseBtnWidth, ReleaseJobFootCellReleaseBtnHeight)] forState:UIControlStateNormal];
        [self.releseBtn setTitle:@"发布" forState:UIControlStateNormal];
        self.releseBtn.layer.cornerRadius = 3;
        self.releseBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:self.releseBtn];
    }
    return self;
}

#pragma  mark - selectBtnClicked
- (void)selectBtnClicked:(UIButton *)btn
{
    if(self.selectBtn.selected)
        self.selectBtn.selected = NO;
    else
        self.selectBtn.selected = YES;
}

@end
