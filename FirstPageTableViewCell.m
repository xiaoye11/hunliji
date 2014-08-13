//
//  FirstPageTableViewCell.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "FirstPageTableViewCell.h"

@implementation FirstPageTableViewCell

- (void)dealloc
{
    [_bigImage release];
    [_smallImageOne release];
    [_smallImageTwo release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.7, 145)];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bigImage.frame.size.height - 20, self.bigImage.frame.size.width, 20)];
        [self.label setTextColor:[UIColor whiteColor]];
        UIColor *color = [UIColor colorWithRed:150 green:160 blue:150 alpha:0.4];
        [self.label setBackgroundColor:color];
        [self.bigImage addSubview:self.label];
                [self.contentView addSubview: self.bigImage];
        
        self.smallImageOne = [[UIImageView alloc] initWithFrame:CGRectMake(self.bigImage.frame.size.width + 5, 0, self.frame.size.width *0.3, 66)];
                [self.contentView addSubview:self.smallImageOne];
        
        self.smallImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(self.bigImage.frame.size.width + 5, self.smallImageOne.frame.size.height + 6, self.frame.size.width * 0.3, 70)];
        
        [self.contentView addSubview:self.smallImageTwo];
        
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
