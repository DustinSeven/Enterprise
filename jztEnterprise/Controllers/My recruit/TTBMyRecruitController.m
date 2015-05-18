//
//  TTBMyRecruitController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMyRecruitController.h"
#import "TTBReleaseJobController.h"
#import "TTBJobManageController.h"

@interface TTBMyRecruitController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBMyRecruitViewBase *_baseView;
}

@end

@implementation TTBMyRecruitController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"我的招募";
        
        _baseView = [[TTBMyRecruitViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"发布招募" target:self action:@selector(releaseJobBtnClicked) spacing:-15];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)releaseJobBtnClicked
{
    TTBReleaseJobController *releaseJobController = [[TTBReleaseJobController alloc]init];
    [self.navigationController pushViewController:releaseJobController animated:YES];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
    
//    [cell.contentView removeLines];
    
    if(indexPath.row == 0)
        [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    
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
