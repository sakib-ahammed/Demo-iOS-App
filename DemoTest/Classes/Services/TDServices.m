//
//  TDServices.m
//  Ask4Wifi-Objc
//
//  Created by Jahid on 10/16/15.
//  Copyright © 2015 Jahid. All rights reserved.
//

#import "TDServices.h"
#import "TDConstants.h"

@implementation TDServices
#pragma mark - Singleton

+ (instancetype)sharedService {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.email      = [[NSUserDefaults standardUserDefaults] objectForKey:SERVICE_EMAIL_KEY];
        self.password   = [[NSUserDefaults standardUserDefaults] objectForKey:SERVICE_PASSWORD_KEY];
    }
    return self;
}

#pragma mark - Defaults

- (AFHTTPRequestOperationManager*)defaultManager {
    AFHTTPRequestOperationManager *manager          = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_BASE_URL]];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    return manager;
}

- (AFHTTPRequestOperationManager *)defaultGetManager {
    AFHTTPRequestOperationManager *manager = [self defaultManager];
    manager.requestSerializer               = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:self.email password:self.password];
    
    return manager;
}

- (AFHTTPRequestOperationManager *)defaultPostManager {
    AFHTTPRequestOperationManager *manager  = [self defaultManager];
    manager.requestSerializer               = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:self.email password:self.password];
    
    return manager;
}

#pragma mark - General

- (void)performErrorBlock:(ServiceErrorBlock)errorBlock error:(NSError *)error {
    NSData *errorData   = error.userInfo[@"com.afnetworking.serialization.response.error.data"];
    NSArray *errors     = nil;
    
    if (errorData) {
        errors          = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:nil];
    }
    
    if (errorBlock && errors.count > 0) {
        errorBlock(error, errors[0]);
    } else if (errorBlock && (!errors || errors.count == 0)) {
        errorBlock(error, nil);
    }
}


- (void)fetchOwnerWiFiWith:(NSString *)userid successBlock:(void (^)(NSArray* list))successBlock errorBlock:(ServiceErrorBlock)errorBlock {
    AFHTTPRequestOperationManager *manager = [self defaultManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary* parameters = @{@"owner_id": userid};
    [manager POST:@"wifi_list_owner.php" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(![responseDict respondsToSelector:@selector(objectForKey:)]) {
            NSLog(@"Invalid data format");
            successBlock(nil);
        }
        
        if ([responseDict[@"status"] isEqual:SUCCESS_CODE]) {
            if (successBlock) {
                successBlock(@[responseDict[@"free_list"], responseDict[@"paid_list"]]);
            }
        }else {
            NSString* message = responseDict[@"msg"];
            if ([responseDict[@"status"] isEqualToString:@"400"]) {
                message = @"Registration failed";
            }
            NSError* error = [NSError errorWithDomain:operation.request.URL.absoluteString
                                                 code:[responseDict[@"status"] integerValue]
                                             userInfo:@{@"message":message}];
            
            errorBlock(error, nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self performErrorBlock:errorBlock error:error];
    }];
}


@end
