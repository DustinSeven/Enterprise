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

@interface TTBEditWorkerNumController ()<UITableViewDataSource,UITableViewDelegate>
{
    TTBEditWorkerNumViewBase *_baseView;
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
        
        self.title = @"修改人数";
    }
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EditWorkerNumCell";
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[TTBEditWorkerNumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dateLab.text = @"12月12日：";
    
    cell.numOrgLab.text = @"20人";
    CGSize numOrgLabSize = [cell.numOrgLab sizeThatFits:CGSizeMake(CGFLOAT_MIN, EditWorkerNumCellHeight / 2)];
    cell.numOrgLab.frame = CGRectMake(CGRectGetMaxX(cell.workerImg.frame) + 5, 0, numOrgLabSize.width, EditWorkerNumCellHeight / 2);
    
    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:@"+0人"];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
    cell.numChangedLab.frame = CGRectMake(CGRectGetMaxX(cell.numOrgLab.frame), 0, (SCREEN_WIDTH - CGRectGetMaxX(cell.numOrgLab.frame) - 12.5), EditWorkerNumCellHeight / 2);
    
    cell.minNumLab.text = @"16";
    cell.maxNumLab.text = @"40";
    
    float sliderValue = (20.0 - 16.0) / (40.0 - 16.0);
    
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
    
    int sliderValue = (int)(cell.baseSlider.value * (40 - 16) + 16);
    if(sliderValue < 2 * 20)
        sliderValue++;
    NSString *mark;
    if(sliderValue >= 20)
        mark = @"+";
    else
        mark = @"-";
    cell.baseSlider.value = (sliderValue - 16.0) / (40.0 - 16.0);
    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%d人",mark,abs(sliderValue - 20)]];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
}

#pragma mark - reduceBtnClicked
-(void)reduceBtnClicked:(UIButton *)button
{
    int index = (int)button.tag - 3000;
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    int sliderValue = (int)(cell.baseSlider.value * (40 - 16) + 16);
    if(sliderValue > 16)
        sliderValue--;
    NSString *mark;
    if(sliderValue >= 20)
        mark = @"+";
    else
        mark = @"-";
    cell.baseSlider.value = (sliderValue - 16.0) / (40.0 - 16.0);
    NSMutableAttributedString *changedNumStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%d人",mark,abs(sliderValue - 20)]];
    NSRange range = NSMakeRange(1, changedNumStr.length - 2);
    [changedNumStr addAttribute:NSForegroundColorAttributeName value:MainColorNormal range:range];
    cell.numChangedLab.attributedText = changedNumStr;
}

#pragma mark - sliderValueChange
- (void)sliderValueChange:(UISlider *)slider
{
    int index = (int)slider.tag - 1000;
    TTBEditWorkerNumCell *cell = (TTBEditWorkerNumCell *)[_baseView.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    int sliderValue = (int)(cell.baseSlider.value * (40 - 16) + 16 - 20);
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
