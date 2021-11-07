//
//  Constants.h
//  Aroma - iOS
//
//  Created by shani daniel on 31/03/2016.
//  Copyright © 2016 Idan. All rights reserved.
//



// Base Constant

//test flight - version 1.1

#define originalNumOfCalls 9

#define DebugMode NO

#ifdef DEBUG
#define sharedAnalytics NO
#else
#define sharedAnalytics YES
#endif
#define kApplicationSecurityToken @"inmanga_secure"

//base startUp Methods
#define mGetHostUrl @"getHostUrl"
#define mClearSession @"clearSession"
#define mApplicationToken @"applicationToken"
#define mSetSettings @"setSettings"
#define mValidateVersion @"validateVersion"
#define mGeneralDeclaration @"generalDeclaration"
#define mGetMovies @"getMovies"
#define mGetCinemas @"getCinemas"
#define mDescriptionMovies @"descriptionMovies"
#define mMovieImage @"movieImage"

// Notification names
#define kNotificationNameUpdateLoader @"notificationNameUpdateLoader"
#define kNotificationParamMethodName @"notificationParamMethodName"

