//
//  CNFPersonViewCell.m
//  通讯录
//
//  Created by gwp on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFPersonViewCell.h"
#import "CNFPerson.h"
#import "CNFPhoneNumber.h"

@interface CNFPersonViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
- (IBAction)sendMessageClick:(UIButton *)sender;
- (IBAction)callClick:(UIButton *)sender;


@end

@implementation CNFPersonViewCell
#pragma mark - 初始化方法
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"person";
    CNFPersonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CNFPersonViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPerson:(CNFPerson *)person{
    _person = person;
    
    self.nameLabel.text = person.fullName;
    self.phoneLabel.text = [person valueForKeyPath:@"firstPhoneNumber.value"];
    
}

#pragma mark - 点击事件
- (IBAction)sendMessageClick:(UIButton *)sender {
    [_delegate personViewCell:self sendMessageTo:self.person];
    
}

- (IBAction)callClick:(UIButton *)sender {
    [_delegate personViewCell:self callTo:self.person];
    
    
}
@end
