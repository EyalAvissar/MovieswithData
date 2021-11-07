//
//  AbstractViewController.h
//  Aroma - iOS
//
//  Created by Simon Janevski on 3/22/16.
//  Copyright © 2016 Idan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationUpdatableProtocol.h"
#import "ServerRequestDoneProtocol.h"

@protocol GoogleAnalyticsProtocol <NSObject>

-(NSString*)getScreenName;

@end

typedef enum {
	LanguageEnglish,
	LanguageHebrew
} Language;

@interface IMAbstractViewController : UIViewController <ServerRequestDoneProtocol>

@property (nonatomic, assign) BOOL shouldReversePushDirection;

//- (void)checkAndShowStackedAlert;
//
//- (void)fillTextWithTrans;
//
//@property (nonatomic, assign) BOOL shouldBackToHomePage;
//@property (nonatomic, assign) BOOL shouldHideTabBar;
//
//@property (nonatomic, assign) BOOL skipUpdatingAccessibility;
//
//- (void)focusOnHeaderAccessibility;
//- (void)updateAccessibility;

@end
