//
//  UIView+NewInfo.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/21.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(NewInfo)

- (void)addNewInfoMarkPoint;

- (void)addNewInfoMarkPointAtLoc:(CGPoint)point;

- (void)removeNewInfoMarkPoint;

- (void)addNewInfoMarkImg;

- (void)removeNewInfoMarkImg;

- (void)addLineWithFrame:(CGRect)frame;

- (void)removeLines;

@end
