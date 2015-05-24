//
//  TTBReleaseJobViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/24.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBReleaseJobCell.h"

#define ReleaseJobMainSpacing 12.5

#define ReleaseJobTableViewSectionViewHeight 10

@interface TTBReleaseJobViewBase : UIView

@property (nonatomic , strong)UITableView *baseTableView;

@property (nonatomic , strong) UITextField *nameText;
@property (nonatomic , strong) UITextField *payText;
@property (nonatomic , strong) UITextField *timeText;
@property (nonatomic , strong) UITextField *numText;
@property (nonatomic , strong) UITextField *addressText;

@property (nonatomic , strong) UILabel *payTipLab;
@property (nonatomic , strong) UILabel *jobTypeTipLab;
@property (nonatomic , strong) UILabel *countTypeTipLab;
@property (nonatomic , strong) UILabel *deadlineTipLab;
@property (nonatomic , strong) UILabel *workDaysTipLab;
@property (nonatomic , strong) UILabel *areaTipLab;
@property (nonatomic , strong) UILabel *sexTipLab;
@property (nonatomic , strong) UILabel *heightTipLab;
@property (nonatomic , strong) UILabel *healthTipLab;
@property (nonatomic , strong) UILabel *interviewTipLab;

- (void)animateHistoryArrowImg;

@end
