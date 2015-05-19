//
//  TTBChangeInfoViewController.h
//  jztEnterprise
//
//  Created by Lee on 15/5/19.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ChangeInfoType_Name = 0,
    ChangeInfoType_Company,
    ChangeInfoType_Email,
    ChangeInfoType_QQ
}ChangeInfoType;

@interface TTBChangeInfoViewController : UIViewController

@property (nonatomic , assign) ChangeInfoType changeType;

@end
