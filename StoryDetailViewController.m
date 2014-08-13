//
//  StoryDetailViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-9.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "AsynGETConnect.h"
#import "UIImageView+WebCache.h"
#import "StoryDetailCell.h"
@interface StoryDetailViewController ()< UITableViewDataSource, UITableViewDelegate>
@end

@implementation StoryDetailViewController
- (void)dealloc
{
    [_tableView release];
    [_dictionaty release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dictionaty = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getInformationFormConnet];
    [self createTableView];
}
-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 1000;
    [self.view addSubview:self.tableView];
    [self.tableView release];
    
}
-(void)getInformationFormConnet
{
    AsynGETConnect *asyn = [[AsynGETConnect alloc] init];
    NSString *path = [NSString stringWithFormat:@"http://marrymemo.com/stories/%@.json",self.stringId];
    NSLog(@"%@", self.stringId);
    [asyn startConnect:path dictionary:NULL block:^(NSData *data) {
        self.dictionaty = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.tableView reloadData];
        [self createTableViewHeader];
    }];
    [asyn release];
}

-(void)createTableViewHeader
{
    UIView *headerView = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 20)];
    [titleLabel setText:[[self.dictionaty objectForKey:@"story"] objectForKey:@"title"]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"Avenir" size:14]];
    [headerView addSubview:titleLabel];
    [titleLabel release];
    [headerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, titleLabel.frame.size.height + 15)];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dictionaty objectForKey:@"items"] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    StoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[StoryDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify] autorelease];
    }
    
    NSString *string = [[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"media_path"];

    
    if (![string isKindOfClass:[NSNull class]]&& ![string isEqualToString:@"(null)"]) {
        NSLog(@"string ======== %@", string);
        NSString *stringH =[NSString stringWithFormat:@"%@",[[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"height"]];
        CGFloat heightP = [stringH floatValue];
        NSString *stringW =[NSString stringWithFormat:@"%@",[[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"width"]];
        CGFloat width = [stringW floatValue];
        
        if (width != 0) {
            CGFloat height = heightP / width * self.view.frame.size.width;
            //设置图片尺寸
            [cell.bigImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
            NSLog(@"图片高度%f", height);
        }
        NSURL *url = [NSURL URLWithString:[[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"media_path"]];
        [cell.bigImage setImageWithURL:url];
        
    }
    
    NSString *str = [[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row ] objectForKey:@"description"];
    if (![str isKindOfClass:[NSNull class]]&& ![str isEqualToString:@"(null)"]) {
        NSLog(@"str ---------- %@", str);
        NSString *s = [[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row ] objectForKey:@"description"];
        CGSize size = [self getTheLabelHight:s label:cell.description];
        
        //设置描述文本的大小
        [cell.description setFrame:CGRectMake(0, 0, self.view.frame.size.width, size.height)];
    }
  
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryDetailCell *story = [[StoryDetailCell alloc] init];
    NSString *stringH =[NSString stringWithFormat:@"%@",[[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"height"]];
    CGFloat heightP = [stringH floatValue];
    
    NSString *stringW =[NSString stringWithFormat:@"%@",[[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row] objectForKey:@"width"]];
    CGFloat width = [stringW floatValue];
    CGFloat height = 0;
    if (width != 0) {
        height = heightP / width * self.view.frame.size.width;
    }

    NSString *s = [[[self.dictionaty objectForKey:@"items"] objectAtIndex:indexPath.row ] objectForKey:@"description"];
    CGSize size = [self getTheLabelHight:s label:story.description];
    NSLog(@"高度%f, %f", height , size.height);
    return height + size.height + 15;
}
@end
