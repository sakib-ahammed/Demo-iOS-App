//
//  TDConstants.h
//  Ask4Wifi-Objc
//
//  Created by Jahid on 10/16/15.
//  Copyright © 2015 Jahid. All rights reserved.
//

#ifndef TDConstants_h
#define TDConstants_h

// url
//#define SERVICE_BASE_URL @"http://wierwinhuizingafi.com/ask4wifi/"
#define SERVICE_BASE_URL @"http://erwinhuizingaconn.com/ask4wifi/"

// os
#define PLATFORM_IOS @"1"

// user
#define SERVICE_REMEMBER_KEY @"kServiceStoreKey"

#define SERVICE_EMAIL_KEY    @"kServiceEmailKey"
#define SERVICE_PASSWORD_KEY @"kServicePasswordKey"

#define SERVICE_USER_KEY    @"kServiceUserKey"
#define SERVICE_TYPE_KEY    @"kServiceTypeKey"

// payment

#define PAYMENT_REMEMBER_KEY @"paymentAcountSoteKey"
#define PAYMENT_MESSAGE @"paymentAcountsStored"

// error
#define SUCCESS_CODE @"200"

//paypal
#define PAYPAL_PRODUCTION   @""
#define PAYPAL_SANDBOX      @"Af0eaWCdFrN6Kzhwhw_dhuZqMSadycdgrOIFxhXcSJrZCdBofj3gIEuh9z8mhivV2w7ODTD7qHFsZyuo"

#define ANIM_FADE_DURATION   0.5
#define ANIM_DELAY_DURATION  0.5


static NSString *const StripePublishableKeyAppOwner = @"pk_test_VtT3M35UhcH6MorKvdNPr6E4";
static NSString *const BackendChargeURLStringAppOwner = @"https://askwifi.herokuapp.com";
static NSString *const AppleMerchantIdAppOwner = @"";

//static NSString *const StripePublishableKeyWifiOwner = @"pk_test_PTwA6lvjQaMg33Gc1E1vmQwR";
static NSString *const BackendChargeURLStringWifiOwner = @"https://askme4wifi.herokuapp.com";
//static NSString *const AppleMerchantIdWifiOwner = @"";

typedef NS_OPTIONS(NSUInteger, TDSlideMenuItem) {
    TDSlideMenuItemHome,
    TDSlideMenuItemAddWifi,
    TDSlideMenuItemProfile,
    TDSlideMenuItemPendingWifiList,
    TDSlideMenuItemUpdatePassword,
    TDSlideMenuItemLogout
};

typedef NS_OPTIONS(NSUInteger, TDSlideMenuItemForUser) {
    TDSlideMenuItemForUserHome,
    TDSlideMenuItemForUserProfile,
    TDSlideMenuItemForUserUpdatePassword,
    TDSlideMenuItemForUserLogout
};


#endif /* TDConstants_h */
