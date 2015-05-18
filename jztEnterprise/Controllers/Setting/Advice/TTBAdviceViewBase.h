//
//  TTBAdviceViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AdviceBackViewHeight 200

#define AdviceMianHSpacing 12.5
#define AdviceMianVSpacing 25

#define AdviceBtnHeight 40

@interface TTBAdviceViewBase : UIView

@property (nonatomic , strong) UITextView *contentView;
@property (nonatomic , strong) UIButton *submitBtn;

@end
