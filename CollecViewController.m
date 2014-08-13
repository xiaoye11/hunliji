//
//  CollecViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "CollecViewController.h"
//SDWebImage
#import "UIImageView+WebCache.h"
#import "FirstPageTableViewCell.h"
#import "SecondViewTableViewCell.h"
#import "CountryModel.h"
#import "CityModel.h"
#import "xmlParser.h"
//网络请求
#import "AsynGETConnect.h"
//解析作品页的网络请求
#import "AsyncGETConnectionForWorks.h"
#import  "DetailViewController.h"
#import "LoginViewController.h"
#import "MerchantsViewController.h"
#define WORKS 100
#define MERCHANTS 101
#define ANOTHERVIEW 102
#define WORLD 103
#define SORT 105
@interface CollecViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, XMLParserDelegate, AsynGETConnectForWorksDelegate>

@end

@implementation CollecViewController
- (void)dealloc
{
    [_scrollView release];
    [_tableViewOne release];
    [_tableViewOne release];
    [_tableArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableArray = [NSMutableArray array];
        self.arr = [NSMutableArray array];
        self.dic = [[NSMutableDictionary alloc] init];
        self.dictionary = [[NSMutableDictionary alloc] init];
        
        self.array = [NSMutableArray array];
        
        NSString *str1 = @"默认排序";
        NSString *str2 = @"点赞最多";
        NSString *str3 = @"收藏最多";
        [self.array addObject:str1];
        [self.array addObject:str2];
        [self.array addObject:str3];
        [str1 release];
        [str2 release];
        [str3 release];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createScrollView];
    [self createNav];
    [self createSmallScrollView];
//    [self transformFromJSON];
    [self getAsynConnectionWithWorks];
    [self getAsynConnection];
}
#pragma mark 网络请求解析作品页面
-(void)getAsynConnectionWithWorks
{
    AsyncGETConnectionForWorks *async = [[AsyncGETConnectionForWorks alloc] init];
    async.delegate = self;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"page"];
    [async startConnectForWorks:@"http://marrymemo.com/opus.json" dictionary:dic];
    [async release];
}
#pragma mark 作品页面解析协议
-(void)sendDataFrowWoks:(NSData *)data
{
    self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];

    [self.tableViewOne reloadData];
}

#pragma mark 网络请求解析商家页面.
-(void)getAsynConnection
{
    AsynGETConnect *async = [[AsynGETConnect alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"page"];
   [async startConnect:@"http://marrymemo.com/merchants.json" dictionary:dic block:^(NSData *data) {
       self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       [self.tableViewTwo reloadData];
   }];
    [async release];
}
#pragma mark 创建下拉的世界列表View
-(void)createView
{
    self.anotherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.anotherView setBackgroundColor:[UIColor clearColor]];
    [self.anotherView setTag:102];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.anotherView.frame.size.width, self.view.frame.size.height - 310) style:UITableViewStylePlain];
    [tableView setTag:WORLD];
    tableView.rowHeight = 25;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.anotherView addSubview:tableView];
    [self.view addSubview:self.anotherView];
    [tableView release];
    [self.anotherView release];
}


-(void)xmlAction:(id)sender
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程内操作
        dispatch_async(dispatch_get_main_queue(), ^{
            xmlParser *sax = [[xmlParser alloc] init];
            sax.delegate = self;
            [sax writeFromXML:@"area"];
        });
    });

}
#pragma mark 世界列表的视图
-(void)sentModelArrayToMain:(NSMutableArray *)array
{
    self.arr = array;
    [self createView];
}
#pragma mark 监听view的触摸事件, 撤销view
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.secondView removeFromSuperview];
    [self.anotherView removeFromSuperview];
}

