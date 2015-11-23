//
//  CNFRootTabBarController.m
//  通讯录
//
//  Created by gwp on 15-5-18.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFRootTabBarController.h"
#import "CNFAllViewController.h"
#import "CNFGroupViewController.h"
#import "CNFHistoryViewController.h"
#import "CNFSettingViewController.h"
#import "CNFNavigationController.h"

@interface CNFRootTabBarController ()

@end

@implementation CNFRootTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        CNFAllViewController *all = [[CNFAllViewController alloc] init];
        all.title = @"联系人-全部";
        all.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"所有联系人" image:[UIImage imageNamed:@"icon_contacts"] tag:0];
        
        CNFGroupViewController *group = [[CNFGroupViewController alloc] init];
        group.title = @"联系人-群组";
        group.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"群组" image:[UIImage imageNamed:@"icon_individual_qz_n"] tag:0];
        
        CNFHistoryViewController *history = [[CNFHistoryViewController alloc] init];
        history.title = @"历史记录";
        history.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"历史" image:[UIImage imageNamed:@"icon_history"] tag:0];
        
        CNFSettingViewController *setting = [[CNFSettingViewController alloc] init];
        setting.title = @"更多";
        setting.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"icon_more_pb_bar"] tag:0];
        
        NSArray *vcs = @[
                         [[CNFNavigationController alloc] initWithRootViewController:all],
                         [[CNFNavigationController alloc] initWithRootViewController:group],
                         [[CNFNavigationController alloc] initWithRootViewController:history],
                         [[CNFNavigationController alloc] initWithRootViewController:setting],
                         ];
        
        
        
        self.viewControllers = vcs;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}


@end
