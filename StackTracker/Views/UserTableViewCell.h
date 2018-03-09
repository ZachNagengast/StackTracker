//
//  UserTableViewCell.h
//  User Stack
//
//  Created by Zach Nagengast on 3/9/18.
//  Copyright © 2018 ztb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User_Stack+CoreDataModel.h"

#define USER_CELL_IDENTIFIER @"UserCell"
#define CELL_HEIGHT 72
#define SPACING_OFFSET 10.0

@interface UserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *cardView;

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userRepLabel;

@property (nonatomic, strong) UILabel *userBronzeBadgeLabel;
@property (nonatomic, strong) UILabel *userSilverBadgeLabel;
@property (nonatomic, strong) UILabel *userGoldBadgeLabel;


@property (nonatomic, strong) UIView *userDayGainContainer;
@property (nonatomic, strong) UILabel *userDayGainLabel;

- (void)configureCellForUser:(User *)user;

@end
