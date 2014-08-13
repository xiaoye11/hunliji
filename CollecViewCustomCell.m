//
//  CollecViewCustomCell.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-9.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "CollecViewCustomCell.h"

@implementation CollecViewCustomCell

- (void)dealloc
{
    [_titleImage release];
    [_description release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
        //图片右下角的评论和点赞栏
//        self.viewButton = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, self.titleImage.frame.size.height - 100, 60, 20)];
//        self.viewButton
//        UIButton *readButton = [UIButton alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        self.description = [[UILabel alloc] init];
        [self.description setTextColor:[UIColor grayColor]];
        UIFont *font = [UIFont fontWithName:@"Avenir" size:14];
        [self.description setFont:font];
        [self.contentView addSubview:self.titleImage];
        [self.contentView addSubview:self.description];
        [self.titleImage release];
        [self.description release];
        
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
