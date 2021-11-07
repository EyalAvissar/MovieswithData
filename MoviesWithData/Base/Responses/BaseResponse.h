//
//  BaseResponse.h
//  Azrieli
//
//  Created by shani daniel on 5 Tevet 5776.
//  Copyright © 5776 shani daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject <NSSecureCoding, NSCopying>
@property (strong,nonatomic) NSNumber * numSortOrder;

- (instancetype) createResponse:(NSDictionary*)JSON;

@end
