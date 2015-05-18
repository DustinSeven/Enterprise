//
//  TTBActionSheet.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBActionSheet.h"
#import "TTBSliderPaneView.h"
#import "TTBCalendarView.h"

@interface TTBActionSheet()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backGroundView;
    
    UITableView *baseTableView;
    
    NSArray *tableTitlesArr;
    
    int defaultSelectedIndex;
    
    TTBCalendarView *calendarView;
    
    TTBSliderPaneView *sliderView;
}

@end

@implementation TTBActionSheet

- (id)init
{
    self = [super init];
    if(self)
    {
        backGroundView = [[UIView alloc]init];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];
        
        defaultSelectedIndex = -1;
    }
    return self;
}

- (void)tapMainScreen:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.2 animations:^{
        
        backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame), SCREEN_WIDTH, 0);
        self.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)showCalendarWithParentView:(UIView *)parentView selectedDateArr:(NSArray *)selectedDateArr repeatable:(BOOL)repeatable
{
    calendarView = [[TTBCalendarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ActionSheetSliderPaneCalendarHeight)];
    calendarView.repeatable = repeatable;
    [backGroundView addSubview:calendarView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, ActionSheetSliderPaneCalendarHeight - ActionSheetSliderPaneCalendarFootViewHeight, SCREEN_WIDTH, ActionSheetSliderPaneCalendarFootViewHeight)];
    footView.backgroundColor = MainColorNormal;
    [backGroundView addSubview:footView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneCalendarFootViewHeight)] forState:UIControlStateHighlighted];
    [cancelBtn setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0,0,ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneCalendarFootViewHeight);
    [footView addSubview:cancelBtn];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterBtn setTitle:@"确定" forState:UIControlStateNormal];
    [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateNormal];
    [enterBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneCalendarFootViewHeight)] forState:UIControlStateHighlighted];
    [enterBtn setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    [enterBtn addTarget:self action:@selector(calendarEnterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    enterBtn.frame = CGRectMake(SCREEN_WIDTH - ActionSheetSliderPaneBtnWidth,0,ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneCalendarFootViewHeight);
    enterBtn.tag = 1001;
    [footView addSubview:enterBtn];
    
    backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame), SCREEN_WIDTH, 0);
    [UIView animateWithDuration:0.2 animations:^{
        [super showInParentView:parentView];
        backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - ActionSheetSliderPaneCalendarHeight, SCREEN_WIDTH, ActionSheetSliderPaneCalendarHeight);
        
    } completion:^(BOOL finished) {
        
    }];

}

