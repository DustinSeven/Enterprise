//
//  TTBLoginParam.m
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBLoginParam.h"

@implementation TTBLoginParam

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:[TTBUtility sha1Algorithm:self.pwd]forKey:@"pwd"];
    }
    return dict;
}

@end
