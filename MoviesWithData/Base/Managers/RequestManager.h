//
//  RequestManager.h
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "ServerRequestDoneProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface RequestManager : NSObject

+(RequestManager *)sharedInstance;

@property (nonatomic, strong) NSMutableArray *arrDebugToast;
@property (nonatomic, strong) NSString *hostURLstr;
@property (nonatomic, strong) NSString * strApplicationToken;
@property (nonatomic, strong) NSArray * getMethodsArr;
@property (nonatomic, strong) NSString * strFamailrIp;

-(void)sendRequestForRequest: (BaseRequest*) baseRequest;

-(void)addServerRequestDoneDelegate:(id<ServerRequestDoneProtocol>)caller;
-(void)removeServerRequestDoneDelegate:(id<ServerRequestDoneProtocol>)caller;

-(NSMutableURLRequest*)getRequestWith:(NSString*)strUrl andSessionFrom:(NSString*)strSession headerField:(NSString*)headerField;
-(NSMutableURLRequest*)getAppRequestWith:(NSString*)strUrl andSessionFrom:(NSString*)strSession;

@end

NS_ASSUME_NONNULL_END
