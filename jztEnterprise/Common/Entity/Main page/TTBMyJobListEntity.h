//
//  TTBMyJobListEntity.h
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBMyJobListEntity : TTBBaseEntity

@property (nonatomic , strong) NSString *identity;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *logo;
@property (nonatomic , strong) NSString *deadline;
@property (nonatomic , assign) int num;
@property (nonatomic , assign) int remaining;
@property (nonatomic , strong) NSString *jobType;
@property (nonatomic , assign) int workTimeType;

@end
