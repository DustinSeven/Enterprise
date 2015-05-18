//
//  TTBContactCell.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/9.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "TTBBaseTableViewCell.h"
#import "SWTableViewCell.h"

#define ContactCellRowHeight 50

@interface TTBContactCell : SWTableViewCell

@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UILabel *userNameLab;

@end
