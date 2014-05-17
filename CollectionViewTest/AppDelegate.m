//
//  AppDelegate.m
//  CollectionViewTest
//
//  Created by Alejandro Padovan on 17/05/14.
//  Copyright (c) 2014 Mimay Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "AppController.h"
#import "NHBalancedFlowLayout.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NHBalancedFlowLayout *layout = [[NHBalancedFlowLayout alloc] init];
    AppController *appController = [[AppController alloc] initWithCollectionViewLayout:layout];
    self.window.rootViewController = appController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
