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
#import "TTBMyJobParam.h"
#import "TTBUserEntity.h"
#import "TTBMainPageProcess.h"
#import "TTBMyJobListEntity.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface TTBJobController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBJobViewBase *_baseView;
    TTBMyJobParam *param;
    TTBUserEntity *userEntiry;
    
    NSMutableArray *jobList;
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
        
        userEntiry = [TTBUtility readUserDefaults:USER_DEFAULT_ENTITY_KEY];
        param = [[TTBMyJobParam alloc]init];
        param.pageSize = 8;
        param.page = 1;
        param.enterId = userEntiry.identity;
        
        jobList = [NSMutableArray array];
        
        [_baseView.baseTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerUpdate)];
        [_baseView.baseTableView.header setTitle:@"" forState:MJRefreshHeaderStateIdle];
        [_baseView.baseTableView.header setTitle:@"释放刷新" forState:MJRefreshHeaderStatePulling];
        [_baseView.baseTableView.header setTitle:@"正在刷新" forState:MJRefreshHeaderStateRefreshing];
        
        [_baseView.baseTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerUpdate)];
        [_baseView.baseTableView.footer setTitle:@"" forState:MJRefreshFooterStateIdle];
        [_baseView.baseTableView.footer setTitle:@"没有更多数据" forState:MJRefreshFooterStateNoMoreData];
        [_baseView.baseTableView.footer setTitle:@"正在刷新" forState:MJRefreshFooterStateRefreshing];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    param.page = 1;
    [_baseView.baseTableView.footer resetNoMoreData];
    
    [[TTBMainPageProcess shareInstance]getMyJobWithParam:[param getDictionary] ParentView:nil progressText:@"获取中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        if(code == 200)
        {
            [jobList removeAllObjects];
            NSArray *jobArr = [responseObject objectForKey:@"data"];
            for(int i = 0;i<jobArr.count;++i)
            {
                TTBMyJobListEntity *entity = [[TTBMyJobListEntity alloc]initWithAttributes:[jobArr objectAtIndex:i]];
                [jobList addObject:entity];
            }
            
            [_baseView.baseTableView reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络故障!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
}

- (void)releaseJobBtnClicked
{
    TTBReleaseJobController *releaseJobController = [[TTBReleaseJobController alloc]init];
    releaseJobController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:releaseJobController animated:YES];
}

#pragma -mark 下拉刷新
- (void)headerUpdate
{
    param.page = 1;
    
    [[TTBMainPageProcess shareInstance]getMyJobWithParam:[param getDictionary] ParentView:nil progressText:@"获取中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        if(code == 200)
        {
            [jobList removeAllObjects];
            NSArray *jobArr = [responseObject objectForKey:@"data"];
            for(int i = 0;i<jobArr.count;++i)
            {
                TTBMyJobListEntity *entity = [[TTBMyJobListEntity alloc]initWithAttributes:[jobArr objectAtIndex:i]];
                [jobList addObject:entity];
            }
            
            [_baseView.baseTableView reloadData];
            [_baseView.baseTableView.header endRefreshing];
            if (param.pageSize == jobArr.count)
            {
                [_baseView.baseTableView.footer resetNoMoreData];
            }
            else
            {
                [_baseView.baseTableView.footer noticeNoMoreData];
            }
        }
        else
        {
            [_baseView.baseTableView.header endRefreshing];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_baseView.baseTableView.header endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络故障!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];

}

#pragma -mark 上拉加载
- (void)footerUpdate
{
    param.page++;
    
    [[TTBMainPageProcess shareInstance]getMyJobWithParam:[param getDictionary] ParentView:nil progressText:@"获取中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int code = [[responseObject objectForKey:@"code"] intValue];
        if(code == 200)
        {
            NSArray *jobArr = [responseObject objectForKey:@"data"];
            for(int i = 0;i<jobArr.count;++i)
            {
                TTBMyJobListEntity *entity = [[TTBMyJobListEntity alloc]initWithAttributes:[jobArr objectAtIndex:i]];
                [jobList addObject:entity];
            }
            
            [_baseView.baseTableView reloadData];
            [_baseView.baseTableView.footer endRefreshing];
            
            if (param.pageSize == jobArr.count)
            {
                [_baseView.baseTableView.footer resetNoMoreData];
            }
            else
            {
                [_baseView.baseTableView.footer noticeNoMoreData];
            }
        }
        else
        {
            [_baseView.baseTableView.footer endRefreshing];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_baseView.baseTableView.footer endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络故障!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jobList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JobCell";
    TTBJobCell *cell = (TTBJobCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBJobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    TTBMyJobListEntity *entity = (TTBMyJobListEntity *)[jobList objectAtIndex:indexPath.row];
    
    cell.titleLab.text = [NSString stringWithFormat:@"%@ - %@ (%@)",entity.title,entity.jobType,entity.workTimeType == 1?@"长期":@"短期"];
    cell.jobImg.image = [UIImage imageNamed:@"work"];
    [cell.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASE_URL,entity.logo]] placeholderImage:[TTBUtility getDefaultImgWithSize:CGSizeMake(JobCellJobImgWidth, JobCellJobImgHeight)] options:SDWebImageRefreshCached];
    cell.processLab.text = [NSString stringWithFormat:@"%d/%d人",entity.num - entity.remaining,entity.num];
    cell.statusLab.text = [NSString stringWithFormat:@"报名截止：%@",entity.deadline];
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [sectionsTitle objectAtIndex:section];
//}

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
    
    TTBMyJobListEntity *entity = (TTBMyJobListEntity *)[jobList objectAtIndex:indexPath.row];
    
    TTBJobManageController *jobManageController = [[TTBJobManageController alloc]init];
    jobManageController.identity = entity.identity;
    jobManageController.isLong = entity.workTimeType == 1?YES:NO;
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
