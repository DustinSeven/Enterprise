//
//  TTBCalenda.m
//  Calenda
//
//  Created by 李明伟 on 15/1/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBCalendarView.h"

@interface TTBCalendarView()
{
    NSCalendar *calendar;
    CGFloat cellWidth;
    NSDate *monthShowing;
    
    UIView *titleBackView;
    
    UILabel *titleLabel;
    UIButton *prevButton;
    UIButton *nextButton;
    UIView *calendarContainer;
    NSMutableArray *dateButtons;
  
    NSMutableArray *weekTitleArr;
    
}

@end

@implementation TTBCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        monthShowing = [NSDate date];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectedDay = [NSMutableArray array];
        weekTitleArr = [NSMutableArray array];
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setLocale:[NSLocale currentLocale]];
        [calendar setFirstWeekday:1];
        cellWidth = DEFAULT_CELL_WIDTH;
        
        calendarContainer = [[UIView alloc] initWithFrame:CGRectZero];
        calendarContainer.backgroundColor = [UIColor clearColor];
        [self addSubview:calendarContainer];
        
        titleBackView = [[UIView alloc]init];
        titleBackView.backgroundColor = MainColorNormal;
        [calendarContainer addSubview:titleBackView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        titleLabel.textColor = [UIColor whiteColor];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy年MM月 ";
        NSString *dateStr = [dateFormatter stringFromDate:monthShowing];
        titleLabel.text = dateStr;
        [titleBackView addSubview:titleLabel];
        
        prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [prevButton setImage:[UIImage imageNamed:@"calendar_pre_month_btn_icon_normal"] forState:UIControlStateNormal];
        prevButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [prevButton addTarget:self action:@selector(moveCalendarToPreviousMonth:) forControlEvents:UIControlEventTouchUpInside];
        [titleBackView addSubview:prevButton];
        
        nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"calendar_next_month_btn_icon_normal"] forState:UIControlStateNormal];
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [nextButton addTarget:self action:@selector(moveCalendarToNextMonth:) forControlEvents:UIControlEventTouchUpInside];
        [titleBackView addSubview:nextButton];

        
        dateButtons = [NSMutableArray array];
        for (int i = 0; i <= 43; i++) {
            TTBDateButton *dateButton = [TTBDateButton buttonWithType:UIButtonTypeCustom];
            [dateButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [dateButton setTitleColor:APP_FONT_COLOR_NORMAL forState:UIControlStateNormal];
            [dateButton setTitleColor:[UIColor colorWithRed:144.0f / 255.0f green:144.0f / 255.0f blue:144.0f / 255.0f alpha:1.0f] forState:UIControlStateDisabled];
            [dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [dateButtons addObject:dateButton];
        }
        
        for(int i = 0 ; i<7;++i)
        {
            UILabel *lab = [[UILabel alloc]init];
            lab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
            lab.textColor = APP_FONT_COLOR_THIN;
            lab.textAlignment = NSTextAlignmentCenter;
            switch (i) {
                case 0:
                    lab.text = @"SUN";
                    break;
                case 1:
                    lab.text = @"MON";
                    break;
                case 2:
                    lab.text = @"TUE";
                    break;
                case 3:
                    lab.text = @"WED";
                    break;
                case 4:
                    lab.text = @"THU";
                    break;
                case 5:
                    lab.text = @"FRI";
                    break;
                case 6:
                    lab.text = @"SAT";
                    break;
                    
                default:
                    break;
            }
            [calendarContainer addSubview:lab];
            [weekTitleArr addObject:lab];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setUI];
}

- (void)setUI
{
    cellWidth = (SCREEN_WIDTH / 7.0) - CELL_BORDER_WIDTH;
    
    CGFloat containerHeight = ([self numberOfWeeksInMonthContainingDate:monthShowing] * (cellWidth + CELL_BORDER_WIDTH) + DAYS_HEADER_HEIGHT + TOP_HEIGHT);
    
    
    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight + CALENDAR_MARGIN + TOP_HEIGHT;
    self.frame = newFrame;
    
    titleBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, TOP_HEIGHT);
    
    titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, TOP_HEIGHT);
    
    prevButton.frame = CGRectMake(0, 0 , 50, TOP_HEIGHT);
    nextButton.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, TOP_HEIGHT);
    
    calendarContainer.frame = CGRectMake(0, 0, SCREEN_WIDTH, containerHeight);
    
    for (TTBDateButton *dateButton in dateButtons) {
        [dateButton removeFromSuperview];
    }
    
    for(int i = 0;i<weekTitleArr.count;++i)
    {
        UILabel *lab = (UILabel *)[weekTitleArr objectAtIndex:i];
        lab.frame = CGRectMake(SCREEN_WIDTH / 7 * i, CGRectGetMaxY(titleBackView.frame), SCREEN_WIDTH / 7, WeekTitleLabHeight);
    }
    
    NSDate *date = [self firstDayOfMonthContainingDate:monthShowing];
    uint dateButtonPosition = 0;
    while ([self dateIsInMonthShowing:date])
    {
        TTBDateButton *dateButton = [dateButtons objectAtIndex:dateButtonPosition];
        
        dateButton.date = date;

        
        if([self.selectedDay containsObject:dateButton.date])
        {
           [dateButton setBackgroundImage:[UIImage imageNamed:@"calendar_selecting_icon_normal"] forState:UIControlStateNormal];
            [dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [dateButton setBackgroundImage:nil forState:UIControlStateNormal];
            dateButton.backgroundColor = [self dateBackgroundColor];
            [dateButton setTitleColor:[self dateTextColor] forState:UIControlStateNormal];
        }
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay;
        comps = [calendar components:unitFlags fromDate:date];
        int year = (int)[comps year];
        int month = (int)[comps month];
        int day = (int)[comps day];
        int intValeDate = year * 10000 + month * 100 + day;
        comps = [calendar components:unitFlags fromDate:[NSDate date]];
        year = (int)[comps year];
        month = (int)[comps month];
        day = (int)[comps day];
        int intValeToday = year * 10000 + month * 100 + day;
        if(intValeDate < intValeToday)
            dateButton.enabled = NO;
        else
            dateButton.enabled = YES;
        
        dateButton.frame = [self calculateDayCellFrame:date];
        
        [calendarContainer addSubview:dateButton];
        
        date = [self nextDay:date];
        dateButtonPosition++;
    }
}

