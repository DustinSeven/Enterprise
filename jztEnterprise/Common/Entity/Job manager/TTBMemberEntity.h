//
//  TTBMemberEntity.h
//  jztEnterprise
//
//  Created by Lee on 15/5/27.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBMemberEntity : TTBBaseEntity

@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , assign) int signin;
@property (nonatomic , strong) NSString *school;
@property (nonatomic , assign) long int identity;
@property (nonatomic , strong) NSString *date;
@property (nonatomic , strong) NSString *img;
@property (nonatomic , assign) int sex;
@property (nonatomic , strong) NSString *userJobId;

@end
