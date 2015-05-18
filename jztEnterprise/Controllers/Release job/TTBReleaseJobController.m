//
//  TTBReleaseJobController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/24.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBReleaseJobController.h"
#import "TTBReleaseJobViewIphone.h"
#import "TTBActionSheet.h"
#import "TTBDropListView.h"
#import "TTBReleaseJobFootCell.h"

@interface TTBReleaseJobController ()<UITableViewDataSource,UITableViewDelegate,TTBActionSheetDelegate,UIGestureRecognizerDelegate,TTBDropListDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    TTBReleaseJobViewBase *_baseView;
    
    BOOL isShowDropList;
    TTBDropListView *dropListView;
    
    NSArray *unitArr;
    NSMutableArray *jobTypeArr;
    NSArray *countWayArr;
}

@end

@implementation TTBReleaseJobController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBReleaseJobViewIphone alloc]init];
        self.view = _baseView;
        
        self.title = @"发布兼职";
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        isShowDropList = NO;
        
        unitArr = [[NSArray alloc]initWithObjects:@"元/天",@"元/月",@"元/次",@"元/小时", nil];
        jobTypeArr = [NSMutableArray arrayWithObjects:@"礼仪",@"发传单",@"啥",@"啥",@"啥",@"啥",@"啥", nil];
        countWayArr = [NSArray arrayWithObjects:@"日结",@"周结",@"月结",@"完工结", nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dropListView.delegate = self;
    UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMainScreen:)];
    mainTap.delegate = self;
    [dropListView addGestureRecognizer:mainTap];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)tapMainScreen:(UITapGestureRecognizer *)tap
{
    [dropListView tapMainScreen:nil];
    isShowDropList = NO;
    [_baseView animateHistoryArrowImg];
}

- (void)hideKeyBoard
{
    TTBReleaseJobCell *cell1 = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell1.contentText resignFirstResponder];
    
    TTBReleaseJobCell *cell2 = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell2.contentText resignFirstResponder];
    
    TTBReleaseJobCell *cell3 = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    [cell3.contentText resignFirstResponder];
    
    TTBReleaseJobCell *cell4 = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
    [cell4.contentText resignFirstResponder];
    
    TTBReleaseJobCell *cell5 = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    [cell5.contentView endEditing:YES];
}

#pragma mark - TTBDropListDelegate
- (void)clickedOnItemOnIndex:(int)index ofDropList:(TTBDropListView *)dropList
{
    isShowDropList = NO;
    [_baseView animateHistoryArrowImg];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view.tag == 400)
    {
        return YES;
    }
    return NO;
}


#pragma mark - historyTemplateViewTaped
- (void)historyTemplateViewTaped:(UITapGestureRecognizer *)tap
{
    [self hideKeyBoard];
    if(!isShowDropList)
    {
        [dropListView showWithTitlesArrAsHistoryList:@[@"历史兼职1",@"历史兼职2",@"历史兼职3",@"历史兼职4",@"历史兼职5",@"历史兼职6",@"历史兼职7",@"历史兼职8",@"历史兼职9",@"历史兼职0"] parentView:self.view];
        
        isShowDropList = YES;
    }
    else
    {
        [dropListView tapMainScreen:nil];
        isShowDropList = NO;
    }
    
    
    [_baseView animateHistoryArrowImg];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    if(section == 1)
        return 3;
    if(section == 2)
        return 4;
    if(section == 3)
        return 1;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 4 && indexPath.row == 4)
    {
        static NSString *cellIdentifier = @"ReleaseJobFootCell";
        TTBReleaseJobFootCell *cell = (TTBReleaseJobFootCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[TTBReleaseJobFootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"ReleaseJobCell";
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[TTBReleaseJobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        [cell.contentView removeLines];
        
        if(indexPath.section == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_JobTitle];
        }
        
        if(indexPath.section == 1 && indexPath.row == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Money];
        }
        if(indexPath.section == 1 && indexPath.row == 1)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_JobType];
        }
        if(indexPath.section == 1 && indexPath.row == 2)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_CountWay];
        }
        
        if(indexPath.section == 2 && indexPath.row == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Deadline];
        }
        if(indexPath.section == 2 && indexPath.row == 1)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_WorkDate];
        }
        if(indexPath.section == 2 && indexPath.row == 2)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_NumOfWorker];
            cell.contentText.delegate = self;
        }
