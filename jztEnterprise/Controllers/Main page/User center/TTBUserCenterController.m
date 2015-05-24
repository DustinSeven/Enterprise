//
//  TTBUserCenterController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserCenterController.h"
#import "TTBUserCenterViewIphone.h"
#import "TTBSettingController.h"
#import "TTBReleaseJobController.h"
#import "TTBUserEntity.h"
#import "TTBUploadUserImgParam.h"
#import "TTBUserCenterProcess.h"
#import "UIImageView+WebCache.h"
#import "TTBChangeInfoViewController.h"
#import "TTBChangeInfoParam.h"

@interface TTBUserCenterController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    TTBUserCenterViewBase *_baseView;
    
    TTBUserEntity *userEntity;
    
    UIImagePickerController *imgPicker;
    TTBChangeInfoParam *sexParam;
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
        
        imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;//设置可编辑
        imgPicker.videoQuality=UIImagePickerControllerQualityTypeLow;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    userEntity = [TTBUtility readUserDefaults:USER_DEFAULT_ENTITY_KEY];
    sexParam = [[TTBChangeInfoParam alloc]init];
    sexParam.identity = userEntity.identity;
    sexParam.mobile = userEntity.mobile;
    sexParam.pwd = userEntity.pwd;
    
    [_baseView.menuTableView reloadData];
    
    [_baseView.enterImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASE_URL,userEntity.img]] placeholderImage:[TTBUtility getDefaultImgWithSize:CGSizeMake(65, 65)] options:SDWebImageRefreshCached];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.rightBarButtonItems = [TTBUtility customBarButtonItemWithNormalImg:nil pressedImg:nil text:@"发布招募" target:self action:@selector(releaseJobBtnClicked) spacing:-15];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImgTapped:)];
    [_baseView.enterImg addGestureRecognizer:tap];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    if (image != nil)
    {
        TTBUploadUserImgParam *param = [[TTBUploadUserImgParam alloc]init];
        param.mobile = userEntity.mobile;
        param.password = userEntity.pwd;
        
        [[TTBUserCenterProcess shareInstance] uploadUserImgWithParam:[param getDictionary] ParentView:nil progressText:@"修改中..." img:[TTBUtility imageWithImage:image scaledToSize:CGSizeMake(400, 400)] success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             if([[responseObject objectForKey:@"code"]intValue] == 200)
             {
                 NSArray *data = [responseObject objectForKey:@"data"];
                 NSString *userImg = [[data objectAtIndex:0] objectForKey:@"userimage"];
                 if(userImg)
                 {
                     userEntity.img = userImg;
                     
                     [TTBUtility removeUserDefaults:USER_DEFAULT_ENTITY_KEY];
                     [TTBUtility saveUserDefaults:userEntity key:USER_DEFAULT_ENTITY_KEY];
                     userEntity = [TTBUtility readUserDefaults:USER_DEFAULT_ENTITY_KEY];
                     
//                     _baseView.enterImg.image = [TTBUtility getDefaultImgWithSize:CGSizeMake(65, 65)];
                     [_baseView.enterImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASE_URL,userEntity.img]] placeholderImage:[TTBUtility getDefaultImgWithSize:CGSizeMake(65, 65)] options:SDWebImageRefreshCached];
//                     [_baseView.baseTableView reloadData];
                 }
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"头像修改成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 [alert show];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 [alert show];
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误，请检查您的网络连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
             
         }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


#pragma -mark 头像点击事件
- (void)userImgTapped:(UITapGestureRecognizer *)tap
{
    UIActionSheet *activity = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    activity.tag = 100;
    [activity showInView:self.view];
}

#pragma -mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 100)
    {
        if(buttonIndex == 0)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imgPicker animated:YES completion:^{
                    
                }];
            }
        }
        
        if(buttonIndex == 1)
        {
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imgPicker animated:YES completion:^{
                
            }];
        }
    }
    else
    {
        if(buttonIndex == 0 || buttonIndex == 1)
        {
            sexParam.sex = [NSString stringWithFormat:@"%ld",buttonIndex + 1];
            [[TTBUserCenterProcess shareInstance]updateInfoWithParam:[sexParam getDictionary] parentView:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                int code = [[responseObject objectForKey:@"code"] intValue];
                if(code == 200)
                {
                    userEntity.sex = [NSString stringWithFormat:@"%ld",buttonIndex + 1];
                    
                    [TTBUtility removeUserDefaults:USER_DEFAULT_ENTITY_KEY];
                    [TTBUtility saveUserDefaults:userEntity key:USER_DEFAULT_ENTITY_KEY];
                    userEntity = [TTBUtility readUserDefaults:USER_DEFAULT_ENTITY_KEY];
                    [_baseView.menuTableView reloadData];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误，请检查您的网络连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }];
        }
        
    }
    
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UserCenterCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_name_icon"];
        if(userEntity.account)
        {
            cell.textLabel.text = userEntity.account;
            cell.textLabel.textColor = [UIColor blackColor];
//            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        }
        else
        {
            cell.textLabel.text = @"设置姓名";
            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
//            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
        }
    }
    
    if(indexPath.section == 0 && indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_company_icon"];
        if(userEntity.company)
        {
            cell.textLabel.text = userEntity.company;
            cell.textLabel.textColor = [UIColor blackColor];
//            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        }
        else
        {
            cell.textLabel.text = @"设置单位";
            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
//            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
        }
    }
    
    if(indexPath.section == 0 && indexPath.row == 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_phone_icon"];
        if(userEntity.mobile)
        {
            cell.textLabel.text = userEntity.mobile;
            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
            //            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        }
//        else
//        {
//            cell.textLabel.text = @"设置邮箱";
//            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
//            //            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
//        }
    }
    if(indexPath.section == 0 && indexPath.row == 3)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_gender_icon"];
        if([userEntity.sex isEqualToString:@"1"] || [userEntity.sex isEqualToString:@"2"])
        {
            if([userEntity.sex isEqualToString:@"1"])
                cell.textLabel.text = @"男";
            else if([userEntity.sex isEqualToString:@"2"])
                cell.textLabel.text = @"女";
            cell.textLabel.textColor = [UIColor blackColor];
            //            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        }
        else
        {
            cell.textLabel.text = @"设置性别";
            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
            //            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
        }
    }
    
    if(indexPath.section == 0 && indexPath.row == 4)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_email_icon"];
        if(userEntity.email)
        {
            cell.textLabel.text = userEntity.email;
            cell.textLabel.textColor = [UIColor blackColor];
            //            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        }
        else
        {
            cell.textLabel.text = @"设置邮箱";
            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
            //            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
        }
    }
    
    if(indexPath.section == 0 && indexPath.row == 5)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_qq_icon"];
        if(userEntity.qq)
        {
            cell.textLabel.text = userEntity.qq;
            cell.textLabel.textColor = [UIColor blackColor];
//            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        }
        else
        {
            cell.textLabel.text = @"设置QQ";
            cell.textLabel.textColor = APP_FONT_COLOR_THIN;
//            cell.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
        }
    }
    
//    if(indexPath.section == 0 && indexPath.row == 4)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"user_center_my_recruit_icon"];
//        cell.textLabel.text = @"我的招募";
//    }
    
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"user_center_setting_icon"];
        cell.textLabel.text = @"设置";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    CGSize size = [cell.textLabel sizeThatFits:CGSizeMake(0, UserCenterCellHeight)];
//    cell.textLabel.frame = CGRectMake(CGRectGetMaxX(cell.imageView.frame) + 10, 10, size.width + 10, UserCenterCellHeight - 20);
    
//    [cell.textLabel addNewInfoMarkPoint];
    
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
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    TTBChangeInfoViewController *changeInfoController = [[TTBChangeInfoViewController alloc]init];
    TTBBaseNavController *nav = [[TTBBaseNavController alloc]initWithRootViewController:changeInfoController];
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        changeInfoController.changeType = ChangeInfoType_Name;
        [self presentViewController:nav animated:YES completion:nil];
    }
    if(indexPath.section == 0 && indexPath.row == 1)
    {
        changeInfoController.changeType = ChangeInfoType_Company;
        [self presentViewController:nav animated:YES completion:nil];
    }
    if(indexPath.section == 0 && indexPath.row == 3)
    {
        UIActionSheet *activity = [[UIActionSheet alloc]initWithTitle:@"设置性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        activity.tag = 200;
        [activity showInView:self.view];
    }
    if(indexPath.section == 0 && indexPath.row == 4)
    {
        changeInfoController.changeType = ChangeInfoType_Email;
        [self presentViewController:nav animated:YES completion:nil];
    }
    if(indexPath.section == 0 && indexPath.row == 5)
    {
        changeInfoController.changeType = ChangeInfoType_QQ;
        [self presentViewController:nav animated:YES completion:nil];
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
