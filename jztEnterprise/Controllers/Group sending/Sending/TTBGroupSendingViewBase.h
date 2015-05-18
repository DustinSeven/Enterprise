//
//  TTBGroupSendingViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GroupSendingBackViewHeight 310

#define GroupSendingImgWidth 36
#define GroupSendingHSpacing 12.5
#define GroupSendingVSpacing 20

#define GroupSendingSendBtnHeight 40

@interface TTBGroupSendingViewBase : UIView

@property (nonatomic , strong) UIImageView *userImg0;
@property (nonatomic , strong) UIImageView *userImg1;
@property (nonatomic , strong) UIImageView *userImg2;
@property (nonatomic , strong) UIImageView *userImg3;
@property (nonatomic , strong) UIImageView *userImg4;
@property (nonatomic , strong) UIImageView *userImg5;
@property (nonatomic , strong) UILabel *moreLab;
@property (nonatomic , strong) UITextView *messageContentView;
@property (nonatomic , strong) UIButton *sendBtn;

@end
