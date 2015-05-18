//
//  TTBSessionDetailViewBase.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#define BottomViewColor [UIColor colorWithRed:255.0f / 255.0f green:255.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f]
#define BottomViewBorderColor [UIColor colorWithRed:221.0f / 255.0f green:221.0f / 255.0f blue:221.0f / 255.0f alpha:1.0f]
#define BottomViewHeight 50


#define ChatTextBorderColor [UIColor colorWithRed:221.0f / 255.0f green:221.0f / 255.0f blue:221.0f / 255.0f alpha:1.0f]
#define ChatTextHeight 40
#define ChatTextWidth (SCREEN_WIDTH - 100)

#define SendBtnHeight 40
#define SendBtnWidth 70



@interface TTBSessionDetailViewBase : UIView

@property (nonatomic , strong) UIView *bottomBackView;
@property (nonatomic , strong) UITextField *chatTextField;
@property (nonatomic , strong) UIButton *sendBtn;

@property (nonatomic , strong) UITableView *baseTableView;

@end
