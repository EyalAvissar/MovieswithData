//
//  BaseResponse.m
//  Azrieli
//
//  Created by shani daniel on 5 Tevet 5776.
//  Copyright © 5776 shani daniel. All rights reserved.
//

#import "BaseResponse.h"
#import "ParseValidator.h"

@implementation BaseResponse

-(instancetype)createResponse:(NSDictionary*)JSON{
    
    BaseResponse* baseResponse=[[BaseResponse alloc]init];
    baseResponse.numSortOrder=[ParseValidator getNSnumberForKey:@"order_num" inJSON:JSON defaultValue:@0];
    
    return baseResponse;
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    
    self = [self init];
    if (!self) {
        return nil;
    }
    
    self.numSortOrder = [decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(numSortOrder))];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.numSortOrder forKey:NSStringFromSelector(@selector(numSortOrder))];
}


#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    BaseResponse *response = [[[self class] allocWithZone:zone] init];
    response.numSortOrder = self.numSortOrder;
    return response;
}

@end
