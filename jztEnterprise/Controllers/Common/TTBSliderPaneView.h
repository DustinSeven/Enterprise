//
//  TTBSliderPaneView.h
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SliderPaneWidth 214
#define SliderPaneHight 38

#define SliderBtnHeight 50

#define SliderMinValue 150
#define SliderMaxValue 200

@interface TTBSliderPaneView : UIView

@property (nonatomic , strong) UISlider *baseSlider;
@property (nonatomic , strong) UIButton *addBtn;
@property (nonatomic , strong) UIButton *reduceBtn;
@property (nonatomic , strong) UILabel *valueLab;

@property (nonatomic , assign) float heightValue;

- (void)slideToValue:(float)value;

@end
