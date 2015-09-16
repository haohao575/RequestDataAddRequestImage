//
//  TableViewCell.m
//  URLString
//
//  Created by tonghao on 15/8/10.
//  Copyright (c) 2015年 tonghao. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllView];
    }
    return self;
}
-(void)addAllView{
    self.imageVw  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 140, 80)];
    self.imageVw.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageVw];
    self.imageVw1  = [[UIImageView alloc]initWithFrame:CGRectMake(160, 10, 140, 80)];
    self.imageVw1.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageVw1];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
