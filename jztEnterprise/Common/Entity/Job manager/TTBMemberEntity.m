
//
//  TTBMemberEntity.m
//  jztEnterprise
//
//  Created by Lee on 15/5/27.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberEntity.h"

@implementation TTBMemberEntity

- (id)initWithAttributes:(NSDictionary *)dict
{
    self= [super initWithAttributes:dict];
    if(self)
    {
        if(![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"name"] isEqualToString:@""])
            self.name = [dict objectForKey:@"name"];
        if(![[dict objectForKey:@"mobile"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"mobile"] isEqualToString:@""])
            self.mobile = [dict objectForKey:@"mobile"];
        if(![[dict objectForKey:@"signin"] isKindOfClass:[NSNull class]])
            self.signin = [[dict objectForKey:@"signin"] intValue];
        if(![[dict objectForKey:@"school"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"school"] isEqualToString:@""])
            self.school = [dict objectForKey:@"school"];
        if(![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"id"] longValue];
        if(![[dict objectForKey:@"date"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"date"] isEqualToString:@""])
            self.date = [dict objectForKey:@"date"];
        if(![[dict objectForKey:@"img"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"img"] isEqualToString:@""])
            self.img = [dict objectForKey:@"img"];
        if(![[dict objectForKey:@"sex"] isKindOfClass:[NSNull class]])
            self.sex = [[dict objectForKey:@"sex"] intValue];
        if(![[dict objectForKey:@"userjobid"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"userjobid"] isEqualToString:@""])
            self.userJobId = [dict objectForKey:@"userjobid"];
    }
    return self;
}

@end
