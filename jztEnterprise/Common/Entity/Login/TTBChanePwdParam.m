//
//  TTBChanePwdParam.m
//  jztEnterprise
//
//  Created by Lee on 15/5/6.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChanePwdParam.h"

@implementation TTBChanePwdParam

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        if(_mobile)
            [dict setObject:self.mobile forKey:@"mobile"];
        if(_oldPwd)
            [dict setObject:[TTBUtility sha1Algorithm:self.oldPwd]forKey:@"pwd"];
        if(_nPwd)
            [dict setObject:[TTBUtility sha1Algorithm:_nPwd]forKey:@"newpwd"];
        if(_identity)
            [dict setValue:_identity forKey:@"userid"];
    }
    return dict;
}

@end
