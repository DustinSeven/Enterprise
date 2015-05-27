

//
//  TTBEditWorkerNumController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBEditWorkerNumController.h"
#import "TTBEditWorkerNumViewIphone.h"
#import "TTBEditWorkerNumCell.h"
#import "TTBJobManagerProcess.h"
#import "TTBMyShortJobDateEntity.h"

@interface TTBEditWorkerNumController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    TTBEditWorkerNumViewBase *_baseView;
    NSMutableDictionary *param;
}

@end

@implementation TTBEditWorkerNumController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBEditWorkerNumViewIphone alloc]init];
        self.view = _baseView;
        
        _baseView.baseTableView.dataSource = self;
        _baseView.baseTableView.delegate = self;
        
        [_baseView.submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.title = @"修改人数";
        
        param = [[NSMutableDictionary alloc]init];
        [param setValue:_identity forKey:@"jobid"];
        
        
        if(!_isLong)
            _remaining = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if(!_isLong)
//    {
//        NSMutableDictionary *shortParam = [[NSMutableDictionary alloc]init];
//        [shortParam setValue:_identity forKey:@"jobid"];
//        
//        [[TTBJobManagerProcess shareInstance]getMyJobDateWithParam:shortParam ParentView:nil progressText:@"获取中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            int code = [[responseObject objectForKey:@"code"] intValue];
//            if(code == 200)
//            {
//                NSArray *arr = [responseObject objectForKey:@"data"];
//                for(int i = 0;i<arr.count;++i)
//                {
//                    TTBMyShortJobDateEntity *entity = [[TTBMyShortJobDateEntity alloc]initWithAttributes:[arr objectAtIndex:i]];
//                    [dateArr addObject:entity];
//                }
//                
//                [_baseView.baseTableView reloadData];
//            }
//            else
//            {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//            }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络连接超时!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }];
//    }
}

#pragma -mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark 提交按钮事件
- (void)submitBtnClicked:(UIButton *)button
{
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [param setValue:[NSString stringWithFormat:@"%d",_num + cell.changedValue] forKey:@"num"];
        
    [[TTBJobManagerProcess shareInstance]updateWorkerNumWithParam:param ParentView:nil progressText:@"修改中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"修改成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络连接超时!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EditWorkerNumCell";
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBEditWorkerNumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    float sliderValue;
    
    if(_isLong)
    {
        cell.dateLab.text = @"长期兼职：";
        
        
    }
    else
    {
        cell.dateLab.text = @"短期兼职：";
    }
    
    cell.numOrgLab.text = [NSString stringWithFormat:@"%d人",_num];
    
    cell.minNumLab.text = [NSString stringWithFormat:@"%d",_num - _remaining];
    cell.maxNumLab.text = [NSString stringWithFormat:@"%d",2 * _num];
    
    sliderValue = (float)(_num + cell.changedValue - (_num - _remaining)) / (_num * 2 - (_num - _remaining));
    
    CGSize numOrgLabSize = [cell.numOrgLab sizeThatFits:CGSizeMake(CGFLOAT_MIN, EditWorkerNumCellHeight / 2)];
    cell.numOrgLab.frame = CGRectMake(CGRectGetMaxX(cell.workerImg.frame) + 5, 0, numOrgLabSize.width, EditWorkerNumCellHeight / 2);
    
    NSString *mark;
    if(sliderValue >= 0)
        mark = @"+";
    else
        mark = @"-";
    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%d人",mark,abs(cell.changedValue)]];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
    cell.numChangedLab.frame = CGRectMake(CGRectGetMaxX(cell.numOrgLab.frame), 0, (SCREEN_WIDTH - CGRectGetMaxX(cell.numOrgLab.frame) - 12.5), EditWorkerNumCellHeight / 2);
    cell.baseSlider.value = sliderValue;
    
    
    cell.baseSlider.tag = 1000 + indexPath.row;
    [cell.baseSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [cell.addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag = 2000 + indexPath.row;
    [cell.reduceBtn addTarget:self action:@selector(reduceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.reduceBtn.tag = 3000 + indexPath.row;
    
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
    return EditWorkerNumCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}

#pragma mark - addBtnClicked
-(void)addBtnClicked:(UIButton *)button
{
    int index = (int)button.tag - 2000;
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    int sliderValue;
    int num;
    
    sliderValue = cell.changedValue + _num;
    num = _num;

    
    if(sliderValue < 2 * num)
    {
        sliderValue++;
        cell.changedValue++;
    }
    NSString *mark;
    if(sliderValue >= num)
        mark = @"+";
    else
        mark = @"-";
    
    cell.baseSlider.value = (float)(_num + cell.changedValue - (_num - _remaining)) / (_num * 2 - (_num - _remaining));

    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%d人",mark,abs(cell.changedValue)]];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
}

#pragma mark - reduceBtnClicked
-(void)reduceBtnClicked:(UIButton *)button
{
    int index = (int)button.tag - 3000;
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    int sliderValue;
    int num;

    sliderValue = cell.changedValue + _num;
    num = _num;
    
    if(sliderValue > (_num - _remaining))
    {
        sliderValue--;
        cell.changedValue--;
    }
    
    
    NSString *mark;
    if(sliderValue >= num)
        mark = @"+";
    else
        mark = @"-";

    cell.baseSlider.value = (float)(_num + cell.changedValue - (_num - _remaining)) / (_num * 2 - (_num - _remaining));

    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%d人",mark,abs(cell.changedValue)]];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
}

#pragma mark - sliderValueChange
- (void)sliderValueChange:(UISlider *)slider
{
    int index = (int)slider.tag - 1000;
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    int sliderValue;

    sliderValue = (int)(cell.baseSlider.value * (2 * _num - (_num - _remaining)) + (_num - _remaining) - _num);
    cell.changedValue = sliderValue;
    
    
    NSString *mark;
    if(sliderValue >= 0)
        mark = @"+";
    else
        mark = @"-";
    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%d人",mark,abs(sliderValue)]];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
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
