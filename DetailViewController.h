//
//  DetailViewController.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-8.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, copy) NSString *stringId;

@property (nonatomic, retain) NSMutableDictionary *dictronary;

@property (nonatomic, retain) NSString *path;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, retain) UIView *footer;
@end
