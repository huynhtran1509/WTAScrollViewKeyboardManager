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
    [[self window] setRootViewController:navigationController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
