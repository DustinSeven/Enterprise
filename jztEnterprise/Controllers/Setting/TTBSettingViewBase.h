//
//  TTBSettingViewBase.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SettingListSeparatorColor [UIColor colorWithRed:196.0f / 255.0f green:196.0f / 255.0f blue:196.0f / 255.0f alpha:1.0f]

#define SettingListCellHeight 45

#define SettingLogoutBtnWidth 295
#define SettingLogoutBtnHeight 45

@interface TTBSettingViewBase : UIView

@property (nonatomic , strong) UITableView *baseTableView;

@property (nonatomic , strong) UIButton *logoutBtn;

@end
