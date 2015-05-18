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
        [self.contentView addSubview:self.titleLab];
        
        self.contentText = [[UITextField alloc]init];
        self.contentText.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentText.textAlignment = NSTextAlignmentRight;
        self.contentText.textColor = APP_FONT_COLOR_NORMAL;
        self.contentText.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.contentText];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = SeparatorColor;
        [self.contentView addSubview:self.line];
        
        self.tipLab = [[UILabel alloc]init];
        self.tipLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.tipLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.tipLab];
        
        self.tipImg = [[UIImageView alloc]init];
        [self.contentView addSubview:self.tipImg];
        
        self.jobContentView = [[UITextView alloc]init];
        self.jobContentView.layer.cornerRadius = 3;
        self.jobContentView.layer.borderWidth = 0.5;
        self.jobContentView.layer.borderColor = SeparatorColor.CGColor;
//        self.jobContentView.textColor = APP_FONT_COLOR_NORMAL;
        self.jobContentView.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.jobContentView.textColor = SeparatorColor;
        self.jobContentView.text = @"请输入兼职内容";
        [self.contentView addSubview:self.jobContentView];
    }
    return self;
}

- (void)hideWitgets
{
    self.contentText.hidden = YES;
    self.tipImg.hidden = YES;
    self.tipLab.hidden = YES;
    self.line.hidden = YES;
    self.jobContentView.hidden = YES;
}

- (void)initReleaseJobCellView:(ReleaseJobCellType)releaseJobCellType
{
    [self hideWitgets];
    
    switch (releaseJobCellType)
    {
        case ReleaseJobCellType_JobTitle:
        {
            self.titleLab.text = @"标       题";
            
            self.contentText.hidden = NO;
            self.contentText.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing, ReleaseJobCellHeight);
            [self.contentText setKeyboardType:UIKeyboardTypeDefault];
            self.contentText.placeholder = @"请输入标题";
        }
            break;
        case ReleaseJobCellType_Money:
        {
            self.titleLab.text = @"薪       资";
            self.contentText.hidden = NO;
            self.contentText.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing -  85, ReleaseJobCellHeight);
            [self.contentText setKeyboardType:UIKeyboardTypeDecimalPad];
            self.contentText.placeholder = @"请输入薪资";
            
            self.line.hidden = NO;
            self.line.frame = CGRectMake(CGRectGetMaxX(self.contentText.frame) + 5, 15, 0.5, ReleaseJobCellHeight - 30);
            
            self.tipLab.hidden = NO;
            self.tipLab.textColor = APP_FONT_COLOR_NORMAL;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.line.frame) + 5, 0, SCREEN_WIDTH - (CGRectGetMaxX(self.line.frame) + 5) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
            self.tipLab.text = @"元/天";
        }
            break;
        case ReleaseJobCellType_JobType:
        {
            self.titleLab.text = @"工       种";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"点击选择";
            self.tipLab.textColor = SeparatorColor;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
        }
            break;
        case ReleaseJobCellType_CountWay:
        {
            self.titleLab.text = @"结算方式";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"点击选择";
            self.tipLab.textColor = SeparatorColor;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
        }
            break;
        case ReleaseJobCellType_Deadline:
        {
            self.titleLab.text = @"报名截止";
            
            self.tipImg.hidden = NO;
            self.tipImg.image = [UIImage imageNamed:@"release_job_date_icon"];
            self.tipImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), (ReleaseJobCellHeight - 19) / 2, 17.5, 19);
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"点击选择日期";
            self.tipLab.textColor = SeparatorColor;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.tipImg.frame) + 5, 0, SCREEN_WIDTH - CGRectGetMaxX(self.tipImg.frame) - 5 - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
            
        }
            break;
        case ReleaseJobCellType_WorkDate:
        {
            self.tipImg.hidden = NO;
            self.tipImg.image = [UIImage imageNamed:@"release_job_date_icon"];
            self.tipImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), (ReleaseJobCellHeight - 19) / 2, 17.5, 19);
            
            self.titleLab.text = @"工作日期";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"点击选择日期";
            self.tipLab.textColor = SeparatorColor;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.tipImg.frame) + 5, 0, SCREEN_WIDTH - CGRectGetMaxX(self.tipImg.frame) - 5 - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
            
        }
            break;
        case ReleaseJobCellType_NumOfWorker:
        {
            self.titleLab.text = @"人       数";
            
            self.contentText.hidden = NO;
            self.contentText.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing, ReleaseJobCellHeight);
            [self.contentText setKeyboardType:UIKeyboardTypeNumberPad];
            self.contentText.placeholder = @"请输入整人数";
        }
            break;
//        case ReleaseJobCellType_JobArea:
//        {
//            self.titleLab.text = @"工作区域";
//            
//            self.tipLab.hidden = NO;
//            self.tipLab.text = @"点击选择工作区域";
//            self.tipLab.textColor = SeparatorColor;
//            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
//        }
//            break;
        case ReleaseJobCellType_JobAddress:
        {
            self.titleLab.text = @"工作地址";
            
            self.contentText.hidden = NO;
            self.contentText.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing, ReleaseJobCellHeight);
            [self.contentText setKeyboardType:UIKeyboardTypeDefault];
            self.contentText.placeholder = @"请输入工作地址";
        }
            break;
        case ReleaseJobCellType_JobContent:
        {
            self.titleLab.text = @"工作内容";
            
            self.jobContentView.hidden = NO;
            self.jobContentView.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 10, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing, ReleaseJobJobContentRowHeight - 20);
        }
            break;
        case ReleaseJobCellType_Sex:
        {
            self.titleLab.text = @"性别限制";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"无";
            self.tipLab.textColor = APP_FONT_COLOR_NORMAL;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
        }
            break;
        case ReleaseJobCellType_Height:
        {
            self.titleLab.text = @"身高限制";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"无";
            self.tipLab.textColor = APP_FONT_COLOR_NORMAL;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
        }
            break;
        case ReleaseJobCellType_HealthCertificate:
        {
            self.titleLab.text = @"健  康  证";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"不需要";
            self.tipLab.textColor = APP_FONT_COLOR_NORMAL;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
        }
            break;
        case ReleaseJobCellType_Interview:
        {
            self.titleLab.text = @"面       试";
            
            self.tipLab.hidden = NO;
            self.tipLab.text = @"不需要";
            self.tipLab.textColor = APP_FONT_COLOR_NORMAL;
            self.tipLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, SCREEN_WIDTH - CGRectGetMaxX(self.titleLab.frame) - ReleaseJobMainSpacing - 20, ReleaseJobCellHeight);
        }
            break;
            
        default:
            break;
    }
}
@end
