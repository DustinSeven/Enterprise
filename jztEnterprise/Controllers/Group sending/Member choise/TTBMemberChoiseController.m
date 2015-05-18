//
//  TTBMemberChoiseController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberChoiseController.h"
#import "TTBMemberChoiseViewIphone.h"
#import "TTBMemberChoiseCell.h"
#import "TTBMemberAllSelectCell.h"
#import "TTBGroupSendingController.h"

@interface TTBMemberChoiseController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBMemberChoiseViewBase *_baseView;
    
    NSMutableArray *contactArr;
    
    NSMutableArray *selectedArr;
}

@end

@implementation TTBMemberChoiseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBMemberChoiseViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        self.title = @"选择人员";
        
        self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"下一步" target:self action:@selector(nextStepBtnClicked) spacing:-15];
        
        contactArr = [[NSMutableArray alloc]initWithArray: @[@"林荣1", @"林丹2", @"周董3", @"周树人4", @"周杰伦5", @"阿华6", @"周董7", @"周树人8", @"周杰伦9", @"阿华0", @"周董11", @"周树人22", @"周杰伦33", @"阿华44", @"周董55", @"周树人66", @"周杰伦77", @"阿华88", @"周董99", @"周树人00", @"周杰伦111", @"阿华222", @"周董333", @"周树人444", @"周杰伦555", @"阿华666"]];
        selectedArr = [NSMutableArray array];
    }
}

- (void)nextStepBtnClicked
{
    if(selectedArr.count == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没选择任何报名人员!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else
    {
        TTBGroupSendingController *groupSendingController = [[TTBGroupSendingController alloc]init];
        [self.navigationController pushViewController:groupSendingController animated:YES];
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contactArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString *cellIdentifier = @"MemberAllChoiseCell";
        TTBMemberAllSelectCell *cell = (TTBMemberAllSelectCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[TTBMemberAllSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if(selectedArr.count == contactArr.count)
            [cell setCusSelected:YES];
        else
            [cell setCusSelected:NO];
        
        cell.userImg0.image = [UIImage imageNamed:@"user_img_default_120px"];
        cell.userImg1.image = [UIImage imageNamed:@"user_img_default_120px"];
        cell.userImg2.image = [UIImage imageNamed:@"user_img_default_120px"];
        cell.userImg3.image = [UIImage imageNamed:@"user_img_default_120px"];
        cell.userImg4.image = [UIImage imageNamed:@"user_img_default_120px"];
        cell.userImg5.image = [UIImage imageNamed:@"user_img_default_120px"];

        if(indexPath.row == 0)
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        else
            [cell.contentView removeLines];
        
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"MemberChoiseCell";
        TTBMemberChoiseCell *cell = (TTBMemberChoiseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[TTBMemberChoiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if([selectedArr containsObject:[contactArr objectAtIndex:indexPath.row - 1]])
            [cell setCusSelected:YES];
        else
            [cell setCusSelected:NO];
        cell.userImg.image = [UIImage imageNamed:@"user_img_default_120px"];
        cell.userNameLab.text = [contactArr objectAtIndex:indexPath.row - 1];
        cell.schoolLab.text = @"北京大学";
        
        if(indexPath.row == 0)
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        else
            [cell.contentView removeLines];
        
        return cell;
    }
    
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
    
    cell.selected = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MemberChoiseCellRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        TTBMemberAllSelectCell *cell = (TTBMemberAllSelectCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
        
        if(selectedArr.count == contactArr.count)
        {
            [selectedArr removeAllObjects];
            [cell setCusSelected:NO];
            
            for(int i = 0;i<contactArr.count;++i)
            {
                TTBMemberChoiseCell *choiseCell = (TTBMemberChoiseCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 inSection:0]];
                [choiseCell setCusSelected:NO];
            }
            
        }
        else
        {
            [selectedArr removeAllObjects];
            selectedArr = [[NSMutableArray alloc]initWithArray:contactArr];
            [cell setCusSelected:YES];
            
            for(int i = 0;i<contactArr.count;++i)
            {
                TTBMemberChoiseCell *choiseCell = (TTBMemberChoiseCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i + 1 inSection:0]];
                [choiseCell setCusSelected:YES];
            }
        }
    }
    else
    {
        TTBMemberChoiseCell *cell = (TTBMemberChoiseCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
        if([selectedArr containsObject:[contactArr objectAtIndex:indexPath.row - 1]])
        {
            [selectedArr removeObject:[contactArr objectAtIndex:indexPath.row - 1]];
            [cell setCusSelected:NO];
            
            TTBMemberAllSelectCell *selectAllCell = (TTBMemberAllSelectCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [selectAllCell setCusSelected:NO];
        }
        else
        {
            [selectedArr addObject:[contactArr objectAtIndex:indexPath.row - 1]];
            [cell setCusSelected:YES];
        }
    }
    
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
