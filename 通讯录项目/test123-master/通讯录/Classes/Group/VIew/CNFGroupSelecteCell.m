//
//  CNFGroupSelecteCell.m
//  通讯录
//
//  Created by singer on 15-5-20.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFGroupSelecteCell.h"
#import "CNFPerson.h"
#import "CNFPhoneNumber.h"

@interface CNFGroupSelecteCell ()

@end

@implementation CNFGroupSelecteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"selecetCell";
    CNFGroupSelecteCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CNFGroupSelecteCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
        // 设置选中样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.1;
        [self.contentView addSubview:line];
        [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [line autoSetDimension:ALDimensionHeight toSize:1];
        
    }
    return self;
}

- (void)setPerson:(CNFPerson *)person
{
    _person = person;
    self.textLabel.text = person.fullName;
    self.detailTextLabel.text = person.firstPhoneNumber.value;
}

@end
