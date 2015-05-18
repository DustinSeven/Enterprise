
//
//  TTBUserEntity.m
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserEntity.h"

@implementation TTBUserEntity

- (id) initWithCoder: (NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(self)
    {
        self.identity = [coder decodeObjectForKey:@"identity"];
        self.mobile = [coder decodeObjectForKey:@"mobile"];
        self.pwd = [coder decodeObjectForKey:@"pwd"];
        self.account = [coder decodeObjectForKey:@"account"];
        self.sex = [coder decodeObjectForKey:@"sex"];
        self.remark = [coder decodeObjectForKey:@"remark"];
        self.img = [coder decodeObjectForKey:@"img"];
        self.company = [coder decodeObjectForKey:@"company"];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeObject:self.identity forKey:@"identity"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.pwd forKey:@"pwd"];
    [coder encodeObject:self.account forKey:@"account"];
    [coder encodeObject:self.sex forKey:@"sex"];
    [coder encodeObject:self.remark forKey:@"remark"];
    [coder encodeObject:self.img forKey:@"img"];
    [coder encodeObject:self.company forKey:@"company"];
}


@end
