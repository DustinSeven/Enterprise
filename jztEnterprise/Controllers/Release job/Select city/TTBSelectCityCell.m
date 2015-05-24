//
//  TTBSelectCityCell.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSelectCityCell.h"

@implementation TTBSelectCityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = CELL_SELECTED_COLOR;
        
        self.textLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.textLabel.textColor = APP_FONT_COLOR_NORMAL;
    }
    return self;
}

@end
