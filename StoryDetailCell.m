//
//  StoryDetailCell.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-9.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "StoryDetailCell.h"

@implementation StoryDetailCell
- (void)dealloc
{
    [_bigImage release];
    [_titleLabel release];
    [_description release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        
        self.description = [[UILabel alloc] init];
        self.description.numberOfLines = 0;
        self.description.textColor = [UIColor grayColor];
        UIFont *font = [UIFont fontWithName:@"Avenir" size:14];
        [self.description setFont:font];

        [self.contentView addSubview:self.description];
        [self.contentView addSubview:self.bigImage];
        [self.description release];
        [self.bigImage release];
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
