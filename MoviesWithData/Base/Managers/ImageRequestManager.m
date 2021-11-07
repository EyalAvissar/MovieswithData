//
//  ImageRequestManager.m
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "ImageRequestManager.h"
#import <UIKit/UIKit.h>

static ImageRequestManager* _sharedInstance = nil;

@implementation ImageRequestManager

+(ImageRequestManager *)sharedInstance {
    
    if (!_sharedInstance) {
        _sharedInstance = [[ImageRequestManager alloc] init];
    }
    
    return _sharedInstance;
}

-(void)imageRequest:(NSString *)imageUrl onCompletion:(void(^)(NSData *data))completion {
    NSData *receivedData;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *imageTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            completion(data);
        }
        else
        {
            NSLog(@"Error: %@", error);
        }
    }];
    
    [imageTask resume];
}

@end
