//
//  TestObjc.m
//  ChabokDemo
//
//  Created by Hossein Shooshtari on 8/4/21.
//

#import "TestObjc.h"
#import <Foundation/Foundation.h>
#import <ChabokKit/ChabokKit-Swift.h>

@implementation TestObjc

- (void)testObjc {
    
    [Chabok initializeWithClientId:@"CLIENT_ID" clientSecret:@"CLIENT_SECRET" callback:^(BOOL success,NSString* message) {
        if (success){} else {}
    }];
    
    if(!Chabok.user.isLoggedIn) {
        
    }
    
    [Chabok.user logout];
    
    [Chabok.user loginWithUserId:@""];

    [Chabok.user loginWithUserId:@"mobile" callback:^(BOOL success,NSString* message) {
        if (success){} else {}
    }];
    
    [[Chabok user]setPushIdWithId:@"h723ynsu8x9bcxnzxm239" callback:^(BOOL success,NSString* message) {
        if (success){} else {}
    }];

    [[Chabok user]logoutWithCallback:^(BOOL success,NSString* message) {
        if (success){} else {}
    }];
    
//    NSString *userID = [[Chabok user]getUserId];
//
//    BOOL isLoggedIn = [[Chabok user]isLoggedIn];

    [Chabok setLogLevelWithLogLevel:LogLevelVerbose];

    [Chabok lockLoggingWithLock:NO];
    
    [Chabok disableSdkWithDisableSdk:NO];

    [Chabok initializeWithClientId:@"CLIENT_ID" clientSecret:@"CLIENT_SECRET" callback:^(BOOL success,NSString* message) {
        if (success){
            NSLog(@"Successfully initialized.");
        } else {
            NSLog(@"%@", message);
        }
    }];
    
    [[Chabok user]setAttributeWithKey:@"KEY" value:@"VALUE"];
    

    ProfileBuilder *profile = [ProfileBuilder new];
    [profile email:@""];
    [profile mobile:@""];
    [profile name:@""];
    [profile family:@""];
    [profile birthDate:@""];
    [profile timeZone:@""];
    [profile gender:GenderMALE];
    
    [[Chabok user]setProfileWithProfile: profile.build callback:^(BOOL success,NSString* message) {
        if (success){} else {}
    }];
    
    [[Chabok user]setLocationWithLatitude:25.777 longitude:34.6767];
    
    [[Chabok user]setPushIdWithId:@""];
    
    NSDictionary *body = @{
        @"product_id": @"123456",
        @"name": @"T-shirt",
        @"quantity": @10,
        @"category": @"Clothes",
        @"price": @100.25,
        @"currency": @"USD",
        @"chosen_colors": @[@"Black", @"Blue", @"White"],
        @"discounted": @YES,
        @"discount_percent":@15
        
    };

        
    [[Chabok analytics]sendEventWithId:@"" body:body];
    
}

@end