#pragma mark 创建导航栏
-(void)createNav
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    //设置segment
    NSArray *segmentArray = [NSArray arrayWithObjects:@"作品",@"商家", nil];
    NSLog(@"%@", segmentArray);
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:segmentArray];
    [segment setFrame:CGRectMake(150, 0, 100, 30)];
    [segment setSelectedSegmentIndex:0];
    [segment setMomentary:YES];
    [segment addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;

    //设置右收藏按钮
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectButton setFrame:CGRectMake(0, 0, 20, 20)];
    [collectButton setBackgroundImage:[UIImage imageNamed:@"storySortIcon@2x.png"] forState:UIControlStateNormal];
    [collectButton setTag:100];
    [collectButton.titleLabel setFont:[UIFont fontWithName:@"Avenir" size:14]];
    [collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemButton = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    self.navigationItem.rightBarButtonItem = itemButton;
    
   //世界按钮
    UIButton *worldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [worldButton setFrame:CGRectMake(0, 0, 40, 40)];
    [worldButton setTag:99];
    [worldButton setTitle:@"世界" forState:UIControlStateNormal];
    [worldButton.titleLabel setFont:[UIFont fontWithName:@"Avenir" size:14]];
    
    [worldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [worldButton addTarget:self action:@selector(xmlAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *it = [[UIBarButtonItem alloc] initWithCustomView:worldButton];
    self.navigationItem.leftBarButtonItem = it;
}
-(void)selectedAction:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if (segment.selectedSegmentIndex == 0) {
        [self.tableViewOne reloadData];
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }
    if (segment.selectedSegmentIndex == 1) {
        [self.tableViewTwo reloadData];
        [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
    }
    
}
-(void)collectButtonAction:(id)sender
{
    [self createSortView];
}
-(void)loginAction:(id)sender
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    [login release];
}

#pragma mark 创建下拉的排序列表View
-(void)createSortView
{
    self.secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.secondView setBackgroundColor:[UIColor clearColor]];
    [self.secondView setTag:102];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.secondView.frame.size.width, 90) style:UITableViewStylePlain];
    [tableView setTag:SORT];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    tableView.rowHeight = 30;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.secondView addSubview:tableView];
    [self.view addSubview:self.secondView];
    [tableView release];
    [self.secondView release];
}
#pragma mark 作品按钮点击事件
-(void)leftButtonAction:(id)sender
{
    [self.tableViewOne reloadData];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}
#pragma mark 商家按钮点击事件
-(void)rightButtonAction:(id)sender
{
//    UIButton *button = (UIButton *)sender;
//    [button setBackgroundImage:[UIImage imageNamed:@"lefrBurronLight.png"] forState:UIControlStateNormal];
    [self.tableViewTwo reloadData];
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
}
#pragma mark 创建ScrollView
-(void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height - 49)];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width * 2, 0)];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setBounces:NO];

    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];

    [self createTableViewOne];
    [self createTableViewTwo];
    
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView release];
}
#pragma mark 创建图片导航栏的scrollView
-(void)createSmallScrollView
{
    
    self.smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [self.smallScrollView setContentSize:CGSizeMake(self.view.frame.size.width + 260, self.smallScrollView.frame.size.height)];
    [self.smallScrollView setPagingEnabled:YES];
    [self.smallScrollView setBounces:NO];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部", @"婚礼策划", @"婚纱摄影", @"摄影", @"摄像",@"化妆",@"司仪", nil];
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + i * 80, 0, 70, 30)];
        [label setFont:[UIFont fontWithName:@"Avenir" size:14]];
        NSString *str = [array objectAtIndex:i];
        [label setText:str];
        [label setTextColor:[UIColor grayColor]];
        [self.smallScrollView addSubview:label];
    }
    
    [self.smallScrollView setShowsHorizontalScrollIndicator:NO];
    [self.smallScrollView setShowsVerticalScrollIndicator:NO];
    
    self.smallScrollView.delegate = self;
    [self.view addSubview:self.smallScrollView];
    [self.smallScrollView release];
}
#pragma mark Scroll偏移量来改变按钮的点击状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == self.view.frame.size.width) {
        [((UIButton *)[self.view viewWithTag:11]) setBackgroundColor:[UIColor greenColor]];
    }
     [((UIButton *)[self.view viewWithTag:10]) setBackgroundColor:[UIColor greenColor]];
    
}
#pragma mark 创建第一个TableVie(作品页展示)
-(void)createTableViewOne
{
    self.tableViewOne = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    self.tableViewOne.rowHeight = 160;
    self.tableViewOne.delegate = self;
    self.tableViewOne.dataSource = self;
    [self.tableViewOne setTag:WORKS];
    
    [self.scrollView addSubview:self.tableViewOne];
}

