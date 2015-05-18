//
//  TTBMemberController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberController.h"
#import "TTBContactEntity.h"
#import "TTBMemberMenuCell.h"
#import "TTBSessionDetailController.h"

@interface TTBMemberController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
{
    TTBMemberViewBase *_baseView;
    
    NSIndexPath *currentOpenRow;
    
    NSMutableArray *contactArr;
    
    int currentMenuCellIndex;
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
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        currentOpenRow = nil;
        contactArr = [NSMutableArray array];
        
        [self initRootView];
        [self initSortArr];
        
        currentMenuCellIndex = -1;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self closeAllCell];
}

- (void)initSortArr
{
    NSArray *srcArray = @[@"林荣", @"林丹", @"周董", @"周树人", @"周杰伦", @"阿华", @"周董", @"周树人", @"周杰伦", @"阿华", @"周董", @"周树人", @"周杰伦", @"阿华", @"周董", @"周树人", @"周杰伦", @"阿华", @"周董", @"周树人", @"周杰伦", @"阿华", @"周董", @"周树人", @"周杰伦", @"阿华"];
    
    for (int i = 0;i<srcArray.count;++i)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        TTBContactEntity *contact = [[TTBContactEntity alloc]init];
        contact.name = [srcArray objectAtIndex:i];
        [dic setObject:contact forKey:@"member"];
        [dic setObject:@"MemberCell" forKey:@"CellType"];
        [contactArr addObject:dic];
    }
}

- (void)initRootView
{
    _baseView.jobTimeLab.text = @"12月12日";
    _baseView.processLab.text = @"13/20人";
}

- (void)closeAllCell
{
    if(currentOpenRow)
    {
        SWTableViewCell *cell = (SWTableViewCell *)[_baseView.baseTableView cellForRowAtIndexPath:currentOpenRow];
        [cell hideUtilityButtonsAnimated:YES];
        
        currentOpenRow = nil;
    }
}

#pragma mark - sessionBtnClicked
- (void)sessionBtnClicked:(UIButton *)button
{
    TTBSessionDetailController *sessionDetailController = [[TTBSessionDetailController alloc]init];
    [self.navigationController pushViewController:sessionDetailController animated:YES];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contactArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType = [[contactArr objectAtIndex:indexPath.row] objectForKey:@"CellType"];
    
    if([cellType isEqualToString:@"MemberCell"])
    {
        static NSString *cellIdentifier = @"MemberCell";
        TTBMemberCell *cell = (TTBMemberCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[TTBMemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.rightUtilityButtons = [self rightButtons];
            cell.delegate = self;
        }
        
        TTBContactEntity *entity = (TTBContactEntity *)[[contactArr objectAtIndex:indexPath.row] objectForKey:@"member"];
        cell.userImg.image = [UIImage imageNamed:@"user_img_default_120px"];
        NSMutableAttributedString *nameAttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(未签到)",entity.name]];
        NSRange range = NSMakeRange(nameAttr.string.length - 5, 5);
        [nameAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [nameAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:APP_FONT_SIZE_SMALL] range:range];
        cell.userNameLab.attributedText = nameAttr;
        cell.schoolLab.text = @"北京大学";
        [cell setGenderIconWithNum:2];
        
        if(indexPath.row == 0)
            [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        else
            [cell.contentView removeLines];
            
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"MemberMenuCell";
        TTBMemberMenuCell *cell = (TTBMemberMenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[TTBMemberMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [cell.sessionBtn addTarget:self action:@selector(sessionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
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
    NSString *cellType = [[contactArr objectAtIndex:indexPath.row] objectForKey:@"CellType"];
    
    if([cellType isEqualToString:@"MemberCell"])
        return ContactCellRowHeight;
    return MemberMenuCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType = [[contactArr objectAtIndex:indexPath.row] objectForKey:@"CellType"];
    
    if([cellType isEqualToString:@"MemberCell"])
    {
        TTBMemberCell *cell = (TTBMemberCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
        [self closeAllCell];
        
        if(currentMenuCellIndex == -1)
        {
            currentMenuCellIndex = (int)indexPath.row;
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:@"MemberMenuCell" forKey:@"CellType"];
            [contactArr insertObject:dic atIndex:indexPath.row + 1];
            
            NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
            [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
            [cell revolveTipImg];
        }
        else if(currentMenuCellIndex != indexPath.row)
        {
            TTBMemberCell *tmpCell = (TTBMemberCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentMenuCellIndex inSection:0]];
            [tmpCell revolveTipImg];
            [contactArr removeObjectAtIndex:currentMenuCellIndex + 1];
            NSIndexPath *path = [NSIndexPath indexPathForRow:currentMenuCellIndex + 1 inSection:0];
            [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
            
            int indexToInsert;
            if(indexPath.row > currentMenuCellIndex)
                indexToInsert = (int)indexPath.row - 1;
            else
                indexToInsert = (int)indexPath.row;
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:@"MemberMenuCell" forKey:@"CellType"];
            [contactArr insertObject:dic atIndex:indexToInsert + 1];
            
            NSIndexPath *openPath = [NSIndexPath indexPathForRow:indexToInsert + 1 inSection:0];
            [tableView insertRowsAtIndexPaths:@[openPath] withRowAnimation:UITableViewRowAnimationTop];
            [cell revolveTipImg];
            currentMenuCellIndex = indexToInsert;
        }
        else
        {
            TTBMemberCell *tmpCell = (TTBMemberCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentMenuCellIndex inSection:0]];
            [tmpCell revolveTipImg];
            [contactArr removeObjectAtIndex:currentMenuCellIndex + 1];
            NSIndexPath *path = [NSIndexPath indexPathForRow:currentMenuCellIndex + 1 inSection:0];
            [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
            currentMenuCellIndex = -1;
        }

    }
    
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
    NSIndexPath *row = [_baseView.baseTableView indexPathForCell:cell];
    switch (state) {
        case 0:
        {
            NSLog(@"utility buttons closed");
            if(currentOpenRow)
            {
                if(row.row == currentOpenRow.row && row.section == currentOpenRow.section)
                {
                    currentOpenRow = nil;
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
    switch (index) {
        case 0:
        {
            //            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"删除" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            //            [alertTest show];
            
            //            NSIndexPath *cellIndexPath = [_baseView.baseTableView indexPathForCell:cell];
            //            [arr removeObjectAtIndex:cellIndexPath.row];
            //            [_baseView.baseTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            //
            //            [cell hideUtilityButtonsAnimated:YES];
            
            currentOpenRow = nil;
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
