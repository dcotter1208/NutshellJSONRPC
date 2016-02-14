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
#import "Contact.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contactArray = [NSMutableArray array];
    
    NSURL *URLString = [NSURL URLWithString:@"https://app01.nutshell.com/api/v1/json"];
    
    AFJSONRPCClient *client = [[AFJSONRPCClient alloc]initWithEndpointURL:URLString];
 
    [client setAuthorizationHeaderWithUsername:@"jim@demo.nutshell.com" password:@"43c789d483fd76547b1f157e3cf5e580b95b9d8c"];
    
    [client invokeMethod:@"findContacts"
          withParameters:@{@"stubResponses": @false, @"limit": @100, @"orderBy": @"givenName"}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         NSLog(@"Data returned");
                         for (NSDictionary *dict in responseObject) {
//                             NSLog(@"%@", dict);
                             
                             if ([dict objectForKey:@"email"] != NULL) {
                                 NSDictionary *nameDict = [dict objectForKey:@"name"];
                                 NSDictionary *emailDict = [dict objectForKey:@"email"];
                                 Contact *contact = [Contact contactWithName:[nameDict objectForKey:@"displayName"]];
                                 contact.email = [emailDict objectForKey:@"--primary"];
                                 NSLog(@"%@", contact.name);
                                 NSLog(@"%@", contact.email);
                                 [_contactArray addObject:contact];
                                 NSLog(@"%lu", _contactArray.count);
                             }
                             
                             [self.tableView reloadData];
                             
                         }
                         
                     });

                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     
                     NSLog(@"error: %@", [error description]);
                 }];
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_contactArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Contact *contact = [self.contactArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.email;
    return cell;
    
}
- (IBAction)reloadTableView:(id)sender {
    
    [self.tableView reloadData];
    
}


@end
