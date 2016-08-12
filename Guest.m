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
/*
 @property (strong,nonatomic) NSString *gid;
 @property (strong,nonatomic) NSNumber *guestNumber;
 @property (strong,nonatomic) NSArray *guestsPlusOneList;
 @property (strong,nonatomic) UIImage *gImage;
 */

-(id)initGuestWithGuestDict: (NSDictionary *)guestDict{
    self = [super init];
    if (self) {
        _gid = guestDict[@"gid"];
        _guestNumber = guestDict[@"guestsPlusOneList"];
        _guestPlusOneList = guestDict[@"guestsPlusOneList"];
        _gImage = [UIImage imageNamed:@"placeholder.png"];
    }
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self updateGImageWithGuestToBeUpdated];
        NSLog(@"%@",_gImage.description);
    });
    NSLog(self.description);
    return self;
}

-(void)updateGImageWithGuestToBeUpdated{
//    gs://fir-databasepra.appspot.com/gid.png
    // Get a reference to the storage service, using the default Firebase App
    FIRStorage *storage = [FIRStorage storage];
    // Create a storage reference from our storage service
    FIRStorageReference *gustImageStorageRef = [storage referenceForURL:@"gs://fir-databasepra.appspot.com/guestImage/"];
    FIRStorageReference *guestImageRef = [gustImageStorageRef child:@"images/space.jpg"];
    
    [guestImageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(error.description);
        }else{
            _gImage = [UIImage imageWithData:data];
        }
    }];
    
    
//    [guestImageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
//        if (error != nil) {
//            NSLog(error.description);
//        } else {
//            // Local file URL for "images/island.jpg" is returned
//            NSLog(URL.description);
//        }
//    }];
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
