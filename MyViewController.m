//
//  MyViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "CustomView.h"
@interface MyViewController ()<UIScrollViewDelegate>

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIColor *color = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.1];
        [self.view setBackgroundColor:color];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
}
-(void)createScrollView
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scroll setContentSize:CGSizeMake(0, 600)];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 80)];
    [titleView setBackgroundColor:[UIColor whiteColor]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
    [title setText:@"欢迎来到婚礼纪"];
    [title setTextColor:[UIColor grayColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [titleView addSubview:title];
    [title release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(115, 45, 80, 30)];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:button];
    
    NSArray *arrayPicture = [NSArray arrayWithObjects:@"SettingCollect.png", @"SettingStory.png", @"settingCoupon.png", @"SettingTrick.png", @"settingIconAbout.png", @"SettingMerchant.png", @"settingComment.png", @"cleanCache.png", @"feedback.png",nil];
    NSArray *arrayText = [NSArray arrayWithObjects:@"我的收藏", @"我的故事", @"活动与奖品", @"整人攻略", @"关于婚礼纪", @"商家招募", @"评价婚礼纪", @"清空缓存  35M", @"我要反馈",nil];
    for (int i = 0; i < [arrayPicture count]; i++) {
        CustomView *custom = [[CustomView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height + 10 + i * 42, self.view.frame.size.width, 40)];
        [custom setBackgroundColor:[UIColor whiteColor]];
        [custom.img setImage:[UIImage imageNamed:[arrayPicture objectAtIndex:i]]];
        [custom.label setText:[arrayText objectAtIndex:i]];
        [scroll addSubview:custom];
    }
    
    [scroll addSubview:titleView];
    [scroll setPagingEnabled:YES];
    scroll.delegate = self;
    [scroll setBounces:NO];
    
    [self.view addSubview:scroll];
}

-(void)loginAction:(id)sender
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    [login release];
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
