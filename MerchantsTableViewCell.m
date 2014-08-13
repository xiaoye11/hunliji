//
//  MerchantsTableViewCell.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-10.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "MerchantsTableViewCell.h"

@implementation MerchantsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIFont *font = [UIFont fontWithName:@"Avenir" size:14];
        self.locationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 90)];
        [self.locationView setBackgroundColor:[UIColor whiteColor]];
        //位置文字描述
        self.location = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 240, 70)];
        self.location.numberOfLines = 0;
        self.location.textColor = [UIColor grayColor];
        [self.location setFont:font];
        [self.locationView addSubview:self.location];
        [self.location release];
        //位置图标
        self.locImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 7, 10)];
        [self.locImage setImage:[UIImage imageNamed:@"locationIcon.png"]];
        [self.locationView addSubview:self.locImage];
        //next图标
        self.nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 20, 7, 10)];
        [self.nextImage setImage:[UIImage imageNamed:@"webNextGray.png"]];
        [self.locationView addSubview:self.nextImage];
        //发私信按钮
        self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 60, 110, 20)];
        [self.leftButton setTitle:@"发私信" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [self.locationView addSubview:self.leftButton];
        //打电话按钮
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 60, 100, 20)];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightButton setTitle:@"打电话" forState:UIControlStateNormal];
        [self.rightButton setBackgroundColor:[UIColor greenColor]];
        [self.locationView addSubview:self.rightButton];
        
        [self.contentView addSubview:self.locationView];
        
        //简介
        UILabel *intro = [[UILabel alloc] initWithFrame:CGRectMake(0, self.locationView.frame.size.height, self.frame.size.width, 60)];
        intro.numberOfLines = 1;
        [intro setFont:font];
        intro.textAlignment = NSTextAlignmentLeft;
        intro.text = @"  简介";
        intro.textColor = [UIColor grayColor];
        
        self.introduce = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 60)];
        self.introduce.numberOfLines = 0;
        [self.introduce setFont:font];
        [self.introduce setTextColor:[UIColor grayColor]];
        [intro addSubview:self.introduce];
        [self addSubview:intro];
        
        //微博
        UILabel *blogB = [[UILabel alloc] initWithFrame:CGRectMake(0, self.locationView.frame.size.height + intro.frame.size.height, self.frame.size.width, 30)];
        blogB.numberOfLines = 1;
        [blogB setFont:font];
        blogB.textAlignment = NSTextAlignmentLeft;
        blogB.text = @"  微博";
        blogB.textColor = [UIColor grayColor];
        
        self.blog = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 30)];
        self.blog.numberOfLines = 1;
        [self.blog setFont:font];
        [self.blog setTextColor:[UIColor grayColor]];
        [blogB addSubview:self.blog];
        [self addSubview:blogB];
        //qq
        UILabel *qqlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.locationView.frame.size.height + intro.frame.size.height + blogB.frame.size.height, self.frame.size.width, 30)];
        qqlabel.numberOfLines = 1;
        [qqlabel setFont:font];
        qqlabel.textAlignment = NSTextAlignmentLeft;
        qqlabel.text = @"  QQ";
        qqlabel.textColor = [UIColor grayColor];
        
        self.qq = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 30)];
        self.qq.numberOfLines = 1;
        [self.qq setFont:font];
        [self.qq setTextColor:[UIColor grayColor]];
        [qqlabel addSubview:self.qq];
        [self addSubview:qqlabel];
        //微信
        UILabel *welabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.locationView.frame.size.height + intro.frame.size.height + blogB.frame.size.height + qqlabel.frame.size.height, self.frame.size.width, 30)];
        welabel.numberOfLines = 1;
        [welabel setFont:font];
        welabel.textAlignment = NSTextAlignmentLeft;
        welabel.text = @"  微信";
        welabel.textColor = [UIColor grayColor];
        
        self.wechat = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 30)];
        self.wechat.numberOfLines = 1;
        [self.wechat setFont:font];
        [self.wechat setTextColor:[UIColor grayColor]];
        [welabel addSubview:self.wechat];
        [self addSubview:welabel];
        //城市
        UILabel *citylabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.locationView.frame.size.height + intro.frame.size.height + blogB.frame.size.height +qqlabel.frame.size.height + welabel.frame.size.height, self.frame.size.width, 30)];
        citylabel.numberOfLines = 1;
        [citylabel setFont:font];
        citylabel.textAlignment = NSTextAlignmentLeft;
        citylabel.text = @"  城市";
        citylabel.textColor = [UIColor grayColor];
        
        self.city = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 30)];
        self.city.numberOfLines = 1;
        [self.city setFont:font];
        [self.city setTextColor:[UIColor grayColor]];
        [citylabel addSubview:self.city];
        [self addSubview:citylabel];
        
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
