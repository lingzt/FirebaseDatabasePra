//
//  Guest.m
//  FirebaseDatabasePra
//
//  Created by ling toby on 8/12/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "Guest.h"
@import Firebase;

@implementation Guest
/*
 @property (strong,nonatomic) NSString *gid;
 @property (strong,nonatomic) NSNumber *guestNumber;
 @property (strong,nonatomic) NSArray *guestsPlusOneList;
 @property (strong,nonatomic) UIImage *gImage;
 */

-(id)initGuestWithGid:(NSString *)gid{
    self = [super init];
    if (self) {
        _gid = [[NSUUID UUID]UUIDString];
        _guestNumber =[[NSNumber alloc]initWithInt:1];
        _gImage = [UIImage imageNamed:@"placeholder.png"];
    }
    return self;
}

-(id)updateGuestWithPlustOneList:(NSArray *)guestsPlusOneList{
    NSInteger count = [guestsPlusOneList count];
    _guestNumber = [[NSNumber alloc]initWithInteger:count];
    _guestPlusOneList = guestsPlusOneList;
    return self;
}

-(void)addNewGuestToFBDatabaseWithWithNewGuest:(Guest *)newGuest{
    FIRDatabaseReference *firebaseGuestRef = [[[FIRDatabase database]reference]child:@"guest"];
    NSDictionary *newGuestDictBase = @{@"gid":newGuest.gid};
    NSDictionary *newGuestDict = @{newGuest.gid:newGuestDictBase};
    [firebaseGuestRef updateChildValues:newGuestDict];
}

-(void)updateGuestToFBDatabaseWithUpdatedGuest:(Guest *)updatedGuest{
    FIRDatabaseReference *firebaseGuestRef = [[[FIRDatabase database]reference]child:@"guest"];
    //update image to FBStorage first
    NSString *gImageUrl;
    // when URL return, process following code.
    NSDictionary *updatedGuestDictBase = @{@"gid":updatedGuest.gid,
                                       @"guestNumber":updatedGuest.guestNumber,
                                       @"guestsPlusOneList":updatedGuest.guestPlusOneList,
                                           @"gImage":gImageUrl
                                       };
    NSDictionary *updatedGuestDict = @{updatedGuest.gid:updatedGuestDictBase};
    [firebaseGuestRef updateChildValues:updatedGuestDict];
}



@end
