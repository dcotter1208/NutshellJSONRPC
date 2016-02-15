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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityIndicator startAnimating];
    
    _contactArray = [NSMutableArray array];
    
    NSURL *URLString = [NSURL URLWithString:@"https://app01.nutshell.com/api/v1/json"];
    
    AFJSONRPCClient *client = [[AFJSONRPCClient alloc]initWithEndpointURL:URLString];
 
    [client setAuthorizationHeaderWithUsername:@"jim@demo.nutshell.com" password:@"43c789d483fd76547b1f157e3cf5e580b95b9d8c"];
    
    [client invokeMethod:@"findContacts"
          withParameters:@{@"entityType": @"Contacts", @"stubResponses": @false, @"limit": @100, @"orderBy": @"givenName"}
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         for (NSDictionary *dict in responseObject) {
                             if ([dict objectForKey:@"email"] != NULL) {
                                 Contact *contact = [Contact contactWithName:[dict valueForKeyPath:@"name.displayName"]];
                                 contact.email = [dict valueForKeyPath:@"email.--primary"];
                                 [_contactArray addObject:contact];
                             }
                             [self.activityIndicator stopAnimating];
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


@end
