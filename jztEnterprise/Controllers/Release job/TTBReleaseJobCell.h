//
//  TTBReleaseJobCell.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"
#import "TTBReleaseJobViewBase.h"

#define ReleaseJobCellHeight 50
#define ReleaseJobJobContentRowHeight 125

#define ReleaseJobTitleWidth 77

typedef enum
{
    ReleaseJobCellType_JobTitle = 0,
    ReleaseJobCellType_Money,
    ReleaseJobCellType_JobType,
    ReleaseJobCellType_CountWay,
    ReleaseJobCellType_Deadline,
    ReleaseJobCellType_WorkDate,
    ReleaseJobCellType_NumOfWorker,
//    ReleaseJobCellType_JobArea,
    ReleaseJobCellType_JobAddress,
    ReleaseJobCellType_JobContent,
    ReleaseJobCellType_Sex,
    ReleaseJobCellType_Height,
    ReleaseJobCellType_HealthCertificate,
    ReleaseJobCellType_Interview
}ReleaseJobCellType;

@interface TTBReleaseJobCell : TTBBaseTableViewCell

@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UITextField *contentText;
@property (nonatomic , strong) UILabel *tipLab;
@property (nonatomic , strong) UIImageView *tipImg;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UITextView *jobContentView;

- (void)initReleaseJobCellView:(ReleaseJobCellType)releaseJobCellType;

@end
