//
//  ApplicationTokenResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "ApplicationTokenResponse.h"

@implementation ApplicationTokenResponse

-(void)parseData:(NSDictionary *)JSON{
    
    self.strApplicationToken = [NSString stringWithFormat:@"%@",JSON[@"token"]];
}

@end
