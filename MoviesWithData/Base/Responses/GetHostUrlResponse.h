//
//  GetHostUrlResponse.h
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "BaseServerRequestResponse.h"
@interface GetHostUrlResponse : BaseServerRequestResponse


@property (nonatomic,strong) NSMutableArray * results;
@property (nonatomic,strong) NSString* hostURL;
@property (nonatomic,strong) NSString* getURL;

@property (nonatomic,strong) NSString* strSplashTxt;
@property (nonatomic,strong) NSString* strSplashSubTxt;
@property (strong, nonatomic) NSArray *getMethodsArr;

@end

