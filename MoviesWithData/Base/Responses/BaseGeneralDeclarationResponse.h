//
//  GeneralDeclarationResponse.h
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "BaseServerRequestResponse.h"

@interface BaseGeneralDeclarationResponse : BaseServerRequestResponse

@property NSMutableArray * results;

@property NSArray* languagesArr;
@property NSArray* cachedMethodsArr;
@property NSMutableArray* HomePageImages;
@property NSDictionary* dictFaqs;
@property NSString* strMediaURL;

@property NSArray* arrThrowErrors;
@property NSArray* arrToMenuErrors;
@property NSArray* arrToRegistrationErrors;
@property NSArray* arrCGErrors;


@property BOOL boolShowErrorID;
@property int intHomePageSlideInterval;
@property NSDictionary* dictMediaFile;
@property NSDictionary* dictTranslations;
@property int intTranslationsLasteUpdateTS;
@property int intGpsTimeout;
@property int intLoaderSpeed;
@property int intRestartOnIdle;
@property int intToastDuration;
@property NSString* strTimeZone;
@property NSString* strCurrentRecievedLanguage;

@property (nonatomic) int methodAttempts;
@property (nonatomic) int methodTimeout;

@property (nonatomic) int homePageAnimationInterval;
@property (nonatomic) int menuButtonAnimationDuration;

@property (nonatomic) int intMethodAttempts;
@property (nonatomic) int intMethodTimeout;

@property (nonatomic) int intGoogleMapZoom;
@property (nonatomic,assign) NSTimeInterval serverRecall;
@property (nonatomic, strong) NSDictionary *dictExceptionalTimeoutMethods;
@property (nonatomic, assign) int exceptionalMethodTimeout;

@end
