//
//  WTAppDelegate.m
//  WTScrollViewKeyboardManager
//
//  Created by Andrew Carter on 10/7/13.
//  Copyright (c) 2013 WillowTree Apps. All rights reserved.
//

#import "WTAAppDelegate.h"

#import "WTARootViewController.h"

@implementation WTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WTARootViewController *rootViewController = [WTARootViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    UITabBarController *tabController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    [rootViewController setTabBarItem:item];
    [tabController setViewControllers:@[navigationController]];
    [[self window] setRootViewController:tabController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
