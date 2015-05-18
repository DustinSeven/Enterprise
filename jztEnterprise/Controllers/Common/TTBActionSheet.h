//
//  TTBActionSheet.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseActionSheetView.h"

@class TTBActionSheet;

@protocol TTBActionSheetDelegate <NSObject>

- (void)clickedOnItemOnIndex:(int)index ofActionSheet:(TTBActionSheet *)actionSheet returnValue:(float)value;

- (void)calendarReturnWithSelectedDates:(NSArray *)datesArr ofActionSheet:(TTBActionSheet *)actionSheet;

@end

#define ActionSheetCellHeight 45

#define ActionSheetBtnSpacingV 27.5
#define ActionSheetBtnSpacingB 12.5

#define ActionSheetBtnHeight 35
#define ActionSheetBtnWidth 250

#define ActionSheetBtnColorNormal [UIColor colorWithRed:152.0f / 255.0f green:152.0f / 255.0f blue:152.0f / 255.0f alpha:1.0f]
#define ActionSheetBtnColorPressed [UIColor colorWithRed:135.0f / 255.0f green:135.0f / 255.0f blue:135.0f / 255.0f alpha:1.0f]

#define ActionSheetSliderPaneHeight 107
#define ActionSheetSliderPaneBtnBgHeight 40
#define ActionSheetSliderPaneBtnWidth 60

#define ActionSheetSliderPaneCalendarHeight 400
#define ActionSheetSliderPaneCalendarFootViewHeight 45


@interface TTBActionSheet : TTBBaseActionSheetView

- (void)showCalendarWithParentView:(UIView *)parentView selectedDateArr:(NSArray *)selectedDateArr repeatable:(BOOL)repeatable;

- (void)showWithTitlesArrAsTable:(NSArray *)titlesArr parentView:(UIView *)parentView defaultSelectedIndex:(int)index;

- (void)showWithTitlesArrAsBtn:(NSArray *)titlesArr parentView:(UIView *)parentView defaultSelectedIndex:(int)index;

- (void)showAsSliderWithParentView:(UIView *)parentView defaultSelectedValue:(float)value;

@property (nonatomic , strong)id<TTBActionSheetDelegate>delegate;

@property (nonatomic , assign)int specialTag;

@end
