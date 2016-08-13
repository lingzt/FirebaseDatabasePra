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
        _guestAndPlusOneNumber= guestDict[@"guestAndPlusOneNumber"];
        
/*very cool way fetch array from Firebase databse, the data was store as dictionary like "guestAndPlusOneList":{"0": "randomGidForGuestOne","1":"randomGidForGuestTwo"}, however we get it back as "guestAndPlusOneList":["randomGidForGuestOne","randomGidForGuestTwo"],*/

        NSMutableArray *guestAndPlusOneListArray= guestDict[@"guestAndPlusOneList"];
        NSLog(@"_________the guest list array is %@",guestAndPlusOneListArray);
        _guestAndPlusOneList = guestAndPlusOneListArray;
        _gImage = [UIImage imageNamed:@"placeholder.png"];
    }
//    dispatch_async(dispatch_get_main_queue(), ^(){
//        [self updateGImageWithGuestToBeUpdatedWithGid:_gid];
//    });
    return self;
}

-(void)updateGImageWithGuestToBeUpdatedWithGid :(NSString *)gid{
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *gustImageStorageRef = [storage referenceForURL:@"gs://fir-databasepra.appspot.com/guestImage/"];
    FIRStorageReference *guestImageRef = [gustImageStorageRef child:@"randomGidForGuestOne.png"];
//    FIRStorageReference *guestImageRef = [gustImageStorageRef child:(@"%@.png",gid)];
    NSLog(@"______________the download url is %@",guestImageRef);
    [guestImageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"__________________ nooooo gooooood");
            NSLog(error.description);
        }else{
            _gImage = [UIImage imageWithData:data];
            NSLog(@"__________________so far so gooooood %@",data);
        }
    }];
}











/*
 [islandRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData data, NSError error){
 if (error != nil) {
 // Uh-oh, an error occurred!
 } else {
 // Data for "images/island.jpg" is returned
 // ... UIImage *islandImage = [UIImage imageWithData:data];
 }
 }];
 */

//-(id)initGuestWithGid:(NSString *)gid{
//    self = [super init];
//    if (self) {
//        _gid = [[NSUUID UUID]UUIDString];
//        _guestNumber =[[NSNumber alloc]initWithInt:1];
//        _gImage = [UIImage imageNamed:@"placeholder.png"];
//    }
//    return self;
//}
//
//-(id)updateGuestWithPlustOneList:(NSArray *)guestsPlusOneList{
//    NSInteger count = [guestsPlusOneList count];
//    _guestNumber = [[NSNumber alloc]initWithInteger:count];
//    _guestPlusOneList = guestsPlusOneList;
//    return self;
//}
//
//-(void)addNewGuestToFBDatabaseWithWithNewGuest:(Guest *)newGuest{
//    FIRDatabaseReference *firebaseGuestRef = [[[FIRDatabase database]reference]child:@"guest"];
//    NSDictionary *newGuestDictBase = @{@"gid":newGuest.gid};
//    NSDictionary *newGuestDict = @{newGuest.gid:newGuestDictBase};
//    [firebaseGuestRef updateChildValues:newGuestDict];
//}
//
//-(void)updateGuestToFBDatabaseWithUpdatedGuest:(Guest *)updatedGuest{
//    FIRDatabaseReference *firebaseGuestRef = [[[FIRDatabase database]reference]child:@"guest"];
//    //update image to FBStorage first
//    NSString *gImageUrl;
//    // when URL return, process following code.
//    NSDictionary *updatedGuestDictBase = @{@"gid":updatedGuest.gid,
//                                       @"guestNumber":updatedGuest.guestNumber,
//                                       @"guestsPlusOneList":updatedGuest.guestPlusOneList,
//                                           @"gImage":gImageUrl
//                                       };
//    NSDictionary *updatedGuestDict = @{updatedGuest.gid:updatedGuestDictBase};
//    [firebaseGuestRef updateChildValues:updatedGuestDict];
//}



@end
