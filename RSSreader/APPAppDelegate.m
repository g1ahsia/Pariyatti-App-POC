//
//  APPAppDelegate.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPAppDelegate.h"
#import "APPMasterViewController.h"
#import "APPDetailViewController.h"
#import "APPContentViewController.h"

@implementation APPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    splitViewController.delegate = self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [splitViewController.view addSubview:view];
    
    APPMasterViewController *root = [[APPMasterViewController alloc] init];
    APPDetailViewController *detail = [[APPDetailViewController alloc] init];
    
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:root];
    UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detail];
    
    splitViewController.viewControllers = [NSArray arrayWithObjects:rootNav, detailNav, nil];
    
    [self.window addSubview:splitViewController.view];
    
    myTabBarController = [[UITabBarController alloc] init];
    
    APPContentViewController *PaliWordADay = [[APPContentViewController alloc] init];
    APPContentViewController *DailyDohas = [[APPContentViewController alloc] init];
    PaliWordADay.urlString = @"http://host.pariyatti.org/pwad/pali_words.xml";
    PaliWordADay.titleString = @"Pāli Word a Day";
    DailyDohas.urlString = @"http://host.pariyatti.org/dohas/daily_dohas.xml";
    DailyDohas.titleString = @"Dhamma Verses from S.N. Goenka";

    UINavigationController *paliWordNav = [[UINavigationController alloc] initWithRootViewController:PaliWordADay];
    UINavigationController *dailyDohasNav = [[UINavigationController alloc] initWithRootViewController:DailyDohas];

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:251.0f/255.0f green:247.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:187.0f/255.0f green:108.0f/255.0f blue:53.0f/255.0f alpha:1.0f]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:187.0f/255.0f green:108.0f/255.0f blue:53.0f/255.0f alpha:1.0f]}];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Daily Words" image:[UIImage imageNamed:@"pariyatti.png"] selectedImage:[UIImage imageNamed:@"pariyatti.png"]];
    tabBarItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Pali Word" image:[UIImage imageNamed:@"pariyatti.png"] selectedImage:[UIImage imageNamed:@"pariyatti.png"]];
    tabBarItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Daily Dohas" image:[UIImage imageNamed:@"pariyatti.png"] selectedImage:[UIImage imageNamed:@"pariyatti.png"]];
    tabBarItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);


    splitViewController.tabBarItem = tabBarItem1;
    PaliWordADay.tabBarItem = tabBarItem2;
    DailyDohas.tabBarItem = tabBarItem3;
    myTabBarController.viewControllers = [NSArray arrayWithObjects:splitViewController, paliWordNav, dailyDohasNav, nil];
    [myTabBarController.tabBar setTintColor:[UIColor colorWithRed:187.0f/255.0f green:108.0f/255.0f blue:53.0f/255.0f alpha:1.0f]];
    [myTabBarController.tabBar setBarTintColor:[UIColor whiteColor]];
    myTabBarController.delegate = self;
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:myTabBarController];
    [self.window setFrame:[[UIScreen mainScreen] bounds]];
    return YES;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController NS_AVAILABLE_IOS(8_0) {
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
