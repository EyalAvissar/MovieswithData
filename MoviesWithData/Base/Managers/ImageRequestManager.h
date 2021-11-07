//
//  ImageRequestManager.h
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageRequestManager : BaseRequest

+(ImageRequestManager *)sharedInstance;

-(void)imageRequest:(NSString *)imageUrl onCompletion:(void(^)(NSData *data))completion;

@end

NS_ASSUME_NONNULL_END
