//
//  TTBUserCenterCell.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/21.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"

#define UserCenterCellHeight 45
#define UserCenterCellIconWidth 20

@interface TTBUserCenterCell : TTBBaseTableViewCell

@property (nonatomic , strong)UIImageView *iconImg;
@property (nonatomic , strong)UILabel *contentLab;

@end
