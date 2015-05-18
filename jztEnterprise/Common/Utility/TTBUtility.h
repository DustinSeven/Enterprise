//
//  TTBUtility.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBNoticeView.h"
#import "MBProgressHUD.h"

#define SHA1_DIGEST_LENGTH 20

@interface TTBUtility : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+(NSArray *)customBarButtonItemWithNormalImg:(UIImage *)normalImg pressedImg:(UIImage *)pressedImg text:(NSString *)text target:(id)target action:(SEL)action spacing:(float)spacing;

+ (UIImage *)resizeImage:(NSString *)imageName;

+ (UIImage *) combineImgs:(NSArray *)imgs;

+(TTBNoticeView *)showNoticeViewWithParent:(UIView *)parentView Frame:(CGRect)frame text:(NSString *)text;

+(UIImage *)blurImgWithImg:(UIImage *)img size:(CGSize)size;

+ (NSString*) sha1Algorithm:(NSString *)srcString;

+ (MBProgressHUD *)showProgressWithParentView:(UIView *)parentView
                                         text:(NSString *)text
                                   background:(UIColor *)color;

+ (void)saveUserDefaults:(id)object key:(NSString *)key;
+ (id)readUserDefaults:(NSString *)key;
+ (BOOL)checkTel:(NSString *)str;
@end
