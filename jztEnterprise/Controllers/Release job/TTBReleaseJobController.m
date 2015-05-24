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
#import "TTBSelectCityViewController.h"
#import "TTBReleaseJobParam.h"
#import "TTBSelectInterviewViewController.h"
#import "TTBUserEntity.h"

@interface TTBReleaseJobController ()<UITableViewDataSource,UITableViewDelegate,TTBActionSheetDelegate,UIGestureRecognizerDelegate,TTBDropListDelegate,UITextViewDelegate,UITextFieldDelegate,TTBSelectCityViewControllerDelegate,TTBSelectInterviewViewControllerDelegate>
{
    TTBReleaseJobViewBase *_baseView;
    
    BOOL isShowDropList;
    TTBDropListView *dropListView;
    
    NSArray *unitArr;
    NSMutableArray *jobTypeArr;
    NSArray *countWayArr;
    
    int selectedUnitIndex;
    int selectedCountIndex;
    int selectedTypeIndex;
    int selectedSexIndex;
    int selectedHelthIndex;
    NSDate *selectDeadline;
    NSArray *workDates;
    BOOL isJobLong;
//    int selectedInterviewIndex;
    ZGAreaEntity *selectedArea;
    NSString *height;
    NSString *interviewTime;
    NSString *interviewAddr;
    BOOL isInterview;
    
    TTBReleaseJobParam *param;
    
    TTBUserEntity *userEntity;
    
    NSString *dates;
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
        
        param = [[TTBReleaseJobParam alloc]init];
        userEntity = [TTBUtility readUserDefaults:USER_DEFAULT_ENTITY_KEY];
        param.mobile = userEntity.mobile;
        param.pwd = userEntity.pwd;
        param.enterId = userEntity.identity;
        
        selectedCountIndex = -1;
        selectedTypeIndex = -1;
        selectedSexIndex = 2;
        selectedHelthIndex = 1;
//        selectedInterviewIndex = 1;
        isJobLong = NO;
        height = @"0";
        isInterview = NO;
        
        self.title = @"发布兼职";
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        isShowDropList = NO;
        
