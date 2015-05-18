//
//  TTBEditWorkerNumCell.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBEditWorkerNumCell.h"

@interface TTBEditWorkerNumCell()
{
    
}

@end

@implementation TTBEditWorkerNumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.dateLab = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 0, 90, EditWorkerNumCellHeight / 2)];
        self.dateLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.dateLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.dateLab];
        
        self.workerImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateLab.frame) + 5, CGRectGetMinY(self.dateLab.frame) + (CGRectGetHeight(self.dateLab.frame) - 13.5) / 2 , 15.5, 13.5)];
        self.workerImg.image = [UIImage imageNamed:@"job_process_num_of_worker_icon"];
        [self.contentView addSubview:self.workerImg];
        
        self.numOrgLab = [[UILabel alloc]init];
        self.numOrgLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.numOrgLab.textColor = APP_FONT_COLOR_NORMAL;
        [self.contentView addSubview:self.numOrgLab];
        
        self.numChangedLab = [[UILabel alloc]init];
        self.numChangedLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        [self.contentView addSubview:self.numChangedLab];
        
        self.baseSlider = [[UISlider alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - EditWorkerNumSliderWidth) / 2, EditWorkerNumCellHeight / 2, EditWorkerNumSliderWidth, EditWorkerNumCellHeight / 2)];
        [self.baseSlider setThumbImage:[UIImage imageNamed:@"slider_point_icon"] forState:UIControlStateNormal];
        [self.baseSlider setMinimumTrackImage:[TTBUtility resizeImage:@"slider_bg_passed"] forState:UIControlStateNormal];
        [self addSubview:self.baseSlider];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addBtn setImage:[UIImage imageNamed:@"slider_add_btn_icon_normal"] forState:UIControlStateNormal];
        self.addBtn.frame = CGRectMake(SCREEN_WIDTH  - ((SCREEN_WIDTH - EditWorkerNumSliderWidth - 2 * EditWorkerNumLabWidth) / 2), CGRectGetMinY(self.baseSlider.frame) + (CGRectGetHeight(self.baseSlider.frame) - EditWorkerNumCellHeight / 2) / 2, (SCREEN_WIDTH - EditWorkerNumSliderWidth - 2 * EditWorkerNumLabWidth) / 2, EditWorkerNumCellHeight / 2);
        [self addSubview:self.addBtn];
        
        self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reduceBtn setImage:[UIImage imageNamed:@"slider_reduce_btn_icon_normal"] forState:UIControlStateNormal];
        self.reduceBtn.frame = CGRectMake(0, CGRectGetMinY(self.baseSlider.frame) + (CGRectGetHeight(self.baseSlider.frame) - EditWorkerNumCellHeight / 2) / 2, (SCREEN_WIDTH - EditWorkerNumSliderWidth - 2 * EditWorkerNumLabWidth) / 2, EditWorkerNumCellHeight / 2);
        [self addSubview:self.reduceBtn];
        
        self.minNumLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.reduceBtn.frame), EditWorkerNumCellHeight / 2, EditWorkerNumLabWidth, EditWorkerNumCellHeight / 2)];
        self.minNumLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.minNumLab.textColor = MainColorNormal;
        self.minNumLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.minNumLab];
        
        self.maxNumLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.baseSlider.frame), EditWorkerNumCellHeight / 2, EditWorkerNumLabWidth, EditWorkerNumCellHeight / 2)];
        self.maxNumLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_NORMAL];
        self.maxNumLab.textColor = MainColorNormal;
        self.maxNumLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.maxNumLab];
        
    }
    return self;
}

@end
