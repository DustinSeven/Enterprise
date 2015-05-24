
//
//  TTBMyJobListEntity.m
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMyJobListEntity.h"

@implementation TTBMyJobListEntity

- (id)initWithAttributes:(NSDictionary *)dict
{
    self= [super initWithAttributes:dict];
    if(self)
    {
        if(![[dict objectForKey:@"parttimeid"] isKindOfClass:[NSNull class]])
            self.identity = [dict objectForKey:@"parttimeid"];
        if(![[dict objectForKey:@"title"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"title"] isEqualToString:@""])
            self.title = [dict objectForKey:@"title"];
        if(![[dict objectForKey:@"logo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"logo"] isEqualToString:@""])
            self.logo = [dict objectForKey:@"logo"];
        if(![[dict objectForKey:@"deadline"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"deadline"] isEqualToString:@""])
            self.deadline = [dict objectForKey:@"deadline"];
        if(![[dict objectForKey:@"num"] isKindOfClass:[NSNull class]])
            self.num = [[dict objectForKey:@"num"]intValue];
        if(![[dict objectForKey:@"remaining"] isKindOfClass:[NSNull class]])
            self.remaining = [[dict objectForKey:@"remaining"]intValue];
        if(![[dict objectForKey:@"worktimetype"] isKindOfClass:[NSNull class]])
            self.workTimeType = [[dict objectForKey:@"worktimetype"]intValue];
        if(![[dict objectForKey:@"jobtype"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"jobtype"] isEqualToString:@""])
            self.jobType = [dict objectForKey:@"jobtype"];
    }
    return self;
}

@end
