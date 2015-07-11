//
//  ViewController.h
//  huodai search
//
//  Created by phoenix on 4/13/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)load:(id)sender;

@end

