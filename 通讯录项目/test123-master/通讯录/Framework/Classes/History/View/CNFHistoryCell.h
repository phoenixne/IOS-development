//
//  CNFHistoryCell.h
//  通讯录
//
//  Created by gwp on 15-5-20.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNFHistory;

@interface CNFHistoryCell : UITableViewCell
@property (nonatomic, strong) CNFHistory *history;


/**
 *  快速返回一个Cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
