//
//  TTBSessionDetailCell.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/12.
//  Copyright (c) 2015年 Lee Mingwei. All rights reserved.
//

#import "TTBSessionDetailCell.h"

@implementation TTBSessionDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        self.timeLab = [[UILabel alloc] init];
        self.timeLab.textAlignment = NSTextAlignmentCenter;
        self.timeLab.textColor = [UIColor grayColor];
        self.timeLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.timeLab];
        
        self.userImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.userImg];
        
        self.chatContent = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chatContent.backgroundColor = [UIColor clearColor];
        self.chatContent.titleLabel.numberOfLines = 0;
        self.chatContent.titleLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.chatContent];
    }
    return self;
}

- (void)setFrameModel:(TTBSessionDetailCellFrameModel *)frameModel
{
    self.timeLab.frame = frameModel.timeFrame;
    self.timeLab.text = frameModel.timeStr;
    
    self.userImg.frame = frameModel.imgFrame;
    if(frameModel.imgStr)
    {
//        [self.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GET_USER_IMG_URL,frameModel.imgStr]] placeholderImage:[UIImage imageNamed:@"user_img_default_80px"] isScaleToCustomSize:NO];
    }
    else
        self.userImg.image = [UIImage imageNamed:@"user_img_default_120px"];
    
    self.chatContent.frame = frameModel.contentFrame;
    NSString *textBg = !frameModel.isMe ? @"session_detail_is_not_me_back" : @"session_detail_is_me_back";
    UIColor *textColor = !frameModel.isMe ? [UIColor blackColor] : [UIColor whiteColor];
    self.chatContent.contentEdgeInsets = frameModel.isMe ?UIEdgeInsetsMake(15, 9, 15, 15):UIEdgeInsetsMake(15, 15, 15, 9);
    [self.chatContent setBackgroundImage:[TTBUtility resizeImage:textBg] forState:UIControlStateNormal];
    [self.chatContent setBackgroundImage:[TTBUtility resizeImage:textBg] forState:UIControlStateHighlighted];
    [self.chatContent setTitleColor:textColor forState:UIControlStateNormal];
    [self.chatContent setTitle:frameModel.message forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
