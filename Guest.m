//
//  Guest.m
//  FirebaseDatabasePra
//
//  Created by ling toby on 8/12/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "Guest.h"
@import Firebase;
@import FirebaseStorage;

@implementation Guest

-(id)initGuestWithGuestDict: (NSDictionary *)guestDict{
    self = [super init];
    if (self) {
        _gid = guestDict[@"gid"];
        _guestAndHisCompanyNumber= guestDict[@"guestAndHisCompanyNumber"];
        
/*very cool way fetch array from Firebase databse, the data was store as dictionary like "guestAndHisCompanyList":{"0": "randomGidForGuestOne","1":"randomGidForGuestTwo"}, however we get it back as "guestAndHisCompanyList":["randomGidForGuestOne","randomGidForGuestTwo"],*/

        NSMutableArray *guestAndHisCompanyListArray= guestDict[@"guestAndHisCompanyList"];
        NSLog(@"_________the guest list array is %@",guestAndHisCompanyListArray);
        _gImage = [UIImage imageNamed:@"placeholder.png"];
    }

    return self;
}


@end
