//
//  TTBEditWorkerNumViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBEditWorkerNumCell.h"

#define EditWorkerNumMianSpacing 12.5

#define EditWorkerNumBtnHeight 40

@interface TTBEditWorkerNumViewBase : UIView

@property (nonatomic , strong) UITableView *baseTableView;
@property (nonatomic , strong) UIButton *submitBtn;

@end
