//
//  NSDictionary+TD.m
//  Ask4Wifi-Objc
//
//  Created by Jahid on 10/16/15.
//  Copyright © 2015 Jahid. All rights reserved.
//

#import "NSDictionary+TD.h"

@implementation NSDictionary (TD)

- (id)td_objectForKey:(id)aKey {
    id object = [self valueForKey:aKey];
    if (object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end
