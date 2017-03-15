//
//  TDServices.h
//  Ask4Wifi-Objc
//
//  Created by Jahid on 10/16/15.
//  Copyright © 2015 Jahid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^ServiceErrorBlock)(NSError *error, NSDictionary *errorJSON);

@interface TDServices : NSObject

// Singleton
+ (instancetype)sharedService;

// defualts
- (AFHTTPRequestOperationManager*)defaultManager;
- (AFHTTPRequestOperationManager*)defaultGetManager;
- (AFHTTPRequestOperationManager*)defaultPostManager;

// General
- (void)performErrorBlock:(ServiceErrorBlock)errorBlock error:(NSError *)error;
- (void)updateUserFields:(NSDictionary *)parameters successBlock:(void (^)())successBlock errorBlock:(ServiceErrorBlock)errorBlock;

- (void)fetchOwnerWiFiWith:(NSString *)userid successBlock:(void (^)(NSArray* list))successBlock errorBlock:(ServiceErrorBlock)errorBlock;

// property
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@end
