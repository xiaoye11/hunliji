//
//  StoryTableViewCell.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-9.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "StoryTableViewCell.h"

@implementation StoryTableViewCell

- (void)dealloc
{
    [_bigImage release];
    [_label release];
    [_smallImage release];
    [_smallLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 190)];
        self.smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 130, 30, 30)];
        self.smallImage.layer.cornerRadius = self.smallImage.frame.size.width / 2;
        self.smallImage.layer.masksToBounds = YES;
        [self.bigImage addSubview:self.smallImage];
        
        UIFont *font =[UIFont fontWithName:@"Avenir" size:14];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bigImage.frame.size.height - 20, self.bigImage.frame.size.width, 20)];
        [self.label setFont:font];
        [self.label setTextColor:[UIColor whiteColor]];
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self.label setBackgroundColor:color];
        
        UIImageView *imag = [[UIImageView alloc] initWithFrame:CGRectMake(265, 3, 15, 15)];
        [imag setImage:[UIImage imageNamed:@"praiseMWhite.png"]];
        [self.label addSubview:imag];
        
        self.smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 3, 20, 15)];
        [self.smallLabel setTextColor:[UIColor whiteColor]];
        [self.smallLabel setFont:font];
        [self.label addSubview:self.smallLabel];
        
        [self.bigImage addSubview:self.label];
        [self.contentView addSubview: self.bigImage];
        
        [self.smallLabel release];
        [self.bigImage release];
        [self.smallImage release];
        [self.label release];
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
