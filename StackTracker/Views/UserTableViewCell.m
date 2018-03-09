//
//  UserTableViewCell.m
//  User Stack
//
//  Created by Zach Nagengast on 3/9/18.
//  Copyright © 2018 ztb. All rights reserved.
//

#import "UserTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <PureLayout/PureLayout.h>

@implementation UserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // Main Card
        self.cardView = [UIView new];
        [self.contentView addSubview:self.cardView];

        [self.cardView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SPACING_OFFSET];
        [self.cardView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SPACING_OFFSET];
        [self.cardView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SPACING_OFFSET];
        [self.cardView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SPACING_OFFSET];
        [self.cardView setBackgroundColor:[UIColor whiteColor]];
        
        self.cardView.layer.cornerRadius = SPACING_OFFSET * 1.5;
        self.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.cardView.layer.shadowOffset = CGSizeZero;
        self.cardView.layer.shadowRadius = SPACING_OFFSET/1.5;
        self.cardView.layer.shadowOpacity = 0.1;
        
        
        // User Profile Image
        self.userImageView = [UIImageView new];
        [self.cardView addSubview:_userImageView];
        
        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.userImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.userImageView autoSetDimension:ALDimensionWidth toSize:CELL_HEIGHT];
        [self.userImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.userImageView.layer.cornerRadius = SPACING_OFFSET * 1.5;
        self.userImageView.layer.masksToBounds = YES;
        self.userImageView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMinXMinYCorner;
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.userImageView addSubview:self.activityIndicator];
        [self.userImageView bringSubviewToFront:self.activityIndicator];
        [self.activityIndicator autoCenterInSuperview];
        self.activityIndicator.hidesWhenStopped = YES;
        [self.activityIndicator startAnimating];

        // User Rep Label
        self.userRepLabel = [UILabel new];
        [self.cardView addSubview:self.userRepLabel];
        
        [self.userRepLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SPACING_OFFSET/2];
        [self.userRepLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userImageView withOffset:SPACING_OFFSET];
        [self.userRepLabel setFont:[UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]];
        [self.userRepLabel setTextColor:[UIColor lightGrayColor]];
        self.userRepLabel.adjustsFontSizeToFitWidth = YES;

        
        // User Name Label
        self.userNameLabel = [UILabel new];
        [self.cardView addSubview:self.userNameLabel];
        
        [self.userNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userRepLabel withOffset:SPACING_OFFSET/2];
        [self.userNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userImageView withOffset:SPACING_OFFSET];
        [self.userNameLabel setFont:[UIFont boldSystemFontOfSize:[UIFont buttonFontSize]]];
        [self.userNameLabel setTextColor:[UIColor blackColor]];
        self.userNameLabel.adjustsFontSizeToFitWidth = YES;

        
        // Gold Badge Label
        self.userGoldBadgeLabel = [UILabel new];
        [self.cardView addSubview:self.userGoldBadgeLabel];
        
        [self.userGoldBadgeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userNameLabel withOffset:SPACING_OFFSET/2];
        [self.userGoldBadgeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userImageView withOffset:SPACING_OFFSET];
        [self.userGoldBadgeLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        [self.userGoldBadgeLabel setTextColor:[UIColor colorWithRed:252.0/255.0 green:193.0/255.0 blue:0 alpha:1]];
        
        // Silver Badge Label
        self.userSilverBadgeLabel = [UILabel new];
        [self.cardView addSubview:self.userSilverBadgeLabel];
        
        [self.userSilverBadgeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.userGoldBadgeLabel];
        [self.userSilverBadgeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userGoldBadgeLabel withOffset:SPACING_OFFSET];
        [self.userSilverBadgeLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        [self.userSilverBadgeLabel setTextColor:[UIColor colorWithRed:165.0/255.0 green:169.0/255.0 blue:174.0/255.0 alpha:1]];
        
        // Bronze Badge Label
        self.userBronzeBadgeLabel = [UILabel new];
        [self.cardView addSubview:self.userBronzeBadgeLabel];
        
        [self.userBronzeBadgeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.userGoldBadgeLabel];
        [self.userBronzeBadgeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userSilverBadgeLabel withOffset:SPACING_OFFSET];
        [self.userBronzeBadgeLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        [self.userBronzeBadgeLabel setTextColor:[UIColor colorWithRed:196.0/255.0 green:149.0/255.0 blue:112.0/255.0 alpha:1]];
        
        // User Day Gain Container
        self.userDayGainContainer = [UIView new];
        [self.cardView addSubview:self.userDayGainContainer];
        
        [self.userDayGainContainer autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.cardView];
        [self.userDayGainContainer autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.cardView withOffset:-SPACING_OFFSET*2];
        [self.userDayGainContainer autoSetDimension:ALDimensionWidth toSize:70];
        [self.userDayGainContainer autoSetDimension:ALDimensionHeight toSize:CELL_HEIGHT/2.5];
        [self.userDayGainContainer setBackgroundColor:[UIColor colorWithRed:45.0/255.0 green:196.0/255.0 blue:132.0/255.0 alpha:1]];
        self.userDayGainContainer.layer.cornerRadius = 3;
        self.userDayGainContainer.layer.masksToBounds = YES;
        
        // User Day Gain Label
        self.userDayGainLabel = [UILabel new];
        [self.userDayGainContainer addSubview:self.userDayGainLabel];
        
        [self.userDayGainLabel autoCenterInSuperview];
        [self.userDayGainLabel setFont:[UIFont boldSystemFontOfSize:[UIFont buttonFontSize]]];
        [self.userDayGainLabel setTextColor:[UIColor whiteColor]];
        
        UILabel *dayGainLabelDesc = [UILabel new];
        [self.cardView addSubview:dayGainLabelDesc];
        
        [dayGainLabelDesc autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.userDayGainContainer withOffset:-SPACING_OFFSET/4];
        [dayGainLabelDesc autoAlignAxis:ALAxisVertical toSameAxisOfView:self.userDayGainContainer];
        [dayGainLabelDesc setFont:[UIFont boldSystemFontOfSize:8]];
        [dayGainLabelDesc setTextColor:[UIColor colorWithRed:45.0/255.0 green:196.0/255.0 blue:132.0/255.0 alpha:1]];
        [dayGainLabelDesc setText:@"24HR REP GAIN"];
        
        // Responsive Adjustments
        [self.userRepLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.userDayGainContainer withOffset:-SPACING_OFFSET];
        [self.userNameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.userDayGainContainer withOffset:-SPACING_OFFSET];
        


    }
    return self;
}

-(void)configureCellForUser:(User *)user {
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.profileUrl]
                          placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                     [self.activityIndicator stopAnimating];
                                 }];
    
    NSString *reputation = [NSNumberFormatter localizedStringFromNumber:@(user.reputation) numberStyle:NSNumberFormatterDecimalStyle];
    self.userRepLabel.text = [NSString stringWithFormat:@"%@ REPUTATION", reputation];
    self.userNameLabel.text = user.displayName;
    self.userGoldBadgeLabel.text = [NSString stringWithFormat:@"• %i", user.gold];
    self.userSilverBadgeLabel.text = [NSString stringWithFormat:@"• %i", user.silver];
    self.userBronzeBadgeLabel.text = [NSString stringWithFormat:@"• %i", user.bronze];
    self.userDayGainLabel.text = [NSString stringWithFormat:@"+%i", user.repChangeDay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
