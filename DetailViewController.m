//
//  DetailViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-8.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "DetailViewController.h"
#import "CollecViewCustomCell.h"
#import "AsyncGETConnectionForWorks.h"
#import "UIImageView+WebCache.h"
#import "MarryDao.h"
#import "Collect.h"
#import "LoginViewController.h"
#import "MerchantsViewController.h"
#define AIMAGE 10
#define TITLE_LABEL 11
#define WORKS_COUNT 12
@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate, AsynGETConnectForWorksDelegate>

@end

@implementation DetailViewController
- (void)dealloc
{
    [_dictronary release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dictronary = [NSMutableDictionary dictionary];
        self.num = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    [self getAsynConnectionWithWorks];
    [self createNavigation];
    [self searchFromDatabase];
    [self createTableView];
}
#pragma mark 网络请求解析作品详情页面
-(void)getAsynConnectionWithWorks
{
    AsyncGETConnectionForWorks *async = [[AsyncGETConnectionForWorks alloc] init];
    async.delegate = self;
    self.path = [NSString stringWithFormat:@"http://marrymemo.com/opus/%@.json",self.stringId];
    [async startConnectForWorks:self.path dictionary:NULL];
    [async release];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    NSLog(@"%@", path);
}
#pragma mark 创建自定导航栏
-(void)createNavigation
{
   
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 44)];
    UIButton *pinButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 5, 30, 30)];
    [pinButton setImage:[UIImage imageNamed:@"commentMWhite.png"] forState:UIControlStateNormal];
    [pinButton addTarget:self action:@selector(pinButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:pinButton];
    
    UIButton *collectButton = [[UIButton alloc] initWithFrame:CGRectMake(205, 5, 30, 30)];
    [collectButton setImage:[UIImage imageNamed:@"opuCollectIcon@2x.png"] forState:UIControlStateNormal];
    //收藏按钮tag值标记
    [collectButton setTag:100];
    [collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:collectButton];
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 5, 30, 30)];
    [shareButton setImage:[UIImage imageNamed:@"shareLarge.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:shareButton];
    
    self.navigationItem.titleView = naviView;
   
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    [cancelButton setImage:[UIImage imageNamed:@"backArrowWhite@2x.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *but = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = but;
}
-(void)backAction:(id)sender
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 查找是否收藏过
-(void)searchFromDatabase
{
    if ([MarryDao select:self.path]) {
        NSLog(@"返回YES");
        UIButton *button = (UIButton *)[self.navigationItem.titleView viewWithTag:100];
        [button setImage:[UIImage imageNamed:@"collectSWhite@2x.png"] forState:UIControlStateNormal];
        NSLog(@"更改button");
    }else
    {
        NSLog(@"返回No");
        UIButton *button = (UIButton *)[self.navigationItem.titleView viewWithTag:100];
        [button setImage:[UIImage imageNamed:@"opuCollectIcon@2x.png"] forState:UIControlStateNormal];
    }
}
-(void)pinButtonAction:(id)sender
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    [login release];
}
#pragma mark 收藏功能
-(void)collectButtonAction:(id)sender
{
    
    if (![MarryDao select:self.path]) {
        Collect *collect = [[Collect alloc] init];
        collect.collectId = [self.stringId intValue];
        collect.httploc = self.path;
        [MarryDao insert:collect];
        UIButton *button = (UIButton *)[self.navigationItem.titleView viewWithTag:100];
        [button setImage:[UIImage imageNamed:@"collectSWhite@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        UIButton *button = (UIButton *)[self.navigationItem.titleView viewWithTag:100];
        [button setImage:[UIImage imageNamed:@"opuCollectIcon@2x.png"] forState:UIControlStateNormal];
        [MarryDao delete:self.path];
    }
}
-(void)shareButtonAction:(id)sender
{
    [self pinButtonAction:sender];
}
#pragma mark 接收网络请求的响应信息
-(void)sendDataFrowWoks:(NSData *)data
{
    self.dictronary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
    [self.tableView reloadData];
    [self createTableViewHeaderView];
    [self createFooter];
    
}

#pragma mark 创建下面商家提示条
-(void)createFooter
{
    self.footer = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    [self.footer setBackgroundColor:[UIColor whiteColor]];
    UIImageView *aImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, self.self.footer.frame.size.height)];
    [aImage setTag:AIMAGE];
     [aImage setImageWithURL:[[self.dictronary objectForKey:@"merchant"] objectForKey:@"avatar"]];
    [self.footer addSubview:aImage];
    [aImage release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(aImage.frame.size.width + 5, 0, 180, self.footer.frame.size.height)];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:16]];
    [titleLabel setText:[[self.dictronary objectForKey:@"merchant"] objectForKey:@"name"]];
    [titleLabel setTag:TITLE_LABEL];
    [self.footer addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *works = [[UILabel alloc] initWithFrame:CGRectMake( 200, 0, 80, self.footer.frame.size.height)];
    [works setTextColor:[UIColor blackColor]];
    [works setFont:[UIFont systemFontOfSize:15]];
    [works setTag:WORKS_COUNT];
    NSString *str = [NSString stringWithFormat:@"作品 %@个", [[self.dictronary objectForKey:@"merchant"] objectForKey:@"opu_count"]];
    [works setText: str];

    [self.footer addSubview:works];
    [works release];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
    [nextButton setImage:[UIImage imageNamed:@"cardRight@2x.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(intoMerchants) forControlEvents:UIControlEventTouchUpInside];
    [self.footer addSubview:nextButton];
    [nextButton release];
    
//    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
//    [img setImage:[UIImage imageNamed:@"cardRight@2x.png"]];
//    [self.footer addSubview:img];
//    [img release];
    
    [self.view addSubview:self.footer];
    [self.footer release];
}
#pragma mark 进商家详情
-(void)intoMerchants
{
    MerchantsViewController *merchants = [[MerchantsViewController alloc] init];
    merchants.stringId =[[self.dictronary objectForKey:@"merchant"] objectForKey:@"id"];
    NSLog(@"id : %@", [[self.dictronary objectForKey:@"merchant"]  objectForKey:@"id"]);
    [self.navigationController pushViewController:merchants animated:YES];
    [merchants release];
}
#pragma mark 设置tableView头信息
-(void)createTableViewHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 20)];
    [titleLabel setText:[[self.dictronary objectForKey:@"opu"] objectForKey:@"title"]];
     [titleLabel setTextColor:[UIColor grayColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
     [titleLabel setFont:[UIFont fontWithName:@"Avenir" size:14]];
    [headerView addSubview:titleLabel];
    [titleLabel release];
    
    NSString *s = [[self.dictronary objectForKey:@"opu"] objectForKey:@"description"];
    
    UILabel *description = [[UILabel alloc] init];
    [description setTextAlignment:NSTextAlignmentLeft];
     CGSize size = [self getTheLabelHight:s label:description];
    [description setFrame:CGRectMake(5, 25, size.width, size.height)];
    
    [description setTextColor:[UIColor grayColor]];
    
    [headerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, titleLabel.frame.size.height + description.frame.size.height - 10)];
    [headerView addSubview:description];
    
    [description release];

    [self.tableView setTableHeaderView:headerView];
    [headerView release];
}

#pragma mark UILabel自适应高度
-(CGSize)getTheLabelHight:(NSString *)str label:(UILabel *)testlable
{
    testlable.numberOfLines =0;
    
    UIFont * tfont = [UIFont systemFontOfSize:12];
    
    testlable.font = tfont;
    
    testlable.lineBreakMode =NSLineBreakByTruncatingTail ;
    
    testlable.text = str ;
    [self.view addSubview:testlable];
    
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    
    CGSize size = CGSizeMake(300.f, MAXFLOAT);

    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    return actualsize;
}
#pragma mark 创建tableView
-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.rowHeight = 280;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dictronary objectForKey:@"items"] count] - 1;
}

