//
//  TTBChangePwdController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChangePwdController.h"
#import "TTBChangePwdViewIphone.h"

@interface TTBChangePwdController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBChangePwdViewBase *_baseView;
    
    UITapGestureRecognizer *mainTap;
}

@end

@implementation TTBChangePwdController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBChangePwdViewIphone alloc]init];
        self.view = _baseView;
        
        mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewTaped:)];
        [_baseView addGestureRecognizer:mainTap];
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
    }
}

- (void)mainViewTaped:(UITapGestureRecognizer *)tap
{
    for(int i = 0;i<3;++i)
    {
        TTBChangePwdCell *cell = (TTBChangePwdCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.contentText resignFirstResponder];
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ChangePwdCell";
    TTBChangePwdCell *cell = (TTBChangePwdCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBChangePwdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row == 0)
    {
        cell.contentText.placeholder = @"旧密码";
        cell.contentText.secureTextEntry = NO;
        [cell.contentView addLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    }
    
    if(indexPath.row == 1)
    {
        cell.contentText.placeholder = @"新密码";
        cell.contentText.secureTextEntry = YES;
    }
    
    if(indexPath.row == 2)
    {
        cell.contentText.placeholder = @"再次输入新密码";
        cell.contentText.secureTextEntry = YES;
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ChangePwdCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTBChangePwdCell *cell = (TTBChangePwdCell *)[_baseView.baseTableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    [self mainViewTaped:nil];
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
