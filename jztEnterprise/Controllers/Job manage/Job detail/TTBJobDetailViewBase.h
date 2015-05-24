//
//  TTBJobDetailViewBase.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBJobManageViewBase.h"
#import "TTBJobDetailEntity.h"
#import "TTBProcessBar.h"

#define JobDetailHeadBackViewHeight 50
#define JobDetailMidView1Height 125

#define JobDetailTitleLabWidth 40

#define JobDetailMainSpacing 12.5

#define JobDetailEnterBtnWidth 140
#define JobDetailEnterBtnHeight 40

#define JobDetailSignInBtnWidth 295
#define JobDetailSignInBtnHeight 40

#define JobDetailSignInBtnColorNormal [UIColor colorWithRed:252.0f / 255.0f green:66.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f]
#define JobDetailSignInBtnColorPressed [UIColor colorWithRed:218.0f / 255.0f green:63.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f]

@interface TTBJobDetailViewBase : UIView

@property (nonatomic , strong)UIScrollView *baseScrollView;

@property (nonatomic , strong)UILabel *dateLab;
@property (nonatomic , strong)UILabel *signInStateLab;

@property (nonatomic , strong)UIImageView *jobImg;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UIImageView *processIcon;
@property (nonatomic , strong)UILabel *processLab;
@property (nonatomic , strong)UILabel *statusLab;
@property (nonatomic , strong)TTBProcessBar *processBar;
@property (nonatomic , strong)UILabel *timeLab;
@property (nonatomic , strong)UILabel *addressLab;
@property (nonatomic , strong)UILabel *jobTypeLab;
@property (nonatomic , strong)UITextView *jobContentText;
@property (nonatomic , strong)UIButton *editContentBtn;
@property (nonatomic , strong)UIButton *editContentEnterBtn;
@property (nonatomic , strong)UIButton *editContentCancelBtn;
@property (nonatomic , strong)UIButton *signInBtn;
@property (nonatomic , strong)UIButton *stopRecruitBtn;
@property (nonatomic , strong)UIButton *editWorkerNumBtn;

- (void)setContentHidden:(BOOL)is;

@end
