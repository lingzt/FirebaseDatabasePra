//
//  ViewController.m
//  FirebaseDatabasePra
//
//  Created by ling toby on 8/10/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ViewController.h"
#import "Guest.h"
@import FirebaseStorage;
@import Firebase;


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
NSMutableArray *guestArray;


- (void)viewDidLoad {
    guestArray = [[NSMutableArray alloc]init];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self loginUserToFirebase];
    [self retriveGuestArrayFromFBDatabse];
}

#pragma mark -- login
-(void)loginUserToFirebase{
    NSString *newPwd = @"111111";
    [[FIRAuth auth] signInWithEmail:@"ling@gmail.com"
                           password:newPwd
                         completion:^(FIRUser *user, NSError *error) {
                             
                             if (error) {
                                 NSString *message=@"Invalid email or password";
                                 NSString *alertTitle=@"Invalid!";
                                 NSString *OKText=@"OK";
                                 
                                 UIAlertController *alertView = [UIAlertController alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
                                 UIAlertAction *alertAction = [UIAlertAction actionWithTitle:OKText style:UIAlertActionStyleCancel handler:nil];
                                 [alertView addAction:alertAction];
                                 [self presentViewController:alertView animated:YES completion:nil];
                             }else{
                                 NSLog(@"Login success!!!!!!!!!!!!");
                             }
                         }];
}

#pragma mark -- tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [guestArray count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[guestArray objectAtIndex:indexPath.row] gid];
    NSLog(@"%@",[[guestArray objectAtIndex:indexPath.row] gid]);
    cell.imageView.image = [[guestArray objectAtIndex:indexPath.row] gImage];
    return cell;
}


#pragma mark -- retrieve 
-(void)retriveGuestArrayFromFBDatabse{
    FIRDatabaseReference *guestsRef = [[[FIRDatabase database]reference]child:@"guest"];
    [guestsRef observeEventType:FIRDataEventTypeValue withBlock:
     ^(FIRDataSnapshot *snapshot) {
         if (snapshot.value != [NSNull null]) {
//             [self cleanGuestsSortedInGroupList];
             NSLog(@"_____________if snapshot value is not nil");
             for(id key in snapshot.value){
                 id guestInDictionaryFormat = [snapshot.value objectForKey:key];
                 Guest *guestToAssign = [[Guest alloc]initGuestWithGuestDict:guestInDictionaryFormat];
                     dispatch_async(dispatch_get_main_queue(), ^(){
                         [self updateGImageWithGuestToBeUpdatedWithGid:guestToAssign];
                         
                         [self.tableView reloadData];
                     });
                [guestArray addObject:guestToAssign];
             }
         }
     }];
}

-(void)updateGImageWithGuestToBeUpdatedWithGid :(Guest *)guestToUpdate{
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *gustImageStorageRef = [storage referenceForURL:@"gs://fir-databasepra.appspot.com/guestImage/"];
    FIRStorageReference *guestImageRef = [gustImageStorageRef child:@"randomGidForGuestOne.png"];
    NSLog(@"______________the download url is %@",guestImageRef);
    [guestImageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(error.description);
        }else{
            NSLog(@"%@",data);
            guestToUpdate.gImage = [UIImage imageWithData:data];
            NSLog(@"DONE UPDATEING IMAGE LOCALLY, TABLEVIEW TO BE REFRESHED ___________________");
            [self.tableView reloadData];
        }
    }];
}




@end
