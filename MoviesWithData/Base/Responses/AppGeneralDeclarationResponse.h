//
//  AppGeneralDeclarationResponse.h
//  Aroma - iOS
//
//  Created by shani daniel on 04/05/2016.
//  Copyright © 2016 Idan. All rights reserved.
//

#import "BaseGeneralDeclarationResponse.h"
#import <CoreLocation/CoreLocation.h>


@interface AppGeneralDeclarationResponse : BaseGeneralDeclarationResponse

//Banner properties
//Better create a banner object and hold it as a property
@property (nonatomic, strong) NSString *bannerImageUrl;
@property (nonatomic, strong) NSString *bannerVideoUrl;
@property Boolean isBannerToAppear;
//Banner properties

@property NSString *moviesLastUpdate;
@property NSString *cinemasLastUpdate;

@end