- (void)showWithTitlesArrAsTable:(NSArray *)titlesArr parentView:(UIView *)parentView defaultSelectedIndex:(int)index
{
    tableTitlesArr = titlesArr;
    defaultSelectedIndex = index;
    baseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titlesArr.count * ActionSheetCellHeight)];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.showsVerticalScrollIndicator = NO;
    UIView *view = [UIView new];
    baseTableView.delaysContentTouches = NO;
    view.backgroundColor = [UIColor clearColor];
    [baseTableView setTableFooterView:view];
    baseTableView.bounces = NO;
    baseTableView.dataSource = self;
    baseTableView.delegate = self;
    [backGroundView addSubview:baseTableView];
    
    backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame), SCREEN_WIDTH, 0);
    [UIView animateWithDuration:0.2 animations:^{
        [super showInParentView:parentView];
        backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - titlesArr.count * ActionSheetCellHeight, SCREEN_WIDTH, titlesArr.count * ActionSheetCellHeight);
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)showWithTitlesArrAsBtn:(NSArray *)titlesArr parentView:(UIView *)parentView defaultSelectedIndex:(int)index
{
    tableTitlesArr = titlesArr;
    defaultSelectedIndex = index;
    
    for(int i = 0;i<titlesArr.count;++i)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[titlesArr objectAtIndex:i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if(index == i)
        {
            [btn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ActionSheetBtnWidth, ActionSheetBtnHeight)] forState:UIControlStateNormal];
            [btn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ActionSheetBtnWidth, ActionSheetBtnHeight)] forState:UIControlStateHighlighted];
            
        }
        else
        {
            [btn setBackgroundImage:[TTBUtility imageWithColor:ActionSheetBtnColorNormal size:CGSizeMake(ActionSheetBtnWidth, ActionSheetBtnHeight)] forState:UIControlStateNormal];
            [btn setBackgroundImage:[TTBUtility imageWithColor:ActionSheetBtnColorPressed size:CGSizeMake(ActionSheetBtnWidth, ActionSheetBtnHeight)] forState:UIControlStateHighlighted];
        }
        btn.frame = CGRectMake((SCREEN_WIDTH - ActionSheetBtnWidth) / 2, ActionSheetBtnSpacingV + i * (ActionSheetBtnSpacingB + ActionSheetBtnHeight), ActionSheetBtnWidth, ActionSheetBtnHeight);
        [backGroundView addSubview:btn];
    }
    
    backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame), SCREEN_WIDTH, 0);
    [UIView animateWithDuration:0.2 animations:^{
        [super showInParentView:parentView];
        backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - (titlesArr.count * (ActionSheetBtnHeight + ActionSheetBtnSpacingB) - ActionSheetBtnSpacingB + 2 * ActionSheetBtnSpacingV), SCREEN_WIDTH, titlesArr.count * (ActionSheetBtnHeight + ActionSheetBtnSpacingB) - ActionSheetBtnSpacingB + 2 * ActionSheetBtnSpacingV);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showAsSliderWithParentView:(UIView *)parentView defaultSelectedValue:(float)value
{
    sliderView = [[TTBSliderPaneView alloc]initWithFrame:CGRectMake(0, ActionSheetSliderPaneBtnBgHeight, SCREEN_WIDTH, ActionSheetSliderPaneHeight)];
    [sliderView slideToValue:value];
    [backGroundView addSubview:sliderView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ActionSheetSliderPaneBtnBgHeight)];
    headView.backgroundColor = MainColorNormal;
    [backGroundView addSubview:headView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateHighlighted];
    [cancelBtn setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0,0,ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight);
    [headView addSubview:cancelBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), 10, 0.5, ActionSheetSliderPaneBtnBgHeight - 20)];
    line.backgroundColor = [UIColor colorWithRed:0.0 / 255.0f green:139.0f / 255.0f blue:230.0f / 255.0f alpha:1.0f];
    [headView addSubview:line];
    
    UIButton *noLimitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noLimitBtn setTitle:@"不限" forState:UIControlStateNormal];
    [noLimitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [noLimitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateNormal];
    [noLimitBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateHighlighted];
    [noLimitBtn setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    [noLimitBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    noLimitBtn.frame = CGRectMake(CGRectGetMaxX(line.frame),0,ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight);
    noLimitBtn.tag = 1000;
    [headView addSubview:noLimitBtn];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterBtn setTitle:@"确定" forState:UIControlStateNormal];
    [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateNormal];
    [enterBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorHeavy size:CGSizeMake(ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight)] forState:UIControlStateHighlighted];
    [enterBtn setTitleColor:APP_FONT_COLOR_THIN forState:UIControlStateHighlighted];
    [enterBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    enterBtn.frame = CGRectMake(SCREEN_WIDTH - ActionSheetSliderPaneBtnWidth,0,ActionSheetSliderPaneBtnWidth,ActionSheetSliderPaneBtnBgHeight);
    enterBtn.tag = 1001;
    [headView addSubview:enterBtn];
    
    backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame), SCREEN_WIDTH, 0);
    [UIView animateWithDuration:0.2 animations:^{
        [super showInParentView:parentView];
        backGroundView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - (ActionSheetSliderPaneHeight + ActionSheetSliderPaneBtnBgHeight), SCREEN_WIDTH, ActionSheetSliderPaneHeight + ActionSheetSliderPaneBtnBgHeight);
        
    } completion:^(BOOL finished) {
        
    }];

}

#pragma mark - calendarEnterBtnClicked
- (void)calendarEnterBtnClicked:(UIButton *)button
{
    [self.delegate calendarReturnWithSelectedDates:calendarView.selectedDay ofActionSheet:self];
    [self tapMainScreen:nil];
}

#pragma mark - CancelBtnClicked
- (void)cancelBtnClicked:(UIButton *)btn
{
    [self tapMainScreen:nil];
}

#pragma mark - btnClicked
- (void)btnClicked:(UIButton *)btn
{
    [self.delegate clickedOnItemOnIndex:(int)(btn.tag - 1000) ofActionSheet:self returnValue:sliderView.heightValue];
    [self tapMainScreen:nil];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableTitlesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ActionSheetCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [tableTitlesArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if(indexPath.row == defaultSelectedIndex)
        cell.textLabel.textColor = MainColorNormal;
    else
        cell.textLabel.textColor = APP_FONT_COLOR_NORMAL;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ActionSheetCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    [self.delegate clickedOnItemOnIndex:(int)indexPath.row ofActionSheet:self returnValue:0];
    
    [self tapMainScreen:nil];
}


@end
