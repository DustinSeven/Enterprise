//
//  TTBMemberAllSelectCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberAllSelectCell.h"

@implementation TTBMemberAllSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.userImg0 = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, (MemberChoiseCellRowHeight - MemberAllSelectCellImgWidth) / 2 , MemberAllSelectCellImgWidth, MemberAllSelectCellImgWidth)];
        self.userImg0.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg0];
        
        self.userImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg0.frame) + 5, (MemberChoiseCellRowHeight - MemberAllSelectCellImgWidth) / 2 , MemberAllSelectCellImgWidth, MemberAllSelectCellImgWidth)];
        self.userImg1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg1];
        
        self.userImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg1.frame) + 5, (MemberChoiseCellRowHeight - MemberAllSelectCellImgWidth) / 2 , MemberAllSelectCellImgWidth, MemberAllSelectCellImgWidth)];
        self.userImg2.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg2];
        
        self.userImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg2.frame) + 5, (MemberChoiseCellRowHeight - MemberAllSelectCellImgWidth) / 2 , MemberAllSelectCellImgWidth, MemberAllSelectCellImgWidth)];
        self.userImg3.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg3];
        
        self.userImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg3.frame) + 5, (MemberChoiseCellRowHeight - MemberAllSelectCellImgWidth) / 2 , MemberAllSelectCellImgWidth, MemberAllSelectCellImgWidth)];
        self.userImg4.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg4];
        
        self.userImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg4.frame) + 5, (MemberChoiseCellRowHeight - MemberAllSelectCellImgWidth) / 2 , MemberAllSelectCellImgWidth, MemberAllSelectCellImgWidth)];
        self.userImg5.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg5];
        
        self.tipImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 17.5 - 16, (MemberChoiseCellRowHeight - 16) / 2, 16, 16)];
        [self setCusSelected:NO];
        [self.contentView addSubview:self.tipImg];
        
        self.moreLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg5.frame) + 5, 0, CGRectGetMinX(self.tipImg.frame) - CGRectGetMaxX(self.userImg5.frame), MemberChoiseCellRowHeight)];
        self.moreLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.moreLab.textColor = APP_FONT_COLOR_NORMAL;
        self.moreLab.text = @"···";
        [self.contentView addSubview:self.moreLab];
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
