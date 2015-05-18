//
//  TTBUserCenterCell.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/21.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBUserCenterCell.h"

@implementation TTBUserCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(13, (UserCenterCellHeight - UserCenterCellIconWidth) / 2, UserCenterCellIconWidth, UserCenterCellIconWidth)];
        [self.contentView addSubview:self.iconImg];
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.contentLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.contentLab];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end
