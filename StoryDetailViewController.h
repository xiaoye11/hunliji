//
//  StoryDetailViewController.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-9.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDetailViewController : UIViewController

@property (nonatomic, copy) NSString *stringId;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableDictionary *dictionaty;
@end