#pragma mark 显示cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify =@"cellIdentify";
    
    CollecViewCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[CollecViewCustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify] autorelease];
    }
    NSArray *arr = [NSArray arrayWithArray:[self.dictronary objectForKey:@"items"]];
    NSURL *url = [NSURL URLWithString:[[arr objectAtIndex:indexPath.row] objectForKey:@"path"]];
    NSString *stringH =[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] objectForKey:@"height"]];
    CGFloat heightP = [stringH floatValue];
    
    NSString *stringW =[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] objectForKey:@"width"]];
    CGFloat width = [stringW floatValue];
    
    CGFloat height = heightP / width * self.view.frame.size.width;
    
    [cell.titleImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    
    NSString *s = [[arr objectAtIndex:indexPath.row] objectForKey:@"description"];
    CGSize size = [self getTheLabelHight:s label:cell.description];
    [cell.description setFrame:CGRectMake(0, cell.titleImage.frame.size.height + 5, self.view.frame.size.width , size.height + 5)];
    [cell addSubview:cell.description];
    [cell.description setText:[[arr objectAtIndex:indexPath.row] objectForKey:@"description"]];
    
    [cell.titleImage setImageWithURL:url];
    return cell;
}

#pragma mark 自动调整cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollecViewCustomCell *collec = [[CollecViewCustomCell alloc] init];
    NSArray *arr = [NSArray arrayWithArray:[self.dictronary objectForKey:@"items"]];
    NSString *stringH =[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] objectForKey:@"height"]];
    CGFloat heightP = [stringH floatValue];
    
    NSString *stringW =[NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] objectForKey:@"width"]];
    CGFloat width = [stringW floatValue];
    
    CGFloat height = heightP / width * self.view.frame.size.width;
    NSString *s = [[arr objectAtIndex:indexPath.row] objectForKey:@"description"];
    CGSize size = [self getTheLabelHight:s label:collec.description];
    return height + size.height + 15;
}

@end
