//
//  ViewController.h
//  ME_WebViewSampleTests
//
//  Created by phoenix on 3/22/15.
//  Copyright (c) 2015 home. All rights reserved.
// try1

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController  <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)testLoadHTMLString:(id)sender;
- (IBAction)testLoadData:(id)sender;
- (IBAction)testLoadRequest:(id)sender;

@end

