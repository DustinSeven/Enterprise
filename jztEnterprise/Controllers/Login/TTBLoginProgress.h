//
//  TTBLoginProgress.h
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBLoginProgress : NSObject

+ (id)shareInstance;

- (void)loginWithParam:(NSDictionary *)param
            parentView:(UIView *)view
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
        getInfoSuccess:(void (^)(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject))getInfoSuccess
        getInfoFailure:(void (^)(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError))getInfoFailure;

- (void)registerWithParam:(NSDictionary *)param
               parentView:(UIView *)view
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)changePwdWithParam:(NSDictionary *)param
               parentView:(UIView *)view
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
