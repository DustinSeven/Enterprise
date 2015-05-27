//
//  TTBMemberController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberController.h"
#import "TTBContactEntity.h"
#import "TTBSessionDetailController.h"
#import "TTBJobManagerProcess.h"
#import "MJRefresh.h"
#import "TTBMemberEntity.h"
#import "UIImageView+WebCache.h"

@interface TTBMemberController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
{
    TTBMemberViewBase *_baseView;
    
    NSIndexPath *currentOpenRow;
    
    NSMutableArray *users;
    NSMutableArray *dates;
    
    BOOL isDelete;
}

@end

@implementation TTBMemberController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBMemberViewIphone alloc]init];
        self.view = _baseView;
        
        users = [NSMutableArray array];
        dates = [NSMutableArray array];
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        currentOpenRow = nil;
        
        [_baseView.baseTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerUpdate)];
        [_baseView.baseTableView.header setTitle:@"" forState:MJRefreshHeaderStateIdle];
        [_baseView.baseTableView.header setTitle:@"释放刷新" forState:MJRefreshHeaderStatePulling];
        [_baseView.baseTableView.header setTitle:@"正在刷新" forState:MJRefreshHeaderStateRefreshing];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadUser];
    [self closeAllCell];
}

- (void)loadUser
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:_identity forKey:@"jobId"];
    [[TTBJobManagerProcess shareInstance]getUsrJobWithParam:param ParentView:nil progressText:@"获取中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int code = [[responseObject objectForKey:@"code"]intValue];
        if(code == 200)
        {
            [users removeAllObjects];
            if(_isLong)
            {
                NSArray *arr = [responseObject objectForKey:@"data"];
                for(int i=0;i<arr.count;++i)
                {
                    TTBMemberEntity *entity = [[TTBMemberEntity alloc]initWithAttributes:[arr objectAtIndex:i]];
                    [users addObject:entity];
                }
            }
            else
            {
                NSArray *arr = [responseObject objectForKey:@"data"];
                for(int i=0;i<arr.count;++i)
                {
                    NSArray *list = [[arr objectAtIndex:i] objectForKey:@"userjobs"];
                    NSMutableArray *subList = [NSMutableArray array];
                    for(int j = 0;j<list.count;++j)
                    {
                        TTBMemberEntity *entity = [[TTBMemberEntity alloc]initWithAttributes:[list objectAtIndex:j]];
                        [subList addObject:entity];
                    }
                    [users addObject:subList];
                    [dates addObject:[[arr objectAtIndex:i] objectForKey:@"date"]];
                }
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        [_baseView.baseTableView.header endRefreshing];
        [_baseView.baseTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络连接超时！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
}

- (void)headerUpdate
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:_identity forKey:@"jobId"];
    [[TTBJobManagerProcess shareInstance]getUsrJobWithParam:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int code = [[responseObject objectForKey:@"code"]intValue];
        if(code == 200)
        {
            [users removeAllObjects];
            if(_isLong)
            {
                NSArray *arr = [responseObject objectForKey:@"data"];
                for(int i=0;i<arr.count;++i)
                {
                    TTBMemberEntity *entity = [[TTBMemberEntity alloc]initWithAttributes:[arr objectAtIndex:i]];
                    [users addObject:entity];
                }
                
            }
            else
            {
                NSArray *arr = [responseObject objectForKey:@"data"];
                for(int i=0;i<arr.count;++i)
                {
                    NSArray *list = [[arr objectAtIndex:i] objectForKey:@"userjobs"];
                    NSMutableArray *subList = [NSMutableArray array];
                    for(int j = 0;j<list.count;++j)
                    {
                        TTBMemberEntity *entity = [[TTBMemberEntity alloc]initWithAttributes:[list objectAtIndex:j]];
                        [subList addObject:entity];
                    }
                    [users addObject:subList];
                    [dates addObject:[[arr objectAtIndex:i] objectForKey:@"date"]];
                }
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }

        [_baseView.baseTableView.header endRefreshing];
        [_baseView.baseTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络连接超时！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
}


- (void)closeAllCell
{
    if(currentOpenRow)
    {
        SWTableViewCell *cell = (SWTableViewCell *)[_baseView.baseTableView cellForRowAtIndexPath:currentOpenRow];
        [cell hideUtilityButtonsAnimated:YES];
    }
}

#pragma mark - sessionBtnClicked
- (void)sessionBtnClicked:(UIButton *)button
{
    TTBSessionDetailController *sessionDetailController = [[TTBSessionDetailController alloc]init];
    [self.navigationController pushViewController:sessionDetailController animated:YES];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_isLong)
        return 1;
    return users.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isLong)
        return users.count;
    NSMutableArray *arr = [users objectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MemberCell";
    TTBMemberCell *cell = (TTBMemberCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBMemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    TTBMemberEntity *entity;
    if(_isLong)
        entity = [users objectAtIndex:indexPath.row];
    else
        entity = [[users objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASE_URL,entity.img]] placeholderImage:[TTBUtility getDefaultImgWithSize:CGSizeMake(ContactCellUserImgWidth, ContactCellUserImgWidth)] options:SDWebImageRefreshCached];
    NSMutableAttributedString *nameAttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(未签到)",entity.name]];
    NSRange range = NSMakeRange(nameAttr.string.length - 5, 5);
    [nameAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [nameAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_SMALL] range:range];
    cell.userNameLab.attributedText = nameAttr;
    cell.schoolLab.text = entity.school;
    [cell setGenderIconWithNum:entity.sex];
    
    if(indexPath.row == 0)
        [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    else
        [cell.contentView removeLines];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(-1, 0, SCREEN_WIDTH + 2, 30)];
    lab.layer.borderWidth = 0.5;
    lab.layer.borderColor = [UIColor whiteColor].CGColor;
    lab.backgroundColor = [UIColor colorWithRed:68.0f / 255.0f green:68.0f / 255.0f blue:68.0f / 255.0f alpha:1.0f];
    lab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    lab.textColor = [UIColor whiteColor];
    if(_isLong)
        lab.text = @"  长期兼职";
    else
    {
        NSMutableArray *arr = [users objectAtIndex:section];
        lab.text = [NSString stringWithFormat:@"  %@(%lu)",[dates objectAtIndex:section],(unsigned long)arr.count];
    }
    return lab;
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
    
    cell.selected = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ContactCellRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TTBMemberCell *cell = (TTBMemberCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    [self closeAllCell];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 50, 50);
    btn1.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];
    [btn1 setImage:[UIImage imageNamed:@"member_menu_phone_btn_icon"] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 50, 50);
    btn2.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];
    [btn2 setImage:[UIImage imageNamed:@"member_menu_sign_in_btn_icon_normal"] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn2];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.frame = CGRectMake(0, 0, 50, 50);
    btn0.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];
    [btn0 setImage:[UIImage imageNamed:@"session_delete_btn_icon_normal"] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn0];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    NSIndexPath *row = [_baseView.baseTableView indexPathForCell:cell];
    switch (state) {
        case 0:
        {
            NSLog(@"utility buttons closed");
            if(currentOpenRow)
            {
                if(row.row == currentOpenRow.row && row.section == currentOpenRow.section)
                {
                    if(!isDelete)
                        currentOpenRow = nil;
                    isDelete = NO;
                }
            }
        }
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
        {
            NSLog(@"right utility buttons open");
            currentOpenRow = row;
        }
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    TTBMemberEntity *entity;
    if(_isLong)
        entity = [users objectAtIndex:currentOpenRow.row];
    else
        entity = [[users objectAtIndex:currentOpenRow.section] objectAtIndex:currentOpenRow.row];
    
    switch (index) {
        case 0:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",entity.mobile]]];
            currentOpenRow = nil;
        }
            break;
        case 1:
        {
            currentOpenRow = nil;
        }
            break;
        case 2:
        {
            isDelete = YES;
            
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            [param setValue:_identity forKey:@"jobid"];
            [param setValue:entity.userJobId forKey:@"userjobid"];
            
            [[TTBJobManagerProcess shareInstance]deleteUsrJobWithParam:param ParentView:nil progressText:@"删除中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if(_isLong)
                    [users removeObjectAtIndex:currentOpenRow.row];
                else
                    [[users objectAtIndex:currentOpenRow.section] removeObjectAtIndex:currentOpenRow.row];
                
                [_baseView.baseTableView deleteRowsAtIndexPaths:@[currentOpenRow] withRowAnimation:UITableViewRowAnimationLeft];
                
                currentOpenRow = nil;
                
                [_baseView.baseTableView reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
            break;
        default:
            break;
    }
    
    [self closeAllCell];
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
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
