//
//  AppDelegate.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "InvitationViewController.h"
#import "StoryViewController.h"
#import "MyViewController.h"
#import "CollecViewController.h"
@implementation AppDelegate
- (void)dealloc
{
    [_window dealloc];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainViewController *main = [[MainViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:main];
    main.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物" image:[UIImage imageNamed:@"tabFirst.png"] tag:100];
    
    CollecViewController *collection = [[CollecViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:collection];
    collection.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"婚博汇" image:[UIImage imageNamed:@"tabCircle.png"] tag:101];
    
    InvitationViewController *invitation = [[InvitationViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:invitation];
    invitation.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"请帖" image:[UIImage imageNamed:@"tabCreate.png"] tag:102];
    
    StoryViewController *story = [[StoryViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:story];
    story.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"故事" image:[UIImage imageNamed:@"tabStory.png"] tag:103];
    
    MyViewController *my = [[MyViewController alloc] init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:my];
    my.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabUser.png"] tag:104];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:nav1];
    [array addObject:nav2];
    [array addObject:nav3];
    [array addObject:nav4];
    [array addObject:nav5];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab setViewControllers:array];
    
    [self.window setRootViewController:tab];
    [main release];
    [collection release];
    [invitation release];
    [story release];
    [my release];
    
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    [nav5 release];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
