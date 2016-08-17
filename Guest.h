//
//  Guest.h
//  FirebaseDatabasePra
//
//  Created by ling toby on 8/12/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Guest : NSObject
@property (strong,nonatomic) NSString *gid;
@property (strong,nonatomic) NSNumber *guestAndHisCompanyNumber;
@property (strong,nonatomic) UIImage *gImage;

-(id)initGuestWithGuestDict: (NSDictionary *)guestDict;





/*
 FirebaseDatabase store the following data type
 NSString
 NSNumber
 NSArray
 */


@end
