//
//  TTBJobCell.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/14.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"
#import "TTBProcessBar.h"

#define JobCellSectionHeight 30

#define JobCellHight 75

#define JobCellJobImgHeight 65
#define JobCellJobImgWidth 95

#define JobCellJobNameLabHeight 33

typedef enum
{
    JobProcess_AllSignIn = 0,
    JobProcess_NotAllSignIn,
    JobProcess_Recruiting,
    JobProcess_Checking,
    JobProcess_FailToChecking,
    JobProcess_Finished,
    JobProcess_WaitToFinish
}JobProcess;

@interface TTBJobCell : TTBBaseTableViewCell

@property (nonatomic , strong)UIImageView *jobImg;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UILabel *processLab;
@property (nonatomic , strong)UILabel *statusLab;

@end
