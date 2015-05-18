//
//  TTBUserCenterController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserCenterController.h"
#import "TTBUserCenterViewIphone.h"
#import "TTBMyRecruitController.h"
#import "TTBSettingController.h"
#import "TTBUserCenterCell.h"
#import "TTBReleaseJobController.h"
#import "TTBUserInfoViewController.h"

@interface TTBUserCenterController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBUserCenterViewBase *_baseView;
    
}

@end

@implementation TTBUserCenterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBUserCenterViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.menuTableView.dataSource = self;
        _baseView.menuTableView.delegate = self;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"发布招募" target:self action:@selector(releaseJobBtnClicked) spacing:-15];
    
    _baseView.enterImg.image = [UIImage imageNamed:@"user_img_default_120px"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImgTapped:)];
    [_baseView.enterImg addGestureRecognizer:tap];
    
    _baseView.enterName.text = @"中国移动通信";
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)releaseJobBtnClicked
{
    TTBReleaseJobController *releaseJobController = [[TTBReleaseJobController alloc]init];
    releaseJobController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:releaseJobController animated:YES];
}

#pragma 头像点击事件
- (void)userImgTapped:(UITapGestureRecognizer *)tap
{
    TTBUserInfoViewController *userInfoController = [[TTBUserInfoViewController alloc]init];
    userInfoController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoController animated:YES];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UserCenterCell";
    TTBUserCenterCell *cell = (TTBUserCenterCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBUserCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        cell.iconImg.image = [UIImage imageNamed:@"user_center_my_recruit_icon"];
        cell.contentLab.text = @"我的招募";
    }
    
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        cell.iconImg.image = [UIImage imageNamed:@"user_center_setting_icon"];
        cell.contentLab.text = @"设置";
    }
    
    CGSize size = [cell.contentLab sizeThatFits:CGSizeMake(0, UserCenterCellHeight)];
    cell.contentLab.frame = CGRectMake(CGRectGetMaxX(cell.iconImg.frame) + 10, 10, size.width + 10, UserCenterCellHeight - 20);
    
    [cell.contentLab addNewInfoMarkPoint];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
        return MenuTitleViewHeight;
    else
        return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MenuTitleViewHeight)];
    backView.backgroundColor = VIEW_BACKGROUND;
    
    UIView *upLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    upLine.backgroundColor = SeparatorColor;
    [backView addSubview:upLine];
    
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, MenuTitleViewHeight - 0.5, SCREEN_WIDTH, 0.5)];
    downLine.backgroundColor = SeparatorColor;
    [backView addSubview:downLine];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UserCenterCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTBUserCenterCell *cell = (TTBUserCenterCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        TTBMyRecruitController *myRecruitController = [[TTBMyRecruitController alloc]init];
        myRecruitController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myRecruitController animated:YES];
    }
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        TTBSettingController *settingController = [[TTBSettingController alloc]init];
        settingController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingController animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
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
