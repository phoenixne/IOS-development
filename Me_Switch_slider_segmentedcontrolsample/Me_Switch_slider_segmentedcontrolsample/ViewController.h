//
//  ViewController.h
//  Me_Switch_slider_segmentedcontrolsample
//
//  Created by phoenix on 3/22/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UILabel *SliderValue;


- (IBAction)switchValueChanged:(id)sender;
- (IBAction)sliderValueChange:(id)sender;


@end

