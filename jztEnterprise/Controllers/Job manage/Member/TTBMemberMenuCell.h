//
//  TTBMemberMenuCell.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/28.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MemberMenuCellColor [UIColor colorWithRed:68.0f / 255.0f green:68.0f / 255.0f blue:68.0f / 255.0f alpha:1.0f]
#define MemberMenuCellHeight 50

@interface TTBMemberMenuCell : UITableViewCell

@property (nonatomic , strong) UIButton *signInBtn;
@property (nonatomic , strong) UIButton *sessionBtn;
@property (nonatomic , strong) UIButton *phoneBtn;

@end
