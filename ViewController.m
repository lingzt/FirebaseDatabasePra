//
//  ViewController.m
//  FirebaseDatabasePra
//
//  Created by ling toby on 8/10/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ViewController.h"
@import Firebase;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
NSArray *guestArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginUserToFirebase];
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
    cell.textLabel.text = @"test cell";
    return cell;

}


#pragma mark -- retrieve 




@end
