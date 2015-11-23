//
//  CNFGroupHeaderView.h
//  通讯录
//
//  Created by singer on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//  分组中得每一个headerView

#import <UIKit/UIKit.h>

@class CNFPeopleGroup,CNFGroupHeaderView;

@protocol CNFHeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClickedNameView:(CNFGroupHeaderView *)headerView;
@end

@interface CNFGroupHeaderView : UITableViewHeaderFooterView
/**
 *  返回一个headerView
 */
+ (instancetype)viewWithTableView:(UITableView *)tableView;

/**
 *  接收一个组模型数据
 */
@property (nonatomic , strong) CNFPeopleGroup *group;

@property (nonatomic, weak) id<CNFHeaderViewDelegate> delegate;

@end
