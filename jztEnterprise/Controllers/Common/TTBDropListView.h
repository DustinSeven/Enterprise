//
//  TTBHistoryDropListView.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/27.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseActionSheetView.h"
#import "TTBReleaseJobViewBase.h"

#define DropListRowHeight 45

@class TTBDropListView;

@protocol TTBDropListDelegate <NSObject>

- (void)clickedOnItemOnIndex:(int)index ofDropList:(TTBDropListView *)dropList;

@end

@interface TTBDropListView : UIView

@property (nonatomic , strong) id<TTBDropListDelegate>delegate;

- (void)showWithTitlesArrAsHistoryList:(NSArray *)titlesArr parentView:(UIView *)parentView;

- (void)tapMainScreen:(UITapGestureRecognizer *)tap;

@end
