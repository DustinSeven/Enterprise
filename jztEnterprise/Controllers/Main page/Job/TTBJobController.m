//
//  TTBJobController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobController.h"
#import "TTBJobViewIphone.h"
#import "TTBJobCell.h"
#import "TTBJobManageController.h"
#import "TTBReleaseJobController.h"

@interface TTBJobController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBJobViewBase *_baseView;
}

@end

@implementation TTBJobController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBJobViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"发布招募" target:self action:@selector(releaseJobBtnClicked) spacing:-15];
    }
}

- (void)releaseJobBtnClicked
{
    TTBReleaseJobController *releaseJobController = [[TTBReleaseJobController alloc]init];
    releaseJobController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:releaseJobController animated:YES];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JobCell";
    TTBJobCell *cell = (TTBJobCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBJobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.titleLab.text = @"杭州兼职兔招聘APP试玩人员（仔细阅读备注信息）";
    cell.jobImg.image = [UIImage imageNamed:@"work"];
  
    if(indexPath.row == 0)
    {
        [cell setJobProcess:JobProcess_AllSignIn];
        cell.processLab.text = @"20/20人";
    }
    if(indexPath.row == 1)
    {
        [cell setJobProcess:JobProcess_NotAllSignIn];
        cell.processLab.text = @"16/20人";
    }
    if(indexPath.row == 2)
    {
        [cell setJobProcess:JobProcess_Recruiting];
        cell.statusLab.text = @"64%";
        cell.processBar.process = 0.64;
    }
    if(indexPath.row == 3)
    {
        [cell setJobProcess:JobProcess_Checking];
    }
    if(indexPath.row == 4)
    {
        [cell setJobProcess:JobProcess_FailToChecking];
    }
    if(indexPath.row == 5)
    {
        [cell setJobProcess:JobProcess_Finished];
    }
    if(indexPath.row == 6)
    {
        [cell setJobProcess:JobProcess_WaitToFinish];
    }
    
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [sectionsTitle objectAtIndex:section];
//}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return JobCellSectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JobCellSectionHeight)];
    view.backgroundColor = VIEW_BACKGROUND;
    [view addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [view addLineWithFrame:CGRectMake(0, JobCellSectionHeight - 0.5, SCREEN_WIDTH, 0.5)];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 0, SCREEN_WIDTH - 25, JobCellSectionHeight)];
    titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL + 2];
    titleLab.textColor = APP_FONT_COLOR_NORMAL;
    [view addSubview:titleLab];
    
    if(section == 0)
        titleLab.text = @"今日招募（2）";
    if(section == 1)
        titleLab.text = @"招募中（2）";
    if(section == 2)
        titleLab.text = @"审核中（2）";
    
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
    return JobCellHight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTBJobCell *cell = (TTBJobCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    TTBJobManageController *jobManageController = [[TTBJobManageController alloc]init];
    jobManageController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jobManageController animated:YES];
    
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
