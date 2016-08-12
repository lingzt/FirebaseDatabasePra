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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginUserToFirebase];
}


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


@end
