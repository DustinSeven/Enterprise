//
//  TTBMyShortJobDateEntity.h
//  jztEnterprise
//
//  Created by Lee on 15/5/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBMyShortJobDateEntity : TTBBaseEntity

@property (nonatomic , strong) NSString *identity;
@property (nonatomic , strong) NSString *workDate;
@property (nonatomic , assign) int num;
@property (nonatomic , assign) int remaining;

@end