        unitArr = [[NSArray alloc]initWithObjects:@"元/时",@"元/天",@"元/周",@"元/月", nil];
        jobTypeArr = [NSMutableArray arrayWithObjects:@"促销员",@"发传单",@"服务员",@"礼仪模特",@"工作人员",@"问卷调查",@"话务员", nil];
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
    [_baseView.nameText resignFirstResponder];
    [_baseView.payText resignFirstResponder];
    [_baseView.timeText resignFirstResponder];
    [_baseView.numText resignFirstResponder];
    TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    [cell.contentView endEditing:YES];
    [_baseView.addressText endEditing:YES];
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
        return 6;
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
            [cell.releseBtn addTarget:self action:@selector(releaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
            [cell.contentView addSubview:_baseView.nameText];
        }
        
        if(indexPath.section == 1 && indexPath.row == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Money];
            [cell.contentView addSubview:_baseView.payText];
            [cell.contentView addSubview:_baseView.payTipLab];
        }
        if(indexPath.section == 1 && indexPath.row == 1)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_JobType];
            [cell.contentView addSubview:_baseView.jobTypeTipLab];
        }
        if(indexPath.section == 1 && indexPath.row == 2)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_CountWay];
            [cell.contentView addSubview:_baseView.countTypeTipLab];
        }
        
        if(indexPath.section == 2 && indexPath.row == 0)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Deadline];
            _baseView.deadlineTipLab.frame = CGRectMake(ReleaseJobTitleWidth + 17.5 + 5, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - 17.5 - 5 - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
            [cell.contentView addSubview:_baseView.deadlineTipLab];
        }
        if(indexPath.section == 2 && indexPath.row == 1)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_WorkDate];
            _baseView.workDaysTipLab.frame = CGRectMake(ReleaseJobTitleWidth + 17.5 + 5, 0, SCREEN_WIDTH - ReleaseJobTitleWidth - 17.5 - 5 - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
            [cell.contentView addSubview:_baseView.workDaysTipLab];
        }
        if(indexPath.section == 2 && indexPath.row == 2)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_WorkTime];
            [cell.contentView addSubview:_baseView.timeText];
        }
        if(indexPath.section == 2 && indexPath.row == 3)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_NumOfWorker];
            _baseView.numText.delegate = self;
            [cell.contentView addSubview:_baseView.numText];
        }
        if(indexPath.section == 2 && indexPath.row == 4)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_JobArea];
            [cell.contentView addSubview:_baseView.areaTipLab];
        }
        
        if(indexPath.section == 2 && indexPath.row == 5)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_JobAddress];
            [cell.contentView addSubview:_baseView.addressText];
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
            [cell.contentView addSubview:_baseView.sexTipLab];
        }
        if(indexPath.section == 4 && indexPath.row == 1)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_Height];
            [cell.contentView addSubview:_baseView.heightTipLab];
        }
        if(indexPath.section == 4 && indexPath.row == 2)
        {
            [cell initReleaseJobCellView:ReleaseJobCellType_HealthCertificate];
            [cell.contentView addSubview:_baseView.healthTipLab];
        }
        if(indexPath.section == 4 && indexPath.row == 3)
        {
            [cell.contentView addLineWithFrame:CGRectMake(0, ReleaseJobCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
            
            [cell initReleaseJobCellView:ReleaseJobCellType_Interview];
            [cell.contentView addSubview:_baseView.interviewTipLab];
        }
        
        
        
        if((indexPath.section == 0) || (indexPath.section == 2 && indexPath.row == 2) || (indexPath.section == 2 && indexPath.row == 3) || (indexPath.section == 2 && indexPath.row == 5) || indexPath.section == 3)
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self hideKeyBoard];
//    TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.selected = NO;

    if(indexPath.section == 1 && indexPath.row == 0)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 1;
        act.delegate = self;
        [act showWithTitlesArrAsTable:unitArr parentView:self.view defaultSelectedIndex:selectedUnitIndex];
    }
    if(indexPath.section == 1 && indexPath.row == 1)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 2;
        act.delegate = self;
        [act showWithTitlesArrAsTable:jobTypeArr parentView:self.view defaultSelectedIndex:selectedTypeIndex];
    }
    if(indexPath.section == 1 && indexPath.row == 2)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 3;
        act.delegate = self;
        [act showWithTitlesArrAsTable:countWayArr parentView:self.view defaultSelectedIndex:selectedCountIndex];
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
    if(indexPath.section == 2 && indexPath.row == 4)
    {
        TTBSelectCityViewController *selectCityController = [[TTBSelectCityViewController alloc]init];
        selectCityController.delegate = self;
        [self.navigationController pushViewController:selectCityController animated:YES];
    }
    
    if(indexPath.section == 4 && indexPath.row == 0)
    {
        TTBActionSheet *act = [[TTBActionSheet alloc]init];
        act.specialTag = 5;
        act.delegate = self;
        [act showWithTitlesArrAsTable:@[@"男",@"女",@"不限"] parentView:self.view defaultSelectedIndex:selectedSexIndex];
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
        [act showWithTitlesArrAsTable:@[@"需要",@"不需要"] parentView:self.view defaultSelectedIndex:selectedHelthIndex];
    }
    if(indexPath.section == 4 && indexPath.row == 3)
    {
//        TTBActionSheet *act = [[TTBActionSheet alloc]init];
//        act.specialTag = 8;
//        act.delegate = self;
//        [act showWithTitlesArrAsTable:@[@"需要",@"不需要"] parentView:self.view defaultSelectedIndex:selectedInterviewIndex];
        
        TTBSelectInterviewViewController *interviewController = [[TTBSelectInterviewViewController alloc]init];
        interviewController.delegate = self;
        [self.navigationController pushViewController:interviewController animated:YES];
        
    }
    
}

