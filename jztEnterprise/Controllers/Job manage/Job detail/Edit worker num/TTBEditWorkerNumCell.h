//
//  TTBEditWorkerNumCell.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/30.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseTableViewCell.h"

#define EditWorkerNumCellHeight 80

#define EditWorkerNumSliderWidth 160

#define EditWorkerNumLabWidth 40

@interface TTBEditWorkerNumCell : TTBBaseTableViewCell

@property (nonatomic , strong) UILabel *dateLab;
@property (nonatomic , strong) UILabel *numOrgLab;
@property (nonatomic , strong) UILabel *numChangedLab;
@property (nonatomic , strong) UIImageView *workerImg;

@property (nonatomic , strong) UISlider *baseSlider;
@property (nonatomic , strong) UIButton *addBtn;
@property (nonatomic , strong) UIButton *reduceBtn;

@property (nonatomic , strong) UILabel *minNumLab;
@property (nonatomic , strong) UILabel *maxNumLab;

@property (nonatomic , assign) int changedValue;

@end
