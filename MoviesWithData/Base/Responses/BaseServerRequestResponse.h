//
//  BaseResponse.h
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseValidator.h"
#import "BaseResponse.h"

typedef enum {
    ResponseStatusFailure = 0,
    ResponseStatusSuccess
} ResponseStatus;

@interface BaseServerRequestResponse : BaseResponse

@property NSString* methodName;
@property int errorID;
@property NSString* strMessage;
@property NSString* strSubtitle;
@property (strong,nonatomic) NSArray * serverMsgsArr;

@property (assign, nonatomic) ResponseStatus status;

-(void)parseData:(NSDictionary*)JSON;
-(BOOL)isSuccess;
-(BOOL)isFaliure;


@end
