//
//  MasterViewController.h
//  User Stack
//
//  Created by Zach Nagengast on 3/1/18.
//  Copyright © 2018 ztb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User_Stack+CoreDataModel.h"
#import "UserManager.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UserManagerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSFetchedResultsController<User *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

