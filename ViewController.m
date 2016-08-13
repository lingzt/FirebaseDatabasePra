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
    [self.tableView reloadData];

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
    cell.imageView.image = [[guestArray objectAtIndex:indexPath.row] gImage];
    return cell;
}


#pragma mark -- retrieve 
-(void)retriveGuestArrayFromFBDatabse{
    FIRDatabaseReference *guestsRef = [[[FIRDatabase database]reference]child:@"guest"];
    [guestsRef observeEventType:FIRDataEventTypeValue withBlock:
     ^(FIRDataSnapshot *snapshot) {
         NSLog(@"The Snapshot we got is ___________%@",[snapshot.value description]);
         if (snapshot.value != [NSNull null]) {
//             [self cleanGuestsSortedInGroupList];
             NSLog(@"_____________if snapshot value is not nil");
             for(id key in snapshot.value){
                 id guestInDictionaryFormat = [snapshot.value objectForKey:key];
                 Guest *guestToAssign = [[Guest alloc]initGuestWithGuestDict:guestInDictionaryFormat];
                 
                     [guestArray addObject:guestToAssign];
                 [self.tableView reloadData];
             }
         }
//         [self.tableView reloadData];
     }];

    

}




@end