//        if(indexPath.section == 2 && indexPath.row == 3)
//        {
//            [cell initReleaseJobCellView:ReleaseJobCellType_JobArea];
//        }
        if(indexPath.section == 2 && indexPath.row == 3)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_JobAddress];
            cell.contentText.delegate = self;
        }
        
        if(indexPath.section == 3 && indexPath.row == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobJobContentRowHeight - 0.5, SCREEN_WIDTH, 0.5)];
            [cell initReleaseJobCellView:ReleaseJobCellType_JobContent];
            cell.jobContentView.delegate = self;
        }
        
        if(indexPath.section == 4 && indexPath.row == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Sex];
        }
        if(indexPath.section == 4 && indexPath.row == 1)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_Height];
        }
        if(indexPath.section == 4 && indexPath.row == 2)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_HealthCertificate];
        }
        if(indexPath.section == 4 && indexPath.row == 3)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Interview];
        }
        
        
        
        if((indexPath.section == 0) || (indexPath.section == 2 && indexPath.row == 2) || (indexPath.section == 2 && indexPath.row == 3) || indexPath.section == 3)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self hideKeyBoard];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0;
    return ReleaseJobTableViewSectionViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ReleaseJobTableViewSectionViewHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
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
    if(indexPath.section == 3)
        return ReleaseJobJobContentRowHeight;
    if(indexPath.section == 4 && indexPath.row == 4)
        return ReleaseJobFootCellHeight;
    return ReleaseJobCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideKeyBoard];
    TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;

    if(indexPath.section == 1 && indexPath.row == 0)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 1;
        act.delegate = self;
        [act showWithTitlesArrAsTable:unitArr parentView:self.view defaultSelectedIndex:1];
    }
    if(indexPath.section == 1 && indexPath.row == 1)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 2;
        act.delegate = self;
        [act showWithTitlesArrAsTable:jobTypeArr parentView:self.view defaultSelectedIndex:1];
    }
    if(indexPath.section == 1 && indexPath.row == 2)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 3;
        act.delegate = self;
        [act showWithTitlesArrAsTable:countWayArr parentView:self.view defaultSelectedIndex:1];
    }
    if(indexPath.section == 2 && indexPath.row == 0)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.delegate = self;
        act.specialTag = 10;
        [act showCalendarWithParentView:self.view selectedDateArr:nil repeatable:NO];
    }
    if(indexPath.section == 2 && indexPath.row == 1)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 4;
        act.delegate = self;
        [act showWithTitlesArrAsBtn:@[@"选择日期",@"一个月以上"] parentView:self.view defaultSelectedIndex:-1];
    }
    if(indexPath.section == 4 && indexPath.row == 0)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 5;
        act.delegate = self;
        [act showWithTitlesArrAsTable:@[@"男",@"女",@"不限"] parentView:self.view defaultSelectedIndex:1];
    }
    if(indexPath.section == 4 && indexPath.row == 1)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 6;
        act.delegate = self;
        [act showAsSliderWithParentView:self.view defaultSelectedValue:160];
    }
    if(indexPath.section == 4 && indexPath.row == 2)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 7;
        act.delegate = self;
        [act showWithTitlesArrAsTable:@[@"需要",@"不需要"] parentView:self.view defaultSelectedIndex:1];
    }
    if(indexPath.section == 4 && indexPath.row == 3)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 8;
        act.delegate = self;
        [act showWithTitlesArrAsTable:@[@"需要",@"不需要"] parentView:self.view defaultSelectedIndex:1];
    }
    
}

#pragma mark - TTBActionSheetDelegate
- (void)clickedOnItemOnIndex:(int)index ofActionSheet:(TTBActionSheet *)actionSheet returnValue:(float)value
{
    NSLog(@"%d",actionSheet.specialTag);
    
    if(actionSheet.specialTag == 1)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.tipLab.text = [unitArr objectAtIndex:index];
    }
    
    if(actionSheet.specialTag == 2)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        cell.tipLab.text = [jobTypeArr objectAtIndex:index];
    }
    
    if(actionSheet.specialTag == 3)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        cell.tipLab.text = [countWayArr objectAtIndex:index];
    }
    
    if(actionSheet.specialTag == 5)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
            cell.tipLab.text = @"男";
        if(index == 1)
            cell.tipLab.text = @"女";
        if(index == 2)
            cell.tipLab.text = @"无";
    }
    
    if(actionSheet.specialTag == 6)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:4]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
            cell.tipLab.text = @"无";
        if(index == 1)
            cell.tipLab.text = [NSString stringWithFormat:@"%0.1fcm",value];
    }
    
    if(actionSheet.specialTag == 7)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:4]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
            cell.tipLab.text = @"需要";
        if(index == 1)
            cell.tipLab.text = @"不需要";
    }
    
    if(actionSheet.specialTag == 8)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:4]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
            cell.tipLab.text = @"需要";
        if(index == 1)
            cell.tipLab.text = @"不需要";
    }
    
    if(actionSheet.specialTag == 4 && index == 0)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.delegate = self;
        act.specialTag = 9;
        [act showCalendarWithParentView:self.view selectedDateArr:nil repeatable:YES];
    }
}

- (void)calendarReturnWithSelectedDates:(NSArray *)datesArr ofActionSheet:(TTBActionSheet *)actionSheet
{
    if(actionSheet.specialTag == 9)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = @"";
        for(int i = 0; i< datesArr.count; ++i)
        {
            NSDate *date = (NSDate *)[datesArr objectAtIndex:i];
            NSString *str = [dateFormatter stringFromDate:date];
            if(i == (datesArr.count - 1))
                dateStr = [dateStr stringByAppendingString:str];
            else
                dateStr = [dateStr stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
        }
        cell.tipLab.text = dateStr;
    }
    if(actionSheet.specialTag == 10)
    {
        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = (NSDate *)[datesArr objectAtIndex:0];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        cell.tipLab.text = dateStr;
    }

}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [_baseView.baseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:4] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    if([textView.text isEqualToString:@"请输入兼职内容"])
    {
        textView.textColor = APP_FONT_COLOR_NORMAL;
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        textView.textColor = SeparatorColor;
        textView.text = @"请输入兼职内容";
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_baseView.baseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:4] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [textField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