#pragma mark - TTBActionSheetDelegate
- (void)clickedOnItemOnIndex:(int)index ofActionSheet:(TTBActionSheet *)actionSheet returnValue:(float)value
{
    NSLog(@"%d",actionSheet.specialTag);
    
    if(actionSheet.specialTag == 1)
    {
        _baseView.payTipLab.text = [unitArr objectAtIndex:index];
        selectedUnitIndex = index;
    }
    
    if(actionSheet.specialTag == 2)
    {
        _baseView.jobTypeTipLab.textColor = APP_FONT_COLOR_NORMAL;
        _baseView.jobTypeTipLab.text = [jobTypeArr objectAtIndex:index];
        selectedTypeIndex = index;
    }
    
    if(actionSheet.specialTag == 3)
    {
        _baseView.countTypeTipLab.textColor = APP_FONT_COLOR_NORMAL;
        _baseView.countTypeTipLab.text = [countWayArr objectAtIndex:index];
        selectedCountIndex = index;
    }
    
    if(actionSheet.specialTag == 5)
    {
        _baseView.sexTipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
            _baseView.sexTipLab.text = @"男";
        if(index == 1)
            _baseView.sexTipLab.text = @"女";
        if(index == 2)
            _baseView.sexTipLab.text = @"无限制";
        selectedSexIndex = index;
    }
    
    if(actionSheet.specialTag == 6)
    {
        _baseView.heightTipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
        {
            _baseView.heightTipLab.text = @"无限制";
            height = @"0";
        }
        if(index == 1)
        {
            _baseView.heightTipLab.text = [NSString stringWithFormat:@"%0.1fcm",value];
            height = [NSString stringWithFormat:@"%0.1f",value];
        }
    }
    
    if(actionSheet.specialTag == 7)
    {
        _baseView.healthTipLab.textColor = APP_FONT_COLOR_NORMAL;
        if(index == 0)
            _baseView.healthTipLab.text = @"需要";
        if(index == 1)
            _baseView.healthTipLab.text = @"不需要";
        selectedHelthIndex = index;
    }
    
//    if(actionSheet.specialTag == 8)
//    {
//        TTBReleaseJobCell *cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:4]];
//        cell.tipLab.textColor = APP_FONT_COLOR_NORMAL;
//        if(index == 0)
//            cell.tipLab.text = @"需要";
//        if(index == 1)
//            cell.tipLab.text = @"不需要";
//        selectedInterviewIndex = index;
//    }
//    
    if(actionSheet.specialTag == 4)
    {
        if(index == 0)
        {
            TTBActionSheet *act = [[TTBActionSheet alloc]init];
            act.delegate = self;
            act.specialTag = 9;
            [act showCalendarWithParentView:self.view selectedDateArr:nil repeatable:YES];
            isJobLong = NO;
        }
        else
        {
            _baseView.workDaysTipLab.textColor = APP_FONT_COLOR_NORMAL;
            _baseView.workDaysTipLab.text = @"长期";
            isJobLong = YES;
        }
    }
}

