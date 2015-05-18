//
//  TTBCalenda.h
//  Calenda
//
//  Created by 李明伟 on 15/1/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBDateButton.h"

#define BUTTON_MARGIN 4
#define CALENDAR_MARGIN 5
#define TOP_HEIGHT 44
#define DAYS_HEADER_HEIGHT 22
#define DEFAULT_CELL_WIDTH 43
#define CELL_BORDER_WIDTH 1


#define WeekTitleLabHeight 35

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TTBCalendarView : UIView

@property (nonatomic , strong) NSMutableArray *selectedDay;

@property (nonatomic , assign)BOOL repeatable;

@end
