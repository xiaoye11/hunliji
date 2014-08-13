//
//  SecondViewTableViewCell.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "SecondViewTableViewCell.h"

@implementation SecondViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 180, 90)];
        [self.contentView addSubview:self.image];
        
        
        UIFont *font = [UIFont fontWithName:@"Avenir" size:14];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.frame.size.width, 0, self.frame.size.width - self.image.frame.size.width, 30)];
        [self.titleLabel setFont:font];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.frame.size.width, 40, self.frame.size.width - self.image.frame.size.width, 20)];
        [self.detailLabel setTextColor:[UIColor grayColor]];
        [self.detailLabel setFont:font];
        [self.contentView addSubview:self.detailLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.frame.size.width, 70, self.frame.size.width - self.image.frame.size.width - 100, 20)];
        [self.numLabel setFont:font];
        [self.numLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.numLabel];
        
        self.fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 70, 100, 20)];
        [self.fansLabel setTextColor:[UIColor blackColor]];
        [self.fansLabel setFont:font];
        [self.contentView addSubview:self.fansLabel];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
