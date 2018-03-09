//
//  AppDelegate.h
//  User Stack
//
//  Created by Zach Nagengast on 3/1/18.
//  Copyright © 2018 ztb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

