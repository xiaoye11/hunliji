//
//  LoginViewController.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-9.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

-(void)createView
{
    UIButton *sinaButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 60, 60, 60)];
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"loginSina.png"] forState:UIControlStateNormal];
    [sinaButton addTarget:self action:@selector(sinaAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *labelSina = [[UILabel alloc] initWithFrame:CGRectMake(130, 120, 60, 60)];
    [labelSina setText:@"新浪微博"];
    [labelSina setFont:[UIFont fontWithName:@"Avenir" size:15]];
    [labelSina setTextColor:[UIColor redColor]];
    [self.view addSubview:labelSina];
    [self.view addSubview:sinaButton];
    [labelSina release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 170, 300, 30)];
    [label setText:@"---------------------请登录在进行操作--------------------"];
    [label setFont:[UIFont fontWithName:@"Avenir" size:12]];
    
    [label setTextColor:[UIColor grayColor]];
    [self.view addSubview:label];
    [label release];
    
    UIButton *qqButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 220, 60, 60)];
    [qqButton setBackgroundImage:[UIImage imageNamed:@"loginQQ.png"] forState:UIControlStateNormal];
    [qqButton addTarget:self action:@selector(qqAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *labelQQ = [[UILabel alloc] initWithFrame:CGRectMake(130, 280, 60, 60)];
    [labelQQ setText:@"腾讯QQ"];
    [labelQQ setFont:[UIFont fontWithName:@"Avenir" size:15]];
    [labelQQ setTextColor:[UIColor cyanColor]];
    [self.view addSubview:labelQQ];

    [self.view addSubview:qqButton];
}

-(void)sinaAction:(id)sender
{
    
}
-(void)qqAction:(id)sender
{
    
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
