//
//  TTBReleaseJobViewBase.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/24.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ReleaseJobMainSpacing 12.5

#define ReleaseJobTableViewSectionViewHeight 10

@interface TTBReleaseJobViewBase : UIView
@property (nonatomic , strong)UITableView *baseTableView;

- (void)animateHistoryArrowImg;

@end
