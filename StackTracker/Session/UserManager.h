//
//  UserManager.h
//  User Stack
//
//  Created by Zach Nagengast on 3/2/18.
//  Copyright © 2018 ztb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User_Stack+CoreDataModel.h"

@class UserManager;

@protocol UserManagerDelegate <NSObject>

@optional
- (void)didGetUsers:(NSArray *)users;
- (void)failedToGetUsers:(NSError *)error;

@end

@interface UserManager : NSObject

@property (nonatomic, weak) NSObject<UserManagerDelegate> *delegate;
+ (instancetype)sharedUserManager;

- (void)loadUsers;

@end


