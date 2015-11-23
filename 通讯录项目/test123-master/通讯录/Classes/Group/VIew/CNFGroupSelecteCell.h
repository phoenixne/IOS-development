//
//  CNFGroupSelecteCell.h
//  通讯录
//
//  Created by singer on 15-5-20.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNFPerson;

@interface CNFGroupSelecteCell : UITableViewCell

/**
 *  快速返回一个Cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic , strong) CNFPerson *person;

@end
