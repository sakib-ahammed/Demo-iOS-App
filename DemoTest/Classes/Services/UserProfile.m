//
//  UserProfile.m
//  Ask4Wifi-Objc
//
//  Created by Jahid on 10/16/15.
//  Copyright © 2015 Jahid. All rights reserved.
//

#import "UserProfile.h"
#import "NSDictionary+TD.h"

@implementation UserProfile

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _email = @"";
        _firstName = @"";
        _lastName = @"";
        _password = @"";
        _type     = @"";
        _platform = @"1";
        _base64ImageString = @"";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _email = [dictionary td_objectForKey:@"email"];
        _firstName = [dictionary td_objectForKey:@"first_name"];
        _lastName = [dictionary td_objectForKey:@"last_name"];
        _password = [dictionary td_objectForKey:@"password"];
        _base64ImageString = [dictionary td_objectForKey:@"photo"];
        _type = [dictionary td_objectForKey:@"user_type"];
        _platform = [dictionary td_objectForKey:@"os"];
    }
    return self;
}

#pragma mark - Public
- (NSDictionary *)registerJSON {
    NSDictionary *defaultDictionary = @{@"email": _email,
                                        @"password": _password,
                                        @"first_name": _firstName,
                                        @"last_name": _lastName,
                                        @"photo": _base64ImageString,
                                        @"os": _platform
                                        };
    
    NSMutableDictionary *JSON = [[NSMutableDictionary alloc] initWithDictionary:defaultDictionary];
    if (_shouldOverrideAddress) {
        [JSON setObject:@"true" forKey:@"override_address"];
    }
    return JSON;
}

- (NSDictionary *)userProfileJSONWithPhoto:(BOOL)hasPhoto {
    NSDictionary *defaultDictionary = @{
                                        @"email": _email,
                                        @"first_name": _firstName,
                                        @"last_name": _lastName,
                                        @"os": _platform};
    
    NSMutableDictionary *JSON = [[NSMutableDictionary alloc] initWithDictionary:defaultDictionary];
//    if (hasPhoto) {
//        [JSON setObject:_base64EncodedImage forKey:@"photo"];
//    }
    return JSON;
}

- (BOOL)validateWithPassword:(BOOL)passwordRequired {
    return
    _email.length > 0 &&
    _firstName.length > 0 &&
    _lastName.length > 0 &&
    _base64ImageString.length >0 &&
    (passwordRequired ? _password.length > 0 : YES);
}

//-(BOOL)validateWithPaymentAccount
//{
//    return _email.length > 0 && _firstName.length > 0 && _lastName.length > 0 && _password.length>0 && _paypalEmail.length > 0 && _stripeSecreteKey.length == 32 && [_stripeSecreteKey hasPrefix:@"sk_"] && _stripePublishableKey.length == 32 && [_stripePublishableKey hasPrefix:@"pk_"] && _base64ImageString.length>0;
//}

#pragma mark - Memory management

- (void)dealloc {
    _email = nil;
    _firstName = nil;
    _lastName = nil;
    _password = nil;
    _base64ImageString = nil;
    _type = nil;
    _platform = nil;
}

@end
