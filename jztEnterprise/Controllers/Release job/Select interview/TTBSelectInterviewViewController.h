//
//  TTBSelectInterviewViewController.h
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseController.h"

@protocol TTBSelectInterviewViewControllerDelegate <NSObject>

@required
- (void)didFinishInputInterviewTime:(NSString *)time address:(NSString *)address;

@end

@interface TTBSelectInterviewViewController : TTBBaseController

@property (nonatomic , strong) id<TTBSelectInterviewViewControllerDelegate> delegate;

@end
