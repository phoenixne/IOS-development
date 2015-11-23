//
//  CNFGroupHeaderView.m
//  通讯录
//
//  Created by singer on 15-5-19.
//  Copyright (c) 2015年 cnf. All rights reserved.
//

#import "CNFGroupHeaderView.h"
#import "CNFPeopleGroup.h"

@interface CNFGroupHeaderView()
@property (nonatomic, weak) UILabel *countView;
@property (nonatomic, weak) UIButton *nameView;
@end

@implementation CNFGroupHeaderView

+ (instancetype)viewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    CNFGroupHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[CNFGroupHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (void)setGroup:(CNFPeopleGroup *)group
{
    _group = group;
    
    // 1.设置按钮文字(组名)
    [self.nameView setTitle:group.name forState:UIControlStateNormal];
    
    // 2.设置好友数
    self.countView.text = [NSString stringWithFormat:@"%d",group.persons.count];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        // 1.添加按钮
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮内部的左边箭头图片
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
        //        nameView.imageEdgeInsets
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮内部的imageView的内容模式为居中
        nameView.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        nameView.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        
        // 2.添加好友数
        UILabel *countView = [[UILabel alloc] init];
        countView.textAlignment = NSTextAlignmentRight;
        countView.textColor = [UIColor grayColor];
        [self.contentView addSubview:countView];
        self.countView = countView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置按钮的frame
    self.nameView.frame = self.bounds;
    
    // 2.设置好友数的frame
    CGFloat countY = 0;
    CGFloat countH = self.frame.size.height;
    CGFloat countW = 150;
    CGFloat countX = self.frame.size.width - 10 - countW;
    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}

#pragma mark - 方法监听
/**
 *  监听组名按钮的点击
 */
- (void)nameViewClick
{
    // 1.修改组模型的标记(状态取反)
    self.group.opened = !self.group.isOpened;
    
    // 2.刷新表格
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickedNameView:)]) {
        [self.delegate headerViewDidClickedNameView:self];
    }
}

/**
 *  当一个控件被添加到父控件中就会调用
 */
- (void)didMoveToSuperview
{
    if (self.group.opened) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