#pragma mark 创建第二个TableView(商家页展示)
-(void)createTableViewTwo
{
    self.tableViewTwo = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    
    self.tableViewTwo.rowHeight = 90;
    self.tableViewTwo.delegate = self;
    self.tableViewTwo.dataSource = self;
    [self.tableViewTwo setTag:MERCHANTS];

    [self.scrollView addSubview:self.tableViewTwo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 103) {
        return [self.arr count];
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == WORKS) {
        return [[self.dictionary objectForKey:@"opus"] count];
    }
    if (tableView.tag == MERCHANTS) {
       return [[self.dic objectForKey:@"merchants"] count];
    }
    if (tableView.tag == WORLD) {
        
    CountryModel *country = [self.arr objectAtIndex:section];

    return [country.cityArray count];
    }
    if (tableView.tag == SORT) {
    return [self.array count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == WORKS) {
        static NSString *cellIdentify = @"cellIdentify";
        FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[[[FirstPageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify] autorelease] autorelease];
        }
        NSArray *arrImage = [NSArray arrayWithArray:[[[self.dictionary objectForKey:@"opus"] objectAtIndex:indexPath.row] objectForKey:@"items"]];
        if ([arrImage count] == 3) {
            NSURL *url1 =[NSURL URLWithString:[[arrImage objectAtIndex:0] objectForKey:@"path"]];
            NSURL *url2 =[NSURL URLWithString:[[arrImage objectAtIndex:1] objectForKey:@"path"]];
            NSURL *url3 =[NSURL URLWithString:[[arrImage objectAtIndex:2] objectForKey:@"path"]];
            NSString *str =[NSString stringWithString:[[[self.dictionary objectForKey:@"opus"] objectAtIndex:indexPath.row] objectForKey:@"title"]];
            
            [cell.bigImage setImageWithURL:url1];
            [cell.label setText:str];
            [cell.smallImageOne setImageWithURL:url2];
            [cell.smallImageTwo setImageWithURL:url3];
        }
    
        return cell;
    }
    if (tableView.tag == MERCHANTS) {
        static NSString *cellId = @"cellId";
        SecondViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[SecondViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId] autorelease];
        }
        NSString *strFans =[NSString stringWithFormat:@"粉丝 %@ 个",[[[self.dic objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"fans_count"]];
        NSString *strWork =[NSString stringWithFormat:@"作品 %@ 个",[[[self.dic objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"opu_count"]];
        NSString *strDetail = [NSString stringWithFormat:@"# %@",[[[[[self.dic objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"properties"] objectAtIndex:0] objectForKey:@"name"]];
        NSString *strTitle =[NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
        NSString *strImage =[NSString stringWithFormat:@"%@",[[[self.dic objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"logo_path"]];
        [cell.image setImageWithURL:[NSURL URLWithString:strImage]];
        [cell.titleLabel setText:strTitle];
        [cell.detailLabel setText:strDetail];
        [cell.numLabel setText:strWork];
        [cell.fansLabel setText:strFans];
        
        return cell;
    }
    if (tableView.tag == WORLD) {
        static NSString *cellIdenti = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenti];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdenti] autorelease];
        }
        
        CountryModel *country =[self.arr objectAtIndex:indexPath.section];
        CityModel *city = [country.cityArray objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:city.name];
        [cell.detailTextLabel setText:city.code];
        
        return cell;
    }
    if (tableView.tag == SORT) {
        static NSString *temp = @"tempCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:temp];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:temp] autorelease];
        }
        [cell.textLabel setText:[self.array objectAtIndex:indexPath.row]];
        return cell;
    }
    return NULL;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 103) {
        CountryModel *country = (CountryModel *)[self.arr objectAtIndex:section];
        return country.name;
    }
    return NULL;
}

#pragma mark 点击进入详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == WORKS) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        
        detail.stringId = [[[self.dictionary objectForKey:@"opus"] objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:detail animated:YES];
        [detail release];
    }
    if (tableView.tag == MERCHANTS) {
        MerchantsViewController *merchants = [[MerchantsViewController alloc] init];
        merchants.stringId =[[[self.dic objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"mid"];
        NSLog(@"id : %@", [[[self.dictionary objectForKey:@"merchants"] objectAtIndex:indexPath.row] objectForKey:@"mid"]);
        [self.navigationController pushViewController:merchants animated:YES];
        [merchants release];
    }
}

@end
