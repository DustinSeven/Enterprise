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
    
    UIImageView *stateIcon;
}

@end

@implementation TTBJobCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(12.5, (JobCellHight - JobCellJobImgHeight) / 2, JobCellJobImgWidth, JobCellJobImgHeight)];
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
        
        stateIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:stateIcon];
        
        proessIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:proessIcon];
        
        self.processLab = [[UILabel alloc]init];
        self.processLab.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.processLab];
        
        self.processBar = [[TTBProcessBar alloc]init];
        self.processBar.hidden = YES;
        [self.contentView addSubview:self.processBar];
        
    }
    return self;
}

- (void)setJobProcess:(JobProcess)jobProcess
{
    switch (jobProcess) {
        case JobProcess_AllSignIn:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_num_of_worker_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"";
            self.processLab.textColor = APP_FONT_COLOR_THIN;
            
            self.processBar.hidden = YES;
            
            self.statusLab.hidden = NO;
            self.statusLab.text = @"已全部签到";
            self.statusLab.textColor = APP_FONT_COLOR_THIN;
            self.statusLab.frame = CGRectMake(SCREEN_WIDTH - 65 ,JobCellHight - 20, 55, 10);
            
            stateIcon.frame = CGRectMake(CGRectGetMinX(self.statusLab.frame) -20.5, CGRectGetMinY(self.statusLab.frame) - 2, 15.5, 13.5);
            stateIcon.hidden = NO;
            stateIcon.image = [UIImage imageNamed:@"job_state_all_sign_in_icon"];
        }
            break;
        case JobProcess_NotAllSignIn:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_num_of_worker_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"";
            self.processLab.textColor = APP_FONT_COLOR_THIN;
            
            self.processBar.hidden = YES;
            
            self.statusLab.hidden = NO;
            self.statusLab.text = @"未全部签到";
            self.statusLab.textColor = MainColorNormal;
            self.statusLab.frame = CGRectMake(SCREEN_WIDTH - 65 ,JobCellHight - 20, 55, 10);
            
            stateIcon.frame = CGRectMake(CGRectGetMinX(self.statusLab.frame) -20.5, CGRectGetMinY(self.statusLab.frame) - 2, 15.5, 13.5);
            stateIcon.hidden = NO;
            stateIcon.image = [UIImage imageNamed:@"job_state_not_all_sign_in_icon"];
        }
            break;
        case JobProcess_Recruiting:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 32, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_recruiting_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"招募中";
            self.processLab.textColor = APP_FONT_COLOR_THIN;
            
            self.statusLab.hidden = NO;
            self.statusLab.text = @"";
            self.statusLab.textColor = MainColorNormal;
            self.statusLab.frame = CGRectMake(SCREEN_WIDTH - 65 ,JobCellHight - 15, 55, 10);
            
            self.processBar.hidden = NO;
            self.processBar.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, CGRectGetMidY(self.statusLab.frame) - 2, SCREEN_WIDTH - (CGRectGetMaxX(self.jobImg.frame) + 10) - 55, 4);
            
            stateIcon.hidden = YES;
        }
            break;
        case JobProcess_Checking:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_checking_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"审核中";
            self.processLab.textColor = APP_FONT_COLOR_THIN;
            
            self.processBar.hidden = YES;
            
            self.statusLab.hidden = YES;
            
            stateIcon.hidden = YES;
        }
            break;
        case JobProcess_FailToChecking:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_fail_to_checking_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"审核失败";
            self.processLab.textColor = MainColorNormal;
            
            self.processBar.hidden = YES;
            
            self.statusLab.hidden = YES;
            
            stateIcon.hidden = YES;
        }
            break;
        case JobProcess_Finished:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_finish_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"已完成";
            self.processLab.textColor = APP_FONT_COLOR_THIN;
            
            self.processBar.hidden = YES;
            
            self.statusLab.hidden = YES;
            
            stateIcon.hidden = YES;
        }
            break;
        case JobProcess_WaitToFinish:
        {
            proessIcon.frame = CGRectMake(CGRectGetMaxX(self.jobImg.frame) + 10, JobCellHight - 23, 15.5, 13.5);
            proessIcon.image = [UIImage imageNamed:@"job_process_waiting_finish_icon"];
            
            self.processLab.frame = CGRectMake(CGRectGetMaxX(proessIcon.frame) + 5, CGRectGetMinY(proessIcon.frame) - 1, 100, 15);
            self.processLab.text = @"待完成";
            self.processLab.textColor = APP_FONT_COLOR_THIN;
            
            self.processBar.hidden = YES;
            
            self.statusLab.hidden = YES;
            
            stateIcon.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

@end
