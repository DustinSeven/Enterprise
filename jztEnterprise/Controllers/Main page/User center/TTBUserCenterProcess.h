//
//  TTBUserCenterProcess.h
//  jztEnterprise
//
//  Created by Lee on 15/5/18.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBUserCenterProcess : NSObject

+ (id)shareInstance;

- (void)uploadUserImgWithParam:(NSDictionary *)param
                    ParentView:(UIView *)parentView
                  progressText:(NSString *)text
                           img:(UIImage *)img
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)updateInfoWithParam:(NSDictionary *)param
                 parentView:(UIView *)view
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
