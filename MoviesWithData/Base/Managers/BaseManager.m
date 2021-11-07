//
//  BaseManager.m
//  Azrieli
//
//  Created by Idan Dreispiel on 12/16/15.
//  Copyright © 2015 shani daniel. All rights reserved.
//

#import "BaseManager.h"

@implementation BaseManager


-(void)reset{
    
}

#pragma mark ServerRequestDoneDelegate

-(void)serverRequestSucceed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest{
}

-(void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest{
}


@end
