//
//  TTBJobCell.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobCell.h"

@interface TTBJobCell()
{
    UIImageView *proessIcon;
}

@end

@implementation TTBJobCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, (JobCellHight - JobCellJobImgHeight) / 2, JobCellJobImgWidth, JobCellJobImgHeight)];
        self.jobImg.layer.masksToBounds = YES;
        self.jobImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.jobImg];
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, CGRectGetMinY(self.jobImg.frame), SCREEN_WIDTH - (CGRectGetMaxX(self.jobImg.frame) + 10) - 12.5, JobCellJobNameLabHeight)];
        self.titleLab.font = [UIFont systemFontOfSize:13];
        self.titleLab.textColor = APP_FONT_COLOR_NORMAL;
        self.titleLab.numberOfLines = 2;
        self.titleLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.titleLab];
        
        self.statusLab = [[UILabel alloc]init];
        self.statusLab.font = [UIFont systemFontOfSize:11];
        self.statusLab.textColor = APP_FONT_COLOR_NORMAL;
        self.statusLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.statusLab];
        
        proessIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:proessIcon];
        
        self.processLab = [[UILabel alloc]init];
        self.processLab.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.processLab];
        
        proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
        proessIcon.image = [UIImage imageNamed:@"job_process_num_of_worker_icon"];
        
        self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
        self.processLab.text = @"";
        self.processLab.textColor = APP_FONT_COLOR_THIN;
        
//        self.statusLab.text = @"已全部签到";
        self.statusLab.textColor = APP_FONT_COLOR_THIN;
        self.statusLab.frame = CGRectMake(SCREEN_WIDTH - 160 ,JobCellHight - 20, 150, 10);
        
    }
    return self;
}

@end
