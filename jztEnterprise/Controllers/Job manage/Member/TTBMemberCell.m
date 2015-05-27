//
//  TTBMemberCell.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/16.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberCell.h"

@implementation TTBMemberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
        
        self.userImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, (ContactCellRowHeight - ContactCellUserImgWidth) / 2 , ContactCellUserImgWidth, ContactCellUserImgWidth)];
        self.userImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.userImg];
        
        self.genderIcon = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) - 9, CGRectGetMaxY(self.userImg.frame) - 9, 14, 14)];
        [self.contentView addSubview:self.genderIcon];
        
        self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) + 15,CGRectGetMinY(self.userImg.frame) ,SCREEN_WIDTH - (CGRectGetMaxX(self.userImg.frame) + 15) - 10,CGRectGetHeight(self.userImg.frame) / 2)];
        self.userNameLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.userNameLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.userNameLab];
        
        self.schoolLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) + 15,CGRectGetMidY(self.userImg.frame) ,SCREEN_WIDTH - (CGRectGetMaxX(self.userImg.frame) + 15) - 10,CGRectGetHeight(self.userImg.frame) / 2)];
        self.schoolLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.schoolLab.textColor = APP_FONT_COLOR_THIN;
        [self.contentView addSubview:self.schoolLab];
        
    }
    return self;
}

- (void)setGenderIconWithNum:(int)num
{
    if(num == 0)
        self.genderIcon.image = nil;
    if(num == 1)
        self.genderIcon.image = [UIImage imageNamed:@"member_gender_icon_male"];
    if(num == 2)
        self.genderIcon.image = [UIImage imageNamed:@"member_gender_icon_female"];
}


@end
