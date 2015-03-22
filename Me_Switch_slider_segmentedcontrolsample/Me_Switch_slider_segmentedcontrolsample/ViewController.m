//
//  ViewController.m
//  Me_Switch_slider_segmentedcontrolsample
//
//  Created by phoenix on 3/22/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//使两个开关的值保持一致
- (IBAction)switchValueChanged:(id)sender {
    
    UISwitch *witchSwitch = (UISwitch *)sender;
    BOOL setting = witchSwitch.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}


//用标签显示滑块的值
- (IBAction)sliderValueChange:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value + 0.5f);
    NSString *newText = [[NSString alloc]initWithFormat:@"%d",progressAsInt];
    self.SliderValue.text = newText;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
