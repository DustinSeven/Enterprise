//
//  TTBMemberMenuCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/28.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMemberMenuCell.h"

@implementation TTBMemberMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = MemberMenuCellColor;
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = MemberMenuCellColor;
        
        self.signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.signInBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3, MemberMenuCellHeight);
        [self.signInBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH / 3, MemberMenuCellHeight)] forState:UIControlStateHighlighted];
        [self.signInBtn setImage:[UIImage imageNamed:@"member_menu_sign_in_btn_icon_normal"] forState:UIControlStateNormal];
        [self.signInBtn setImage:[UIImage imageNamed:@"member_menu_sign_in_btn_icon_normal"] forState:UIControlStateHighlighted];
        [self.signInBtn setImage:[UIImage imageNamed:@"member_menu_sign_in_btn_icon_disable"] forState:UIControlStateDisabled];
        [self.contentView addSubview:self.signInBtn];
        
        self.sessionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sessionBtn.frame = CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, MemberMenuCellHeight);
        [self.sessionBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH / 3, MemberMenuCellHeight)] forState:UIControlStateHighlighted];
        [self.sessionBtn setImage:[UIImage imageNamed:@"member_menu_session_btn_icon"] forState:UIControlStateNormal];
        [self.sessionBtn setImage:[UIImage imageNamed:@"member_menu_session_btn_icon"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:self.sessionBtn];
        
        self.phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.phoneBtn.frame = CGRectMake(SCREEN_WIDTH / 3 * 2, 0, SCREEN_WIDTH / 3, MemberMenuCellHeight);
        [self.phoneBtn setBackgroundImage:[TTBUtility imageWithColor:MainColorNormal size:CGSizeMake(SCREEN_WIDTH / 3, MemberMenuCellHeight)] forState:UIControlStateHighlighted];
        [self.phoneBtn setImage:[UIImage imageNamed:@"member_menu_phone_btn_icon"] forState:UIControlStateNormal];
        [self.phoneBtn setImage:[UIImage imageNamed:@"member_menu_phone_btn_icon"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:self.phoneBtn];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
