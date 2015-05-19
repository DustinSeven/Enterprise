//
//  TTBUploadUserImgParam.m
//  jztEnterprise
//
//  Created by Lee on 15/5/18.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUploadUserImgParam.h"

@implementation TTBUploadUserImgParam

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:[TTBUtility sha1Algorithm:self.password]forKey:@"pwd"];
    }
    return dict;
}

@end
