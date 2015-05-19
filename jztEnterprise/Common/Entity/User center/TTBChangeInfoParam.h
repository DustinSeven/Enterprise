//
//  TTBChangeInfoParam.h
//  jztEnterprise
//
//  Created by Lee on 15/5/19.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBChangeInfoParam : TTBBaseEntity

@property (nonatomic , strong) NSString *identity;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *company;
@property (nonatomic , strong) NSString *email;
@property (nonatomic , strong) NSString *qq;

@end
