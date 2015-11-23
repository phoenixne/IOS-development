//
//  CNFContactCell.h
//  通讯录
//
//  Created by gwp on 15-5-21.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNFPerson;

@interface CNFContactCell : UITableViewCell

/**
 *  快速返回一个Cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic , strong) CNFPerson *person;


@end
