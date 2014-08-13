//
//  MainViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "MainViewController.h"
#import "AsynGETConnect.h"
@interface MainViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation MainViewController

- (void)dealloc
{
    [_scroll1 release];
    [_smallScrollView release];
    [_tableView release];
    [_dic release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
    [self createNavigation];
}
-(void)getConnection
{
    AsynGETConnect *async = [[AsynGETConnect alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"page" forKey:@"1"];
    [async startConnect:@"http://marrymemo.com/products.json?page=2&user_id=(null)" dictionary:dic block:^(NSData *data) {
        self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }];
}
-(void)createNavigation
{
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setBackgroundImage:[UIImage imageNamed:@"storySortIcon@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = bar;
 
    
}
#pragma mark 创建ScrollView
-(void)createScrollView
{
    self.navigationController.navigationBar.translucent = NO;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height - 49)];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width * 3, self.scrollView.frame.size.height)];
    [self.scrollView setPagingEnabled:YES]; 
    [self.scrollView setBounces:NO];
    
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self createScroll1];
    [self createScroll2];
    [self createScroll3];
    [self createScroll4];
    [self createSmallScrollView];
    
    [self.scrollView setBackgroundColor:[UIColor redColor]];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView release];
}

#pragma mark 第一页左侧ScrollView
-(void)createScroll1
{
    self.scroll1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2.0, self.view.frame.size.height - 49)];
    [self.scroll1 setContentSize:CGSizeMake(self.view.frame.size.width / 2, self.view.frame.size.height * 2000)];
    [self.scroll1 setPagingEnabled:YES];
    [self.scroll1 setBounces:NO];
    [self.scroll1 setTag:100];
    CGFloat temp = 0;
    for (int i = 1; i < 12; i ++) {
        NSString *str = [NSString stringWithFormat:@"%d.jpg", i];
        
        UIImage *ima = [UIImage imageNamed:str];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 + temp + 10, 160, 160 * (ima.size.height / ima.size.width))];
        
        temp += image.frame.size.height + 10;
        [image setImage:ima];
        [self.scroll1 addSubview:image];
    }
    
    [self.scroll1 setBackgroundColor:[UIColor blueColor]];
    self.scroll1.delegate = self;
    [self.scrollView addSubview:self.scroll1];
    
    
    [self.scroll1 release];
}
#pragma mark 第一页右侧ScrollView
-(void)createScroll2
{
    self.scroll2 = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0, 0, self.view.frame.size.width / 2, self.view.frame.size.height - 49)];
    [self.scroll2 setContentSize:CGSizeMake(self.view.frame.size.width / 2, self.view.frame.size.height *50)];
    [self.scroll2 setPagingEnabled:YES];
    [self.scroll2 setBounces:NO];
    [self.scroll2 setTag:101];
    CGFloat temp = 0;
    for (int i = 11; i > 0; i --) {
        NSString *str = [NSString stringWithFormat:@"%d.jpg", i];
        
        UIImage *ima = [UIImage imageNamed:str];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 + temp + 10, 160, 160 * (ima.size.height / ima.size.width))];
        
        temp += image.frame.size.height + 10;
        [image setImage:ima];
        [self.scroll2 addSubview:image];
    }
    
    [self.scroll2 setBackgroundColor:[UIColor orangeColor]];
    self.scroll2.delegate = self;
    [self.scrollView addSubview:self.scroll2];
    [self.scroll2 release];
}
#pragma mark 小标题ScrollView
-(void)createSmallScrollView
{
    
    self.smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [self.smallScrollView setContentSize:CGSizeMake(self.view.frame.size.width + 380, self.smallScrollView.frame.size.height)];
    [self.smallScrollView setPagingEnabled:YES];
    [self.smallScrollView setBounces:NO];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部", @"婚纱", @"礼服", @"婚鞋", @"配饰", @"首饰", @"婚庆用品", @"家居礼品", nil];
    for (int i = 0; i < 8; i++) {
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
-(void)createScroll3
{
    
}
-(void)createScroll4
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100) {
        ((UIScrollView *)[self.view viewWithTag:101]).contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
    }else
    {
        ((UIScrollView *)[self.view viewWithTag:100]).contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NULL;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
