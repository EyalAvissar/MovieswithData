//
//  BaseResponse.m
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "BaseServerRequestResponse.h"


@implementation BaseServerRequestResponse {
    NSDictionary* error;
    NSString* message;
}


-(BaseResponse*)createResponse:(NSDictionary *)JSON{
    
    NSDictionary* dictData = [[NSDictionary alloc]init];
    error = [[NSDictionary alloc]init];
    
    self.status = [ParseValidator getIntForKey:@"status" inJSON:JSON defaultValue:@0];
    error = [ParseValidator getDictionaryForKey:@"err" inJSON:JSON defaultValue:nil];
    message = [ParseValidator getStringForKey:@"message" inJSON:JSON defaultValue:@""];

    if(self.status != ResponseStatusSuccess) {
        
        if([error isKindOfClass:[NSDictionary class]]) {
            self.errorID = (int)[ParseValidator getIntForKey:@"id" inJSON:error defaultValue:@0];
            self.strMessage = [ParseValidator getStringForKey:@"content" inJSON:error defaultValue:@""];
            NSLog(@"ERROR ID: %d, MESSAGE: %@", self.errorID , self.strMessage);
        }
        
    } else {
        
        self.strMessage=message;
        dictData = [ParseValidator getDictionaryForKey:@"data" inJSON:JSON defaultValue:nil];
        
        if(dictData) {
            [self parseData:dictData];
        } else {
            [self parseData:JSON];
        }
        
    }
    return self;
}



-(void)parseData:(NSDictionary*)JSON{
   
}

-(BOOL)isSuccess{
    
    return self.status==1;
}

-(BOOL)isFaliure{
    
    return self.status==0;
}

@end
