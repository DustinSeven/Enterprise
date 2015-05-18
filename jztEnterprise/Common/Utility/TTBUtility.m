//
//  TTBUtility.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUtility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TTBUtility

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSArray *)customBarButtonItemWithNormalImg:(UIImage *)normalImg pressedImg:(UIImage *)pressedImg text:(NSString *)text target:(id)target action:(SEL)action spacing:(float)spacing
{
    UIBarButtonItem *btn;
    
    UIButton *btnCus = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCus.frame = CGRectMake(0, 0, NavLeftBtnWidth, NavLeftBtnHeight);
    
    [btnCus setImage:normalImg forState:UIControlStateNormal];
    [btnCus setImage:pressedImg forState:UIControlStateHighlighted];
    [btnCus setTitle:text forState:UIControlStateNormal];
    [btnCus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCus setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    [btnCus addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btnCus.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    btn = [[UIBarButtonItem alloc]initWithCustomView:btnCus];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = spacing;
    return @[negativeSpacer, btn];
}

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

+ (UIImage *) combineImgs:(NSArray *)imgs
{
    if(imgs && (imgs.count == 3 || imgs.count == 4))
    {
        UIImage *img1 = [imgs objectAtIndex:0];
        CGFloat width = img1.size.width * 2;
        CGFloat height = img1.size.height;
        CGSize offScreenSize = CGSizeMake(width, height);
        
        UIGraphicsBeginImageContext(offScreenSize);
        
        CGRect rect = CGRectMake(0, height / 2, width / 2, height / 2);
        [img1 drawInRect:rect];
        
        UIImage *img2 = [imgs objectAtIndex:1];
        rect.origin.x += width/2;
        [img2 drawInRect:rect];
        
        if(imgs.count == 3)
        {
            UIImage *img3 = [imgs objectAtIndex:2];
            rect = CGRectMake(width / 4, 0, width / 2, height / 2);
            [img3 drawInRect:rect];
        }
        if(imgs.count == 4)
        {
            UIImage *img3 = [imgs objectAtIndex:2];
            rect = CGRectMake(0, 0, width / 2, height / 2);
            [img3 drawInRect:rect];
            
            UIImage *img4 = [imgs objectAtIndex:3];
            rect = CGRectMake(width / 2,0, width / 2, height / 2);
            [img4 drawInRect:rect];
        }
        
        UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return imagez;

    }
    else
        return nil;
}

+(TTBNoticeView *)showNoticeViewWithParent:(UIView *)parentView Frame:(CGRect)frame text:(NSString *)text
{
    TTBNoticeView *noticeView = [[TTBNoticeView alloc]initWithFrame:frame];
    noticeView.noticeMessage = text;
    noticeView.parentView = parentView;
    noticeView.hidden = NO;
    
    return noticeView;
}

+(UIImage *)blurImgWithImg:(UIImage *)img size:(CGSize)size
{
    CGSize offScreenSize = size;
    UIGraphicsBeginImageContext(offScreenSize);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:img];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imagez;
}

+ (NSString*) sha1Algorithm:(NSString *)srcString
{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

+ (MBProgressHUD *)showProgressWithParentView:(UIView *)parentView
                                         text:(NSString *)text
                                   background:(UIColor *)color
{
    MBProgressHUD *progress = nil;
    
    if (!parentView) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];
        progress = [[MBProgressHUD alloc] initWithWindow:window];
        parentView = window;
    } else {
        progress = [[MBProgressHUD alloc] initWithView:parentView];
    }
    
    if (!text || text.length == 0) {
        text = @"Loading...";
    }
    
    progress.removeFromSuperViewOnHide = YES;
    progress.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.4];
    progress.labelText = text;
    //    progress.animationType = MBProgressHUDAnimationZoomIn;
    progress.mode = MBProgressHUDModeIndeterminate;
    if(color)
        progress.color = color;
    [parentView addSubview:progress];
    [progress show:YES];
    
    return progress;
}

+ (void)saveUserDefaults:(id)object key:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    //transform data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [userDefault setObject:data
                    forKey:key];
    [userDefault synchronize];
}

+ (id)readUserDefaults:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id obj = [userDefault objectForKey:key];
    //transform object
    if (obj) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    } else {
        return nil;
    }
}

+ (BOOL)checkTel:(NSString *)str

{
    NSString *regex = @"^0?(13[0-9]|15[0123456789]|18[0123456789]|17[0123456789]|14[57])[0-9]{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
        return NO;
    return YES;
}

@end
