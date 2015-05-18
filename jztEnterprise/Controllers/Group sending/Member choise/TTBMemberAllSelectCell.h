//
//  TTBMemberAllSelectCell.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"
#import "TTBMemberChoiseCell.h"

#define MemberAllSelectCellImgWidth 36
#define MemberAllSelectCellImgSpacing 5

@interface TTBMemberAllSelectCell : TTBBaseTableViewCell

@property (nonatomic , strong) UIImageView *userImg0;
@property (nonatomic , strong) UIImageView *userImg1;
@property (nonatomic , strong) UIImageView *userImg2;
@property (nonatomic , strong) UIImageView *userImg3;
@property (nonatomic , strong) UIImageView *userImg4;
@property (nonatomic , strong) UIImageView *userImg5;
@property (nonatomic , strong) UILabel *moreLab;
@property (nonatomic , strong) UIImageView *tipImg;

- (void)setCusSelected:(BOOL)selected;
@end
