//
//  TTBChangePwdCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChangePwdCell.h"

@implementation TTBChangePwdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentText = [[UITextField alloc]initWithFrame:CGRectMake(12.5, 0, SCREEN_WIDTH - 25, ChangePwdCellHeight)];
        self.contentText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.contentText.textColor = APP_FONT_COLOR_NORMAL;
        self.contentText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:self.contentText];
    }
    return self;
}

@end
