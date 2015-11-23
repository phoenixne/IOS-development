//
//  CNFPersonViewCell.h
//  通讯录
//
//  Created by gwp on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNFPerson, CNFPersonViewCell;

@protocol CNFPersonViewCellDelegate <NSObject>
@required
- (void)personViewCell:(CNFPersonViewCell *)cell callTo:(CNFPerson *)person;
- (void)personViewCell:(CNFPersonViewCell *)cell sendMessageTo:(CNFPerson *)person;

@end


@interface CNFPersonViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CNFPerson *person;
@property (nonatomic, weak) id<CNFPersonViewCellDelegate> delegate;
@end
