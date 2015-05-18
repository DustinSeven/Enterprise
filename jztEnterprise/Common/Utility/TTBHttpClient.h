//
//  TTBHttpClient.h
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface TTBHttpClient : AFHTTPRequestOperationManager

+ (TTBHttpClient *)shareClient;

@end
