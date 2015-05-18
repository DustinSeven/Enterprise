//
//  TTBAdviceController.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBAdviceController.h"
#import "TTBAdviceViewIphone.h"

@interface TTBAdviceController ()<UITextViewDelegate>
{
    TTBAdviceViewBase *_baseView;
    UITapGestureRecognizer *mainTap;
}

@end

@implementation TTBAdviceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_PHONE)
    {
        _baseView = [[TTBAdviceViewIphone alloc]init];
        self.view = _baseView;
        
        self.title = @"意见反馈";
        
        _baseView.contentView.delegate = self;
        
        mainTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewTaped:)];
        [_baseView addGestureRecognizer:mainTap];
    }
}

- (void)mainViewTaped:(UITapGestureRecognizer *)tap
{
    [_baseView.contentView resignFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"亲，有什么想说的呢？"])
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
        textView.text = @"亲，有什么想说的呢？";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else
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
