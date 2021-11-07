//
//  ValidateVersionResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

//just for a push
#import "ValidateVersionResponse.h"
#import "ApplicationManager.h"

@implementation ValidateVersionResponse

-(void)parseData:(NSDictionary*)JSON{
    NSString *validityState = JSON[@"versionState"];
    Boolean isValid = [validityState isEqualToString:@"valid"];
    
    [[ApplicationManager sharedInstance].startUpManager setIsValidVersion: isValid];
}

@end
