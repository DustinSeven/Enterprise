//
//  ZGProvinceEntity.h
//  jianzhitoo
//
//  Created by 李明伟 on 11/16/14.
//  Copyright (c) 2014 Lee Mingwei. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface ZGProvinceEntity : TTBBaseEntity

@property (nonatomic , assign) long int pid;
@property (nonatomic , assign) long int identity;
@property (nonatomic , strong) NSString *name;

@end
