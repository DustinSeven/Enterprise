//
//  TTBReleaseJobFootCell.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"

#define ReleaseJobFootCellHeight 108

#define ReleaseJobFootCellColor [UIColor colorWithRed:240.0f / 255.0f green:240.0f / 255.0f blue:240.0f / 255.0f alpha:1.0f]

#define ReleaseJobFootCellSelectBtnWidth 35

#define ReleaseJobFootCellCheckLabWidth 120

#define ReleaseJobFootCellCheckBtnWidth 95

#define ReleaseJobFootCellReleaseBtnWidth 295
#define ReleaseJobFootCellReleaseBtnHeight 40


@interface TTBReleaseJobFootCell : TTBBaseTableViewCell

@property (nonatomic , strong)UIButton *selectBtn;
@property (nonatomic , strong)UILabel *checkLab;
@property (nonatomic , strong)UIButton *checkBtn;
@property (nonatomic , strong)UIButton *releseBtn;

@end
