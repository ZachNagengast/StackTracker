//
//  UserManager.m
//  User Stack
//
//  Created by Zach Nagengast on 3/2/18.
//  Copyright © 2018 ztb. All rights reserved.
//

#import "UserManager.h"
#import "AFNetworking.h"
#import "MasterViewController.h"

#define USER_ENDPOINT @"https://api.stackexchange.com/2.2/users?site=stackoverflow"


@implementation UserManager

+ (instancetype)sharedUserManager
{
    static dispatch_once_t onceQueue;
    static UserManager *userManager = nil;
    
    dispatch_once(&onceQueue, ^{ userManager = [[UserManager alloc] init]; });
    return userManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void)loadUsers
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    serializer.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [sessionManager GET:USER_ENDPOINT parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self getUsersFromJson:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.delegate failedToGetUsers:error];
    }];
}

-(void)getUsersFromJson:(NSDictionary *)responseJson
{
    NSArray *jsonUsers = [responseJson objectForKey:@"items"];
    
    NSMutableArray *userArray = [NSMutableArray new];
    NSManagedObjectContext *context = [((MasterViewController *)self.delegate).fetchedResultsController managedObjectContext];

    // Fetch All Current Users
    NSFetchRequest *fetch = [NSFetchRequest new];
    [fetch setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    NSArray *storedUsers = [context executeFetchRequest:fetch error:nil];
    
    NSLog(@"QUOTA REMAINING %@", [responseJson objectForKey:@"quota_remaining"]);

    for (NSDictionary *jsonUser in jsonUsers)
    {
        User *user;

        // Check if we need to add, or update, the user data
        int userId = [[jsonUser objectForKey:@"user_id"] intValue];
        for (User *u in storedUsers)
        {
            if (userId == u.userId)
            {
                // Found existing user
                user = u;
                break;
            }
        }
        
        if (user == nil) {
            // Didnt find existing user, create a new one
            user = [[User alloc] initWithContext:context];
        }
        
        user.gold = [[[jsonUser objectForKey:@"badge_counts"] objectForKey:@"gold"] intValue];
        user.silver = [[[jsonUser objectForKey:@"badge_counts"] objectForKey:@"silver"] intValue];
        user.bronze = [[[jsonUser objectForKey:@"badge_counts"] objectForKey:@"bronze"] intValue];
        user.location = [jsonUser objectForKey:@"location"];
        user.profileUrl = [jsonUser objectForKey:@"profile_image"];
        user.lastAccessDate = [NSDate dateWithTimeIntervalSinceNow:[[jsonUser objectForKey:@"last_access_date"] doubleValue]];
        user.link = [jsonUser objectForKey:@"link"];
        user.repChangeDay = [[jsonUser objectForKey:@"reputation_change_day"] intValue];
        user.reputation = [[jsonUser objectForKey:@"reputation"] intValue];
        user.age = [[jsonUser objectForKey:@"age"] intValue];
        user.displayName = [jsonUser objectForKey:@"display_name"];
        user.userId = [[jsonUser objectForKey:@"user_id"] intValue];

        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
    
    [self.delegate didGetUsers:userArray];
}

@end
