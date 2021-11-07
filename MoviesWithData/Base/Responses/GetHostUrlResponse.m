//
//  GetHostUrlResponse.m
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "GetHostUrlResponse.h"
#import "ApplicationManager.h"

@implementation GetHostUrlResponse

-(void)parseData:(NSDictionary *)JSON {

    self.hostURL = [ParseValidator getStringForKey:@"url" inJSON:JSON defaultValue:@""] ;
    NSLog(@"%@",self.hostURL);
}


@end


