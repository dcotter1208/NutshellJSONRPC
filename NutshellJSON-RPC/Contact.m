//
//  Contact.m
//  NutshellJSON-RPC
//
//  Created by Donovan Cotter on 2/13/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (id) initWithName:(NSString*)name {
    self = [super init];
    
    if (self) {
        _name = name;
    }
    return self;
}

+ (id) contactWithName:(NSString *)name {
    return [[self alloc]initWithName:name];
}

@end
