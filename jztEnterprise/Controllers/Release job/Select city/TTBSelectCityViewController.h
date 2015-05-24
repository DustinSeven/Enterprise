//
//  TTBSelectCityViewController.h
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseController.h"
#import "ZGAreaEntity.h"

#define ChangeInfoCellHeight 40

@protocol TTBSelectCityViewControllerDelegate <NSObject>

@optional
- (void)didSelectArea:(ZGAreaEntity *)entity;

@end

@interface TTBSelectCityViewController : TTBBaseController

@property (nonatomic , strong) id<TTBSelectCityViewControllerDelegate> delegate;

@end
