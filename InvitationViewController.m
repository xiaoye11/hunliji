//
//  InvitationViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "InvitationViewController.h"
#import "AsynGETConnect.h"
#import "UIImageView+WebCache.h"
@interface InvitationViewController ()<UIScrollViewDelegate>
{
    InfiniteScrollPicker *isp2;
}
@end

@implementation InvitationViewController
- (void)dealloc
{
    [_array release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.array = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getConnection];
    [self createLabel];
}
-(void)getConnection
{
    AsynGETConnect *async = [[AsynGETConnect alloc] init];
    [async startConnect:@"http://marrymemo.com/themes.json" dictionary:NULL block:^(NSData *data) {
        self.array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self putPicture];
        [self createScrollView];
    }];
    [async release];
}
-(void)putPicture
{
    for (int i = 1; i < 40; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 120, self.view.frame.size.height - 240)];
        [imageView setImageWithURL:[[self.array objectAtIndex:i - 1] objectForKey:@"background"]];
        [[self.view viewWithTag:i] addSubview:imageView];
    }
}
-(void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 90)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 39, 0);
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setBounces:YES];
    
    for (int i = 0; i < 39; i ++) {
        UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0 + 60 + i * self.view.frame.size.width, 50, self.view.frame.size.width - 120, self.view.frame.size.height - 240)];
        [ima setTag:(1 + i)];
        [ima setImageWithURL:[[self.array objectAtIndex:i] objectForKey:@"thumb_path"]];
        [self.scrollView addSubview:ima];
        [ima release];
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView release];
    
}
-(void)createLabel
{
    UIView *smallView = [[UIView alloc] initWithFrame:CGRectMake(61, self.view.frame.size.height - 100, self.view.frame.size.width - 120, 40)];
    UIButton *draw = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [draw setImage:[UIImage imageNamed:@"s1n.png"] forState:UIControlStateNormal];
    [smallView addSubview:draw];
    
    UIButton *picture = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 35, 35)];
    [picture setImage:[UIImage imageNamed:@"s2n.png"] forState:UIControlStateNormal];
    [smallView addSubview:picture];
    
    UIButton *video = [[UIButton alloc] initWithFrame:CGRectMake(110, 0, 35, 35)];
    [video setImage:[UIImage imageNamed:@"s3n.png"] forState:UIControlStateNormal];
    [smallView addSubview:video];
    
    UIButton *scoll = [[UIButton alloc] initWithFrame:CGRectMake(165, 0, 35, 35)];
    [scoll setImage:[UIImage imageNamed:@"s4n.png"] forState:UIControlStateNormal];
    [smallView addSubview:scoll];
    
    [self.view addSubview:smallView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
