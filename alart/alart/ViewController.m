//
//  ViewController.m
//  alart
//
//  Created by phoenix on 4/6/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender {
    
    [[[UIAlertView alloc]initWithTitle:@"中文抬头 title" message:@"警告框正文内容" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil]show];
    
}
@end
