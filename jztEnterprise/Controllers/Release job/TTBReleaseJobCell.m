//
//  TTBReleaseJobCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBReleaseJobCell.h"

@implementation TTBReleaseJobCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ReleaseJobTitleWidth, ReleaseJobCellHeight)];
        self.titleLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.titleLab.textColor = APP_FONT_COLOR_NORMAL;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        
        
        self.tipImg = [[UIImageView alloc]init];
        
        self.jobContentView = [[UITextView alloc]init];
        self.jobContentView.layer.cornerRadius = 3;
        self.jobContentView.layer.borderWidth = 0.5;
        self.jobContentView.layer.borderColor = SeparatorColor.CGColor;
//        self.jobContentView.textColor = APP_FONT_COLOR_NORMAL;
        self.jobContentView.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.jobContentView.textColor = SeparatorColor;
        self.jobContentView.text = @"请输入兼职内容";
        
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = SeparatorColor;
        self.line.frame = CGRectMake(SCREEN_WIDTH - ReleaseJobMainSpacing -  85 + 5, 15, 0.5, ReleaseJobCellHeight - 30);
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)initReleaseJobCellView:(ReleaseJobCellType)releaseJobCellType
{
    for(UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    
    switch (releaseJobCellType)
    {
        case ReleaseJobCellType_JobTitle:
        {
            self.titleLab.text = @"标       题";
            [self.contentView addSubview:self.titleLab];
        }
            break;
        case ReleaseJobCellType_Money:
        {
            self.titleLab.text = @"薪       资";
            [self.contentView addSubview:self.titleLab];
            [self.contentView addSubview:self.line];
        }
            break;
        case ReleaseJobCellType_JobType:
        {
            self.titleLab.text = @"工       种";
            [self.contentView addSubview:self.titleLab];
        }
            break;
        case ReleaseJobCellType_CountWay:
        {
            self.titleLab.text = @"结算方式";
            [self.contentView addSubview:self.titleLab];
        }
            break;
        case ReleaseJobCellType_Deadline:
        {
            self.titleLab.text = @"报名截止";
            [self.contentView addSubview:self.titleLab];
            
            self.tipImg.image = [UIImage imageNamed:@"release_job_date_icon"];
            self.tipImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), (ReleaseJobCellHeight - 19) / 2, 17.5, 19);
            [self.contentView addSubview:self.tipImg];
        }
            break;
        case ReleaseJobCellType_WorkDate:
        {
            self.tipImg.hidden = NO;
            self.tipImg.image = [UIImage imageNamed:@"release_job_date_icon"];
            self.tipImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), (ReleaseJobCellHeight - 19) / 2, 17.5, 19);
            
            self.titleLab.text = @"工作日期";
            [self.contentView addSubview:self.titleLab];
        }
            break;
        case ReleaseJobCellType_WorkTime:
        {
            self.titleLab.text = @"工作时间";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_NumOfWorker:
        {
            self.titleLab.text = @"人       数";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_JobArea:
        {
            self.titleLab.text = @"工作区域";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_JobAddress:
        {
            self.titleLab.text = @"工作地址";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_JobContent:
        {
            self.titleLab.text = @"工作内容";
            [self.contentView addSubview:self.titleLab];
            
            self.jobContentView.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 10, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing, ReleaseJobJobContentRowHeight - 20);
            [self.contentView addSubview:self.jobContentView];
        }
            break;
        case ReleaseJobCellType_Sex:
        {
            self.titleLab.text = @"性别限制";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_Height:
        {
            self.titleLab.text = @"身高限制";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_HealthCertificate:
        {
            self.titleLab.text = @"健  康  证";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
        case ReleaseJobCellType_Interview:
        {
            self.titleLab.text = @"面       试";
            [self.contentView addSubview:self.titleLab];
            
        }
            break;
            
        default:
            break;
    }
}
@end
