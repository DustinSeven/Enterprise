//
//  TTBSettingController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSettingController.h"
#import "TTBChangePwdController.h"
#import "TTBAdviceController.h"

@interface TTBSettingController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBSettingViewBase *_baseView;
}

@end

@implementation TTBSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        self.title = @"设置";
        
        _baseView = [[TTBSettingViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        [_baseView.logoutBtn addTarget:self action:@selector(logoutBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma -mark 登出按钮事件
- (void)logoutBtnClicked:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogOut" object:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingListCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, SettingListCellHeight - 0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = SettingListSeparatorColor;
    [cell.contentView addSubview:line];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改密码";
            break;
        case 1:
            cell.textLabel.text = @"关于我们";
            break;
        case 2:
            cell.textLabel.text = @"意见反馈";
            break;
        case 3:
            cell.textLabel.text = @"版本更新";
            break;
        case 4:
            cell.textLabel.text = @"条款申明";
            break;
        default:
            break;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
    cell.textLabel.textColor = APP_FONT_COLOR_NORMAL;
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SettingListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if(indexPath.row == 0)
    {
        TTBChangePwdController *changePwdController = [[TTBChangePwdController alloc]init];
        [self.navigationController pushViewController:changePwdController animated:YES];
    }
    
    if(indexPath.row == 2)
    {
        TTBAdviceController *adviceController = [[TTBAdviceController alloc]init];
        [self.navigationController pushViewController:adviceController animated:YES];
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
