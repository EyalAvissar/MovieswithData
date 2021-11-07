//
//  AppGeneralDeclarationResponse.m
//  Aroma - iOS
//
//  Created by shani daniel on 04/05/2016.
//  Copyright © 2016 Idan. All rights reserved.
//

#import "AppGeneralDeclarationResponse.h"


@implementation AppGeneralDeclarationResponse

-(void)parseData:(NSDictionary *)JSON
{
    [super parseData:JSON];
}

-(NSMutableArray*)createErrorsArrWithKey:(NSString*)key JSON:(NSDictionary*)JSON{
    
    NSMutableArray *arrError = [[NSMutableArray alloc] init];
    
    for (id errorId in [ParseValidator getArrayForKey:key inJSON:JSON defaultValue:[[NSArray alloc]init]]) {
        if (errorId != nil) {
            [arrError addObject:[NSString stringWithFormat:@"%@", errorId]];
        }
    }
    
    return arrError;
}

@end
