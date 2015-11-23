//
//  CNFContactCell.m
//  通讯录
//
//  Created by gwp on 15-5-21.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFContactCell.h"
#import "CNFPerson.h"

@implementation CNFContactCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"selecetCell";
    CNFContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CNFContactCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
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
        
        // 设置选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setPerson:(CNFPerson *)person
{
    _person = person;
    self.textLabel.text = person.fullName;
}



@end
