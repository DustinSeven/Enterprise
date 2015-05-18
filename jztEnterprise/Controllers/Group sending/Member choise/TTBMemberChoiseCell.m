//
//  TTBMemberChoiseCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberChoiseCell.h"

@implementation TTBMemberChoiseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.userImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, (MemberChoiseCellRowHeight - MemberChoiseCellUserImgWidth) / 2 , MemberChoiseCellUserImgWidth, MemberChoiseCellUserImgWidth)];
        self.userImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg];
        
        self.tipImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 17.5 - 16, (MemberChoiseCellRowHeight - 16) / 2, 16, 16)];
        [self setCusSelected:NO];
        [self.contentView addSubview:self.tipImg];
        
        self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) + 15,CGRectGetMinY(self.userImg.frame) ,CGRectGetMinX(self.tipImg.frame) - (CGRectGetMaxX(self.userImg.frame) + 15) - 15,CGRectGetHeight(self.userImg.frame) / 2)];
        self.userNameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.userNameLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.userNameLab];
        
        self.schoolLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) + 15,CGRectGetMidY(self.userImg.frame) ,CGRectGetMinX(self.tipImg.frame) - (CGRectGetMaxX(self.userImg.frame) + 15) - 15,CGRectGetHeight(self.userImg.frame) / 2)];
        self.schoolLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.schoolLab.textColor = APP_FONT_COLOR_THIN;
        [self.contentView addSubview:self.schoolLab];
    }
    return self;
}

- (void)setCusSelected:(BOOL)selected
{
    if(selected)
         self.tipImg.image = [UIImage imageNamed:@"member_choise_tip_icon_selected"];
    else
         self.tipImg.image = [UIImage imageNamed:@"member_choise_tip_icon_not_selected"];
}

@end
