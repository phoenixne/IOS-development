//
//  CNFHistoryCell.m
//  通讯录
//
//  Created by gwp on 15-5-20.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFHistoryCell.h"
#import "CNFHistory.h"

@implementation CNFHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.textColor = [UIColor grayColor];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"history";
    CNFHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CNFHistoryCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    }
    return cell;
}

- (void)setHistory:(CNFHistory *)history{
    _history = history;
    self.textLabel.text = history.name;
    
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    self.detailTextLabel.text = [fm stringFromDate:history.time];
    
    if (history.behavior == CNFHistoryBehaviorCall) {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QCall_ClosedFriends_call_icon"]];
    }else{
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ver_tab_recent_press"]];
    }
//    self.accessoryView.backgroundColor = [UIColor redColor];
//    self.accessoryView.size = CGSizeMake(60, 50);
}
@end