- (int)numberOfWeeksInMonthContainingDate:(NSDate *)date
{
    int weekNum = (int)[calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date].length;
    return weekNum;
}

- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date
{
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comps setDay:1];
    return [calendar dateFromComponents:comps];
}

- (BOOL)dateIsInMonthShowing:(NSDate *)date
{
    NSDateComponents *comps1 = [calendar components:(NSCalendarUnitMonth) fromDate:monthShowing];
    NSDateComponents *comps2 = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    return comps1.month == comps2.month;
}

- (UIColor *)dateBackgroundColor
{
    return (dateButtons.count > 0) ? ((TTBDateButton *)[dateButtons lastObject]).backgroundColor : nil;
}

- (UIColor *)dateTextColor
{
    return (dateButtons.count > 0) ? [((TTBDateButton *)[dateButtons lastObject]) titleColorForState:UIControlStateNormal] : nil;
}

- (CGRect)calculateDayCellFrame:(NSDate *)date
{
    int row = [self weekNumberInMonthForDate:date] - 1;
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (cellWidth + CELL_BORDER_WIDTH), (row * (cellWidth + CELL_BORDER_WIDTH)) + CELL_BORDER_WIDTH + TOP_HEIGHT + WeekTitleLabHeight, cellWidth, cellWidth);
}

- (int)weekNumberInMonthForDate:(NSDate *)date
{
    NSDateComponents *comps = [calendar components:(NSCalendarUnitWeekOfMonth) fromDate:date];
    return (int)comps.weekOfMonth;
}

- (int)dayOfWeekForDate:(NSDate *)date
{
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return (int)comps.weekday;
}

- (NSDate *)nextDay:(NSDate *)date
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}

- (void)moveCalendarToPreviousMonth:(UIButton *)button
{
    monthShowing = [[self firstDayOfMonthContainingDate:monthShowing] dateByAddingTimeInterval:-100000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月 ";
    NSString *dateStr = [dateFormatter stringFromDate:monthShowing];
    titleLabel.text = dateStr;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay;
    comps = [calendar components:unitFlags fromDate:monthShowing];
    int year = (int)[comps year];
    int month = (int)[comps month];
    int intValeDate = year * 100 + month;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    year = (int)[comps year];
    month = (int)[comps month];
    int intValeToday = year * 100 + month;
    
    if(intValeDate - intValeToday >= 3)
    {
        nextButton.enabled = NO;
    }
    else
    {
        nextButton.enabled = YES;
    }
    
    if(intValeToday != intValeDate)
        prevButton.enabled = YES;
    else
        prevButton.enabled = NO;
    
    [self setNeedsLayout];
}


- (void)moveCalendarToNextMonth:(UIButton *)button
{
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    monthShowing = [calendar dateByAddingComponents:comps toDate:monthShowing options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月 ";
    NSString *dateStr = [dateFormatter stringFromDate:monthShowing];
    titleLabel.text = dateStr;
    
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay;
    comps = [calendar components:unitFlags fromDate:monthShowing];
    int year = (int)[comps year];
    int month = (int)[comps month];
    int intValeDate = year * 100 + month;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    year = (int)[comps year];
    month = (int)[comps month];
    int intValeToday = year * 100 + month;
    
    if(intValeDate - intValeToday >= 3)
    {
        nextButton.enabled = NO;
    }
    else
    {
        nextButton.enabled = YES;
    }
    
    if(intValeToday != intValeDate)
        prevButton.enabled = YES;
    else
        prevButton.enabled = NO;
    
    [self setNeedsLayout];
}

- (void)dateButtonPressed:(id)sender {
    TTBDateButton *dateButton = sender;
    
    if([self.selectedDay containsObject:dateButton.date])
    {
        [self.selectedDay removeObject:dateButton.date];
    }
    else
    {
        if(self.repeatable || self.selectedDay.count == 0)
            [self.selectedDay addObject:dateButton.date];
        else
        {
            [self.selectedDay removeAllObjects];
            [self.selectedDay addObject:dateButton.date];
        }
    }
    [self setNeedsLayout];
}


@end
