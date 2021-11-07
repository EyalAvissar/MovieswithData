//
//  ApplicationTokenResponse.h
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "BaseServerRequestResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationTokenResponse : BaseServerRequestResponse

@property (strong, nonatomic) NSString *strApplicationToken;

@end

NS_ASSUME_NONNULL_END
