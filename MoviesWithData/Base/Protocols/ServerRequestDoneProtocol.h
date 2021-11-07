//
//  ServerRequestDoneProtocol.h
//  Azrieli
//
//  Created by Idan Dreispiel on 12/16/15.
//  Copyright © 2015 shani daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseRequest;
@class BaseServerRequestResponse;

@protocol ServerRequestDoneProtocol <NSObject>
@required
-(void)serverRequestSucceed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest;
-(void)serverRequestFailed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest;


@optional
-(void)serverRequestSucceed:(BaseServerRequestResponse *)baseResponse block:(void(^)(BOOL done))block;
-(void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse block:(void (^)(BOOL))block;





@end
