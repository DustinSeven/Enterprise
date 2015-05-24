//
//  TTBReleaseJobProcess.h
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBReleaseJobProcess : NSObject

+ (id)shareInstance;

- (void)getAllProvinceWithParentView:(UIView *)parentView
                        progressText:(NSString *)text
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getCityWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getAreaWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)releaseJobWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
