//
//  UserProfile.h
//  Ask4Wifi-Objc
//
//  Created by Jahid on 10/16/15.
//  Copyright © 2015 Jahid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *platform;

// From JSON
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *base64ImageString;

// Convenience
@property (assign, nonatomic) BOOL shouldOverrideAddress;

// Init
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// Public
- (NSDictionary *)registerJSON;
- (NSDictionary *)userProfileJSONWithPhoto:(BOOL)hasPhoto;
- (BOOL)validateWithPassword:(BOOL)passwordRequired;
@end
