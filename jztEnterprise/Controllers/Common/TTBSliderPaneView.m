//
//  TTBSliderPaneView.m
//  jztEnterprise
//
//  Created by 李明伟 on 15/1/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSliderPaneView.h"

@interface TTBSliderPaneView()
{
    UIImageView *valueLabBgImg;
}

@end

@implementation TTBSliderPaneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initWitgets];
    }
    return self;
}

- (void)initWitgets
{
    self.baseSlider = [[UISlider alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - SliderPaneWidth) / 2, (CGRectGetHeight(self.frame) - SliderPaneHight) / 2, SliderPaneWidth, SliderPaneHight)];
    [self.baseSlider setThumbImage:[UIImage imageNamed:@"slider_point_icon"] forState:UIControlStateNormal];
    [self.baseSlider setMinimumTrackImage:[TTBUtility resizeImage:@"slider_bg_passed"] forState:UIControlStateNormal];
    [self.baseSlider addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.baseSlider];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setImage:[UIImage imageNamed:@"slider_add_btn_icon_normal"] forState:UIControlStateNormal];
    self.addBtn.frame = CGRectMake(CGRectGetMaxX(self.baseSlider.frame), CGRectGetMinY(self.baseSlider.frame) + (CGRectGetHeight(self.baseSlider.frame) - SliderBtnHeight) / 2, (SCREEN_WIDTH - SliderPaneWidth) / 2, SliderBtnHeight);
    [self.addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addBtn];
    
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reduceBtn setImage:[UIImage imageNamed:@"slider_reduce_btn_icon_normal"] forState:UIControlStateNormal];
    self.reduceBtn.frame = CGRectMake(0, CGRectGetMinY(self.baseSlider.frame) + (CGRectGetHeight(self.baseSlider.frame) - SliderBtnHeight) / 2, (SCREEN_WIDTH - SliderPaneWidth) / 2, SliderBtnHeight);
    [self.reduceBtn addTarget:self action:@selector(reduceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.reduceBtn];
    
    valueLabBgImg = [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"slider_value_bg_img"];
    CGFloat imageW = image.size.width * 1 / 5;
    CGFloat imageH = image.size.height * 0.5;
    valueLabBgImg.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
    [self addSubview:valueLabBgImg];
    
    self.valueLab = [[UILabel alloc]init];
    self.valueLab.textColor = [UIColor whiteColor];
    self.valueLab.font = [UIFont systemFontOfSize:APP_FONT_SIZE_SMALL];
    [valueLabBgImg addSubview:self.valueLab];
    
    self.heightValue = SliderMinValue;
    
    [self sliderValueChange];
}

- (void)sliderValueChange
{
    self.heightValue = (SliderMaxValue - SliderMinValue) * self.baseSlider.value + SliderMinValue;
    self.valueLab.text = [NSString stringWithFormat:@"%0.1fcm",self.heightValue];
    CGSize valueLabSize = [self.valueLab sizeThatFits:CGSizeMake(CGFLOAT_MIN, 45)];
    valueLabBgImg.frame = CGRectMake(self.baseSlider.value * CGRectGetWidth(self.baseSlider.frame) - valueLabSize.width / 2 - 15 + CGRectGetMinX(self.baseSlider.frame) + 10, CGRectGetMinY(self.baseSlider.frame) - 20, valueLabSize.width + 10, 20);
    self.valueLab.frame = CGRectMake(5, 0, valueLabSize.width, valueLabSize.height);
}

- (void)slideToValue:(float)value
{
    self.heightValue = value;
    self.baseSlider.value = (self.heightValue - SliderMinValue) / (SliderMaxValue - SliderMinValue);
    self.valueLab.text = [NSString stringWithFormat:@"%0.1fcm",self.heightValue];
    CGSize valueLabSize = [self.valueLab sizeThatFits:CGSizeMake(CGFLOAT_MIN, 45)];
    valueLabBgImg.frame = CGRectMake(self.baseSlider.value * CGRectGetWidth(self.baseSlider.frame) - valueLabSize.width / 2 - 15 + CGRectGetMinX(self.baseSlider.frame) + 10, CGRectGetMinY(self.baseSlider.frame) - 20, valueLabSize.width + 10, 20);
    self.valueLab.frame = CGRectMake(5, 0, valueLabSize.width, valueLabSize.height);
}

#pragma mark - addBtnClicked
- (void)addBtnClicked:(UIButton *)button
{
    if(self.heightValue < SliderMaxValue)
    {
        int tmpValue = (int)self.heightValue;
        float upV = ++tmpValue - SliderMinValue;
        float downV = SliderMaxValue - SliderMinValue;
        float finalV = upV / downV;
        float sliderValue = finalV;
        self.baseSlider.value = sliderValue;
        
        [self sliderValueChange];
    }
}

#pragma mark - addBtnClicked
- (void)reduceBtnClicked:(UIButton *)button
{
    if(self.heightValue > SliderMinValue)
    {
        int tmpValue = (int)self.heightValue;
        float upV = --tmpValue - SliderMinValue;
        float downV = SliderMaxValue - SliderMinValue;
        float finalV = upV / downV;
        float sliderValue = finalV;
        self.baseSlider.value = sliderValue;
        
        [self sliderValueChange];
    }
}

@end
