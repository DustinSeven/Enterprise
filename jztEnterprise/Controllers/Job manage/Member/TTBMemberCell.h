//
//  TTBMemberCell.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/16.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "SWTableViewCell.h"

#define ContactCellRowHeight 62.5

#define ContactCellUserImgWidth 45

@interface TTBMemberCell : SWTableViewCell

@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UILabel *userNameLab;
@property (nonatomic , strong) UILabel *schoolLab;
@property (nonatomic , strong) UIImageView *tipImg;
@property (nonatomic , strong) UIImageView *genderIcon;

- (void)revolveTipImg;
- (void)setGenderIconWithNum:(int)num;

@end