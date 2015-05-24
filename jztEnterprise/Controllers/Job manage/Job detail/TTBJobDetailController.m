//
//  TTBJobDetailController.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/15.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobDetailController.h"
#import "TTBSignInController.h"
#import "TTBEditWorkerNumController.h"
#import "TTBJobManagerProcess.h"
#import "UIImageView+WebCache.h"

@interface TTBJobDetailController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    TTBJobDetailViewBase *_baseView;
    TTBJobDetailEntity *jobDetailEntity;
    UIImagePickerController *imgPicker;
}

@end

@implementation TTBJobDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBJobDetailViewIphone alloc]init];
        self.view = _baseView;
        
        imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;//设置可编辑
        imgPicker.videoQuality=UIImagePickerControllerQualityTypeLow;
        
        _baseView.jobContentText.delegate = self;
        
        jobDetailEntity = [[TTBJobDetailEntity alloc]init];
        
        [_baseView.signInBtn addTarget:self action:@selector(signInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView.editWorkerNumBtn addTarget:self action:@selector(editWorkerNumBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jobImgTapped:)];
        [_baseView.jobImg addGestureRecognizer:tap];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self initRootView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSMutableDictionary *detailParam = [[NSMutableDictionary alloc]init];
    [detailParam setValue:_identity forKey:@"parttimeid"];
    [[TTBJobManagerProcess shareInstance]getJobDetailWithParam:detailParam ParentView:nil progressText:@"获取中..." success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            jobDetailEntity = [[TTBJobDetailEntity alloc]initWithAttributes:[data objectAtIndex:0]];
            [self initRootView];
            [_baseView setContentHidden:NO];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)initRootView
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    _baseView.dateLab.text = [NSString stringWithFormat:@"%d月%d日",month,day];
    
    _baseView.signInStateLab.text = @"签到比例：6/6人(已完成)";
    [_baseView.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASE_URL,jobDetailEntity.jobImg]] placeholderImage:[TTBUtility getDefaultImgWithSize:CGSizeMake(101, 101)] options:SDWebImageRefreshCached];
    _baseView.titleLab.text = jobDetailEntity.jobName;
    _baseView.processIcon.image = [UIImage imageNamed:@"job_process_finish_icon"];
    _baseView.processLab.text = [NSString stringWithFormat:@"%d/%d人",jobDetailEntity.num - jobDetailEntity.remaining,jobDetailEntity.num];
    _baseView.processBar.process = (float)(jobDetailEntity.num - jobDetailEntity.remaining) / jobDetailEntity.num;
    _baseView.statusLab.text = [NSString stringWithFormat:@"%0.1f%@",(((float)(jobDetailEntity.num - jobDetailEntity.remaining) / jobDetailEntity.num) * 100),@"%"];
    _baseView.timeLab.text = jobDetailEntity.jobTime;
    _baseView.addressLab.text = jobDetailEntity.jobAddress;
    _baseView.jobTypeLab.text = jobDetailEntity.jobType;
    _baseView.jobContentText.text = jobDetailEntity.jobContent;
    [_baseView setNeedsLayout];
}

#pragma -mark 兼职logo点击事件
- (void)jobImgTapped:(UITapGestureRecognizer *)tap
{
    UIActionSheet *activity = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    activity.tag = 100;
    [activity showInView:self.view];
}

#pragma  mark - editWorkerNumBtnClicked
- (void)editWorkerNumBtnClicked:(UIButton *)button
{
    TTBEditWorkerNumController *editWorkerNumController = [[TTBEditWorkerNumController alloc]init];
    [self.navigationController pushViewController:editWorkerNumController animated:YES];
}

#pragma mark - signInBtnClicked
- (void)signInBtnClicked:(UIButton *)button
{
    TTBSignInController *signInController = [[TTBSignInController alloc]init];
    TTBBaseNavController *signInNav = [[TTBBaseNavController alloc]initWithRootViewController:signInController];
    [self.navigationController presentViewController:signInNav animated:YES completion:^{
        
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -170);
    }];
    
    [_baseView.baseScrollView setContentOffset:CGPointMake(0, _baseView.baseScrollView.contentSize.height - (SCREEN_HEIGHT - JobManageSegHeight)) animated:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

#pragma -mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
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
        NSMutableDictionary *uploadParam = [[NSMutableDictionary alloc]init];
        [uploadParam setValue:_identity forKey:@"jobid"];
        [[TTBJobManagerProcess shareInstance] uploadJobImgWithParam:uploadParam ParentView:nil progressText:@"修改中..." img:[TTBUtility imageWithImage:image scaledToSize:CGSizeMake(400, 400)] success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             if([[responseObject objectForKey:@"code"]intValue] == 200)
             {
                 NSArray *data = [responseObject objectForKey:@"data"];
                 NSString *jobImg = [[data objectAtIndex:0] objectForKey:@"jobimage"];
                 if(jobImg)
                 {
                     
                     [_baseView.jobImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASE_URL,jobImg]] placeholderImage:[TTBUtility getDefaultImgWithSize:CGSizeMake(101, 101)] options:SDWebImageRefreshCached];
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
