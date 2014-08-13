//
//  StoryViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "StoryViewController.h"
#import "StoryTableViewCell.h"
#import "AsynGETConnect.h"
#import "UIImageView+WebCache.h"
#import "StoryDetailViewController.h"
#define SORT 10
#define PICTURE 9
@interface StoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation StoryViewController
- (void)dealloc
{
    [_tableView release];
    [_dictionary release];
    [_array release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionary];
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
    [self createNav];
    [self createTableView];
    [self getInformationFromConnect];
}

-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.tag = PICTURE;
    self.tableView.rowHeight = 210;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView release];
}

#pragma mark 创建导航栏
-(void)createNav
{
    self.navigationController.navigationItem.title = @"精选故事";
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    [label setText:@"精选故事"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = label;
    [label release];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"storySortIcon@2x.png"] forState:UIControlStateNormal];
    [leftButton setTag:100];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = itemButton;
    
   
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 80, 25)];
    [rightButton setTitle:@"我的故事" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightButton setTag:100];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBu = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = itemBu;
}

-(void)leftButtonAction:(id)sender
{
    [self createView];
}
-(void)rightButtonAction:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 创建下拉的排序列表View
-(void)createView
{
    self.anotherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.anotherView setBackgroundColor:[UIColor clearColor]];
    [self.anotherView setTag:102];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.anotherView.frame.size.width, 90) style:UITableViewStylePlain];
    [tableView setTag:SORT];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    tableView.rowHeight = 30;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.anotherView addSubview:tableView];
    [self.view addSubview:self.anotherView];
    [tableView release];
    [self.anotherView release];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.anotherView removeFromSuperview];
}
#pragma mark 网络解析
-(void)getInformationFromConnect
{
    AsynGETConnect *async = [[AsynGETConnect alloc] init];
 
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"page" forKey:@"1"];
    [async startConnect:@"http://marrymemo.com/stories.json"  dictionary:dic block:^(NSData *data) {
        self.dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self.tableView reloadData];
    }];
    [dic release];
    [async release];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == PICTURE) {
        return [[self.dictionary objectForKey:@"stories"] count];
    }
    else
    {
        return [self.array count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == PICTURE) {
        static NSString *cellIdentify = @"cellIdentify";
        StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[StoryTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        }
        NSURL *url1 = [NSURL URLWithString:[[[self.dictionary objectForKey:@"stories"] objectAtIndex:indexPath.row] objectForKey:@"cover_path"]];
        
        NSURL *url2 = [NSURL URLWithString:[[[[self.dictionary objectForKey:@"stories"] objectAtIndex:indexPath.row] objectForKey:@"user"] objectForKey:@"avatar"]];
        
        NSString *string = [NSString stringWithFormat:@"     %@",[[[self.dictionary objectForKey:@"stories"] objectAtIndex:indexPath.row] objectForKey:@"title"]];
        NSString *str = [NSString stringWithFormat:@"%@", [[[self.dictionary objectForKey:@"stories"] objectAtIndex:indexPath.row] objectForKey:@"praise_count"]];
        NSLog(@"%@", [[[self.dictionary objectForKey:@"stories"] objectAtIndex:indexPath.row] objectForKey:@"praise_count"]);
        
        [cell.bigImage setImageWithURL:url1];
        [cell.smallImage setImageWithURL:url2];
        [cell.label setText:string];
        [cell.smallLabel setText:str];
        
        return cell;
    }else
    {
        static NSString *temp = @"tempCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:temp];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:temp] autorelease];
        }
        [cell.textLabel setText:[self.array objectAtIndex:indexPath.row]];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryDetailViewController *story = [[StoryDetailViewController alloc] init];
    story.stringId = [[[self.dictionary objectForKey:@"stories"] objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:story animated:YES];
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
