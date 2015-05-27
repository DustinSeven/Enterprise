//
//  TTBMemberController.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseController.h"
#import "TTBMemberViewIphone.h"
#import "TTBMemberCell.h"

@interface TTBMemberController : TTBBaseController

@property (nonatomic , strong) NSString *identity;
@property (nonatomic , assign) BOOL isLong;

@end
