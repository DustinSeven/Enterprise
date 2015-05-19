//
//  TTBUserCenterViewBase.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyTopBackImgHeight 150

#define EnterImgHeight 65
#define EnterImgWidth 65

#define UserCenterBtnHeight 50
#define UserCenterBtnWidth 100

#define MenuTitleViewHeight 13.5

#define UserCenterCellHeight 45
#define UserCenterCellIconWidth 20

@interface TTBUserCenterViewBase : UIView

@property (nonatomic , strong) UIImageView *enterImg;
@property (nonatomic , strong) UITableView *menuTableView;

@end
