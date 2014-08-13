//
//  CollecViewController.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollecViewController : UIViewController

//滚动小导航的scrollView
@property (nonatomic , retain) UIScrollView *smallScrollView;

//整个大作品页和商家页的大ScrollView
@property (nonatomic , retain) UIScrollView *scrollView;

//作品页
@property (nonatomic , retain) UITableView *tableViewOne;

//商家页
@property (nonatomic , retain) UITableView *tableViewTwo;

//tableView.tag == 100 的大数组
@property (nonatomic , retain) NSMutableArray *tableArray;

//世界列表下拉框
@property (nonatomic , retain) UIView *anotherView;

@property (nonatomic , retain) UIView *secondView;
//tableView.tag == 102 的数组
@property (nonatomic , retain) NSMutableArray *arr;

//用来接收商家页面的JSON对象
@property (nonatomic , retain) NSMutableDictionary *dic;

//用来接受作品页面的JSON对象
@property (nonatomic , retain) NSMutableDictionary *dictionary;

@property (nonatomic , retain) NSMutableArray *array;
@end
