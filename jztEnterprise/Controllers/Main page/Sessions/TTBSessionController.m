//
//  TTBSessionController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/6.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "TTBSessionController.h"
#import "TTBSessionCell.h"
#import "TTBSessionDetailController.h"

@interface TTBSessionController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
{
    TTBSessionViewBase *_baseView;
    
    NSMutableArray *sessionArr;
    
    int currentOpenRow;
    
//    NSMutableDictionary *deleteDic;
}

@end

@implementation TTBSessionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBSessionViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        sessionArr = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",nil];
        
        currentOpenRow = -1;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _baseView.baseTableView.editing = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [deleteDic removeAllObjects];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self closeAllCell];
}

- (void)closeAllCell
{
    if(currentOpenRow != -1)
    {
        SWTableViewCell *cell = (SWTableViewCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentOpenRow inSection:0]];
        [cell hideUtilityButtonsAnimated:NO];
        
        currentOpenRow = -1;
        
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sessionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SessionCell";
    TTBSessionCell *cell = (TTBSessionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBSessionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
        
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
    
    cell.tag = (indexPath.row + 1) * 1000;
    
    cell.userImg.image = [TTBUtility combineImgs:[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"chat_send_nor"],[UIImage imageNamed:@"chat_send_nor"],[UIImage imageNamed:@"chat_send_nor"],[UIImage imageNamed:@"chat_send_nor"], nil]];
    cell.userNameLab.text = @"李明伟";
    cell.descriptionLab.text = @"明天准时签到!";
    cell.timeLab.text = @"2014-12-12";
    
    if(indexPath.row == 0)
        [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    else
        [cell.contentView removeLines];
    

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
    
    cell.selected = NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SessionCellRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTBSessionCell *cell = (TTBSessionCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    TTBSessionDetailController *sessionDetailController = [[TTBSessionDetailController alloc]init];
    sessionDetailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sessionDetailController animated:YES];

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    btn.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];
    [btn setImage:[UIImage imageNamed:@"session_delete_btn_icon_normal"] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    int row = (int)[_baseView.baseTableView indexPathForCell:cell].row;
    switch (state) {
        case 0:
        {
            NSLog(@"utility buttons closed");
            if(row == currentOpenRow)
            {
                currentOpenRow = -1;
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
    switch (index) {
        case 0:
        {
            
            NSIndexPath *cellIndexPath = [_baseView.baseTableView indexPathForCell:cell];
            [sessionArr removeObjectAtIndex:cellIndexPath.row];
            [_baseView.baseTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            [cell hideUtilityButtonsAnimated:YES];
             currentOpenRow = -1;
            break;
        }
        default:
            break;
    }
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
