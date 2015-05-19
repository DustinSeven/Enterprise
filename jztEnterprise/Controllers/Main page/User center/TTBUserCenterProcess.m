
//
//  TTBUserCenterProcess.m
//  jztEnterprise
//
//  Created by Lee on 15/5/18.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserCenterProcess.h"

@implementation TTBUserCenterProcess

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static TTBUserCenterProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[TTBUserCenterProcess alloc] init];
    });
    
    return process;
}


- (void)uploadUserImgWithParam:(NSDictionary *)param
                    ParentView:(UIView *)parentView
                  progressText:(NSString *)text
                           img:(UIImage *)img
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[TTBHttpClient shareClient] POST:UPLOAD_USER_IMG_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //        NSString *documentsDirectory=[paths objectAtIndex:0];
        //        NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:TMP_USER_IMG_NAME_WITH_TYPE];
        //
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:savedImagePath] name:@"userimage" error:nil];
        [formData appendPartWithFileData:UIImagePNGRepresentation(img)
                                    name:@"userimage"
                                fileName:TMP_USER_IMG_NAME_WITH_TYPE
                                mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(operation,responseObject);
        
        [progress hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(operation,error);
        
        [progress hide:YES];
        
    }];
}

- (void)updateInfoWithParam:(NSDictionary *)param
               parentView:(UIView *)view
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *process = [TTBUtility showProgressWithParentView:view text:@"正在注册..." background:nil];
    [[TTBHttpClient shareClient]POST:UPDATE_ENTER_INFO_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        [process hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        [process hide:YES];
    }];
}


@end
