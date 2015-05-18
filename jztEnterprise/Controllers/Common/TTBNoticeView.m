//
//  TTBNoticeView.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBNoticeView.h"

@interface TTBNoticeView()
{
    UIImageView *noticeIcon;
    UILabel *noticeLab;
    
    CGRect mainFrame;
    CGSize noticeLabSize;
    
    NSTimer *timer;
}

@end

@implementation TTBNoticeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        mainFrame = frame;
        
        self.backgroundColor = [UIColor colorWithRed:243.0f / 255.0f green:228.0f / 255.0f blue:186.0f / 255.0f alpha:1.0f];
        
        noticeIcon = [[UIImageView alloc]init];
        noticeIcon.image = [UIImage imageNamed:@"session_detail_notice_icon"];
        [self addSubview:noticeIcon];
        
        noticeLab = [[UILabel alloc]init];
        noticeLab.font = [UIFont systemFontOfSize:10];
        noticeLab.textColor = APP_FONT_COLOR_NORMAL;
        noticeLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self addSubview:noticeLab];
    }
    return self;
}

- (void)setNoticeMessage:(NSString *)noticeMessage
{
    noticeLab.text = noticeMessage;
    
    noticeLabSize = [noticeLab sizeThatFits:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN)];
    noticeLab.frame = CGRectMake((mainFrame.size.width - noticeLabSize.width - 20) / 2 + 20, 5, noticeLabSize.width, noticeLabSize.height);
    noticeLab.hidden = YES;
    
    noticeIcon.frame = CGRectMake(CGRectGetMinX(noticeLab.frame) - 20, (noticeLabSize.height + 10 - 15) / 2, 15, 15);
    noticeIcon.hidden = YES;
    
    self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, 0);
}

- (void)setHidden:(BOOL)hidden
{
    
    if(hidden == NO)
    {
        if(self.parentView)
           [self.parentView addSubview:self];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, noticeLabSize.height + 10);
            
        } completion:^(BOOL finished) {
            noticeLab.hidden = NO;
            noticeIcon.hidden = NO;
            timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            [super setHidden:hidden];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            noticeLab.hidden = YES;
            noticeIcon.hidden = YES;
            self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            [super setHidden:hidden];
            
        }];
    }
}

- (void)timerFireMethod:(NSTimer *)timer
{
    self.hidden = YES;
}

@end
