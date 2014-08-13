//
//  CustomView.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-11.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 25, 25)];
        [self addSubview:self.img];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, self.frame.size.height)];
        [self.label setTextColor:[UIColor grayColor]];
        [self.label setFont:[UIFont fontWithName:@"Avenir" size:14]];
        [self addSubview:self.label];
        [self.label release];
        
        self.next = [[UIImageView alloc] initWithFrame:CGRectMake(270, 10, 10, 12)];
        [self.next setImage:[UIImage imageNamed:@"webNextGray.png"]];
        [self addSubview:self.next];
        [self.next release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
