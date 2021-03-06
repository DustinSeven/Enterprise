//
//  TTBSessionDetailCell.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBSessionDetailCellFrameModel.h"
#import "UIImageView+WebCache.h"

@interface TTBSessionDetailCell : UITableViewCell

@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UIImageView *userImg;
@property (nonatomic , strong) UIButton *chatContent;

@property (nonatomic , strong) TTBSessionDetailCellFrameModel *frameModel;

@end
