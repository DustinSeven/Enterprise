//
//  TTBGroupSendingController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/29.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBGroupSendingController.h"
#import "TTBGroupSendingViewIphone.h"

@interface TTBGroupSendingController ()<UITextViewDelegate>
{
    TTBGroupSendingViewBase *_baseView;
    
    UITapGestureRecognizer *mainTap;
}

@end

@implementation TTBGroupSendingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBGroupSendingViewIphone alloc]init];
        self.view = _baseView;
        
        mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTaped:)];
        [_baseView addGestureRecognizer:mainTap];
        
        _baseView.messageContentView.delegate = self;
        
        self.title = @"群发消息";
        
        [self setUserImg];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChange:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
    
    if(moveY < 0)
        moveY = - (CGRectGetMinY(_baseView.messageContentView.frame) - 5);
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}


- (void)setUserImg
{
    _baseView.userImg0.image = [UIImage imageNamed:@"user_img_default_120px"];
    _baseView.userImg1.image = [UIImage imageNamed:@"user_img_default_120px"];
    _baseView.userImg2.image = [UIImage imageNamed:@"user_img_default_120px"];
    _baseView.userImg3.image = [UIImage imageNamed:@"user_img_default_120px"];
    _baseView.userImg4.image = [UIImage imageNamed:@"user_img_default_120px"];
    _baseView.userImg5.image = [UIImage imageNamed:@"user_img_default_120px"];
}

- (void)viewTaped:(UITapGestureRecognizer *)tap
{
    [_baseView.messageContentView resignFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入消息内容"])
    {
        textView.textColor = APP_FONT_COLOR_NORMAL;
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        textView.textColor = SeparatorColor;
        textView.text = @"请输入消息内容";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        
        return NO;
    }
    return YES;
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