- (void)calendarReturnWithSelectedDates:(NSArray *)datesArr ofActionSheet:(TTBActionSheet *)actionSheet
{
    if(actionSheet.specialTag == 9)
    {
        if(datesArr.count > 0)
        {
            _baseView.workDaysTipLab.textColor = APP_FONT_COLOR_NORMAL;
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
            dates = dateStr;
            _baseView.workDaysTipLab.text = dateStr;
            workDates = datesArr;
        }
    }
    if(actionSheet.specialTag == 10)
    {
        if(datesArr.count > 0)
        {
            _baseView.deadlineTipLab.textColor = APP_FONT_COLOR_NORMAL;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = (NSDate *)[datesArr objectAtIndex:0];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            _baseView.deadlineTipLab.text = dateStr;
            selectDeadline = date;
        }
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

#pragma -mark TTBSelectCityViewControllerDelegate
- (void)didSelectArea:(ZGAreaEntity *)entity
{
    _baseView.areaTipLab.text = entity.name;
    _baseView.areaTipLab.textColor = APP_FONT_COLOR_NORMAL;
    selectedArea = entity;
}

#pragma -mark TTBSelectInterviewViewControllerDelegate
- (void)didFinishInputInterviewTime:(NSString *)time address:(NSString *)address
{
    if(time)
    {
        _baseView.interviewTipLab.text = [NSString stringWithFormat:@"%@,%@",time,address];
        isInterview = YES;
        
        interviewTime = time;
        interviewAddr = address;
    }
    else
    {
        _baseView.interviewTipLab.text = @"不需要";
        isInterview = NO;
    }
}

#pragma -mark 发布按钮事件
- (void)releaseBtnClicked:(UIButton *)button
{
    TTBReleaseJobCell *cell;
    cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *name = [_baseView.nameText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([name isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"兼职名不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        param.name = name;
        
        cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        NSString *pay = [_baseView.payText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([pay isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"薪资不能为空！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            param.pay = pay;
            param.payUnitId = [NSString stringWithFormat:@"%d",selectedUnitIndex + 1];
            
            if(selectedTypeIndex == -1)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"工种未选择！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                param.jobTypeId = [NSString stringWithFormat:@"%d",selectedTypeIndex + 1];
                
                if(selectedCountIndex == -1)
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"结算方式未选择！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                else
                {
                    param.countTypeId = [NSString stringWithFormat:@"%d",selectedCountIndex + 1];
                    
                    if(!selectDeadline)
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"截止日期未选择！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                    }
                    else
                    {
                        param.deadline = [NSString stringWithFormat:@"%@",selectDeadline];
                        
                        if(!isJobLong && !workDates)
                        {
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"工作日期未选择！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                            [alert show];
                        }
                        else
                        {
                            if(isJobLong)
                            {
                                param.workTimeType = @"1";
                            }
                            else
                            {
                                param.workTimeType = @"0";
                                param.dates = dates;
                            }
                            
                            cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
                            NSString *time = [_baseView.timeText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                            if([time isEqualToString:@""])
                            {
                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"工作时间未输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                [alert show];
                            }
                            else
                            {
                                param.time = time;
                                
                                cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
                                NSString *num = [_baseView.numText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                                if([num isEqualToString:@""])
                                {
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"人数未输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alert show];
                                }
                                else
                                {
                                    param.num = num;
                                    
                                    if(!selectedArea)
                                    {
                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"工作区域未选择！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                        [alert show];
                                    }
                                    else
                                    {
                                        param.areaId = [NSString stringWithFormat:@"%ld",selectedArea.identity];
                                        
                                        cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:2]];
                                        NSString *address = [_baseView.addressText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                                        if([address isEqualToString:@""])
                                        {
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"工作地址未输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                            [alert show];
                                        }
                                        else
                                        {
                                            param.address = address;
                                            
                                            cell = (TTBReleaseJobCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                                            NSString *jobContent = [cell.jobContentView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                                            if([jobContent isEqualToString:@""])
                                            {
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"工作内容未输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                                [alert show];
                                            }
                                            else
                                            {
                                                param.jobContent = jobContent;
                                                
                                                if(selectedSexIndex == 0)
                                                    param.sex = @"1";
                                                if(selectedSexIndex == 1)
                                                    param.sex = @"2";
                                                if(selectedSexIndex == 2)
                                                    param.sex = @"0";
                                                
                                                param.height = height;
                                                
                                                if(selectedHelthIndex == 1)
                                                {
                                                    param.health = @"0";
                                                }
                                                else
                                                {
                                                    param.health = @"1";
                                                }
                                                
                                                if(isInterview)
                                                {
                                                    param.interview = @"1";
                                                    param.interviewAddr = interviewAddr;
                                                    param.interviewTime = interviewTime;
                                                }
                                                else
                                                {
                                                    param.interview = @"0";
                                                }
                                                
                                                [[TTBReleaseJobProcess shareInstance]releaseJobWithParam:[param getDictionary] ParentView:nil progressText:@"发布中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    
                                                    int code = [[responseObject objectForKey:@"code"] intValue];
                                                    if(code == 200)
                                                    {
                                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                                        [alert show];
                                                    }
                                                    else
                                                    {
                                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                                        [alert show];
                                                    }

                                                    
                                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    
                                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                                    [alert show];
                                                    
                                                }];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma -mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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
