//
//  MerchantsViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-10.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "MerchantsViewController.h"
#import "AsynGETConnect.h"
#import "UIImageView+WebCache.h"
#import "MerchantsTableViewCell.h"
@interface MerchantsViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MerchantsViewController

- (void)dealloc
{
    [_tableView release];
    [_dictionary release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionary];
        self.dic = [NSMutableDictionary dictionary];
     }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    [self getConnection];
}
-(void)createTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.rowHeight = 400;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView release];
}

#pragma mark 获得网络链接
-(void)getConnection
{
    AsynGETConnect *async = [[AsynGETConnect alloc] init];
   
    NSString *path = [NSString stringWithFormat:@"http://marrymemo.com/merchants/%@.json",self.stringId];
    NSLog(@"path ====== %@", path);
    [async startConnect:path dictionary:NULL block:^(NSData *data) {
        self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *str = [self.dictionary objectForKey:@"detail"];
        NSData *dataD = [str dataUsingEncoding:NSUTF8StringEncoding];
        self.dic = [NSJSONSerialization JSONObjectWithData:dataD options:NSJSONReadingMutableContainers error:nil];
        [self.tableView reloadData];
        [self createTableViewHeaderView];
    }];
    [async release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 设置tableView头信息
-(void)createTableViewHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    UIImageView *imag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 80)];
    NSString *stringUrl = [self.dictionary objectForKey:@"logo_path"];
    NSURL *url = [NSURL URLWithString:stringUrl];
    [imag setImageWithURL:url];
    [headerView addSubview:imag];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 200, 25)];
    [titleLabel setText:[self.dictionary objectForKey:@"name"]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont fontWithName:@"Avenir" size:15]];
    [headerView addSubview:titleLabel];
    [titleLabel release];
    
    NSString *s = [[[self.dictionary objectForKey:@"properties"] objectAtIndex:0] objectForKey:@"name"];
    
    UILabel *property = [[UILabel alloc] initWithFrame:CGRectMake(140, 50, 100, 20)];
    [property setTextAlignment:NSTextAlignmentLeft];
    [property setTextColor:[UIColor grayColor]];
    [property setFont:[UIFont fontWithName:@"Avenir" size:12]];
    [property setText:[NSString stringWithFormat:@"#%@",s]];
    [headerView addSubview:property];
    [property release];
    
    UILabel *fans = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 80, 20)];
    [fans setTextAlignment:NSTextAlignmentLeft];
    [fans setTextColor:[UIColor grayColor]];
    [fans setFont:[UIFont fontWithName:@"Avenir" size:12]];
    [fans setText:[NSString stringWithFormat:@"粉丝 %@ 个", [self.dictionary objectForKey:@"fans_count"]]];
    [headerView addSubview:fans];
    [fans release];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 140, 25)];
    [leftButton setBackgroundColor:[UIColor cyanColor]];
    [leftButton setTitle:@"详细信息" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftButton];
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 80, 150, 25)];
    [rightButton setBackgroundColor:[UIColor whiteColor]];
    [rightButton setTitle:@"作品" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:rightButton];
    
    [headerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 135)];
    [self.view addSubview:headerView];
    [headerView release];
}
-(void)leftButtonAction:(id)sender
{
    
}
-(void)rightButtonAction:(id)sender
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    MerchantsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[MerchantsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify] autorelease];
    }

    [cell.location setText:[self.dic objectForKey:@"地址"]];
    [cell.introduce setText:[self.dic objectForKey:@"简介"]];
    [cell.blog setText:[self.dic objectForKey:@"微博"]];
    [cell.qq setText:[self.dic objectForKey:@"QQ"]];
    [cell.wechat setText:[self.dic objectForKey:@"微信"]];
    [cell.city setText:[self.dic objectForKey:@"城市"]];
    return cell;
}

@end
