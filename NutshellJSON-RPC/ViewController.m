//
//  ViewController.m
//  NutshellJSON-RPC
//
//  Created by Donovan Cotter on 2/11/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "ViewController.h"
#import "AFJSONRPCClient.h"
#import "AFJSONRequestOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *URLString = [NSURL URLWithString:@"https://app01.nutshell.com/api/v1/json"];
    
    AFJSONRPCClient *client = [[AFJSONRPCClient alloc]initWithEndpointURL:URLString];
 
    [client setAuthorizationHeaderWithUsername:@"jim@demo.nutshell.com" password:@"43c789d483fd76547b1f157e3cf5e580b95b9d8c"];
    
    [client invokeMethod:@"findContacts"
          withParameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     //success handling
                     NSLog(@"%@", responseObject);
                     
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     
                     //error handling
                     NSLog(@"error: %@", [error description]);
                 }];
    
    
    //*********************


//    NSURL *nutshellBaseURL = [NSURL URLWithString:@"https://app01.nutshell.com/api/v1/"];
//    
//    AFJSONRPCClient *client = [[AFJSONRPCClient alloc]initWithBaseURL:nutshellBaseURL];
//    
//    [client setAuthorizationHeaderWithUsername:@"jim@demo.nutshell.com" password:@"43c789d483fd76547b1f157e3cf5e580b95b9d8c"];
//
////    NSMutableURLRequest *request = [client requestWithMethod:@"findContacts" path:@"json" parameters:nil];
//    NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://app01.nutshell.com/api/v1/json"]];
//    [re setHTTPMethod:@"GET"];
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:re success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSData *JSON) {
//        
//    NSLog(@"Auth satisfied: %@", JSON.description);
//
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        NSLog(@"%@", error);
//
//    }];
//    
//    [operation start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
