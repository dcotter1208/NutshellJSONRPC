//
//  Contact.h
//  NutshellJSON-RPC
//
//  Created by Donovan Cotter on 2/13/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;

- (id) initWithName:(NSString*)name;
+ (id) contactWithName:(NSString *)name;

@end
