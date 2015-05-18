//
//  TTBMemberChoiseCell.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"

#define MemberChoiseCellRowHeight 62.5

#define MemberChoiseCellUserImgWidth 45

@interface TTBMemberChoiseCell : TTBBaseTableViewCell

@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UILabel *userNameLab;
@property (nonatomic , strong) UILabel *schoolLab;
@property (nonatomic , strong) UIImageView *tipImg;

- (void)setCusSelected:(BOOL)selected;

@end
