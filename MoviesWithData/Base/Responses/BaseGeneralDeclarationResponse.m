 //
//  GeneralDeclarationResponse.m
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "BaseGeneralDeclarationResponse.h"
//#import "LanguageObj.h"
//#import "CachedMethod.h"
@implementation BaseGeneralDeclarationResponse

  
-(id)init
{
    self = [super init];
    
    if(self)
    {
        self.languagesArr = [[NSMutableArray alloc]init];
        self.cachedMethodsArr = [[NSMutableArray alloc]init];
        self.HomePageImages = [[NSMutableArray alloc]init];
        self.dictFaqs = [[NSDictionary alloc]init];
        self.dictMediaFile = [[NSDictionary alloc]init];
        self.dictTranslations = [[NSDictionary alloc]init];
        self.arrThrowErrors = [[NSArray alloc]init];
        self.arrToMenuErrors= [[NSArray alloc]init];
        self.arrToRegistrationErrors= [[NSArray alloc]init];
    }
    
    return self;
}


-(void)parseData:(NSDictionary *)JSON{
    
    
    self.strTimeZone = [ParseValidator getStringForKey:@"time_zone" inJSON:JSON defaultValue:@"Asia/Jerusalem"];
//    [ApplicationManager sharedInstance].timeManager.strTimeZone=self.strTimeZone;
    
    self.strMediaURL = [ParseValidator getStringForKey:@"media_server" inJSON:JSON defaultValue:@""];
    self.boolShowErrorID =[ParseValidator getBoolForKey:@"show_error_id" inJSON:JSON defaultValue:NO];
    self.intTranslationsLasteUpdateTS=[ParseValidator getIntForKey:@"translations_last_update" inJSON:JSON defaultValue:@0];
    

    
    self.strCurrentRecievedLanguage = [ParseValidator getStringForKey:@"language" inJSON:JSON defaultValue:@""];
    self.intHomePageSlideInterval = [ParseValidator getIntForKey:@"home_page_slide_interval" inJSON:JSON defaultValue:@0];
    
    self.intGoogleMapZoom=[ParseValidator getIntForKey:@"google_map_zoom" inJSON:JSON defaultValue:@0];
    
    
    self.intRestartOnIdle = [ParseValidator getIntForKey:@"restart_on_idle" inJSON:JSON defaultValue:@25];
    self.intMethodTimeout=[ParseValidator getIntForKey:@"method_timeout" inJSON:JSON defaultValue:@10];
    
    self.exceptionalMethodTimeout = [ParseValidator getFloatForKey:@"exceptional_method_timeout" fromJSONDict:JSON withDefaultValue:40];

    
    self.dictExceptionalTimeoutMethods = [ParseValidator getDictionaryForKey:@"exceptional_method_timeoutArr" inJSON:JSON defaultValue:[NSDictionary new]];
    
    
    //LANGUAGES
    NSArray* arrForLanguages = [[NSArray alloc]initWithArray:[ParseValidator getArrayForKey:@"languagesArr" inJSON:JSON defaultValue:nil]];
//    LanguageObj* language = [[LanguageObj alloc]init];
//    self.languagesArr = [ParseValidator createArrayOfObjects:language fromArray:arrForLanguages];

    
    //CACHED METHODS
    NSArray* arrCached = [ParseValidator getArrayForKey:@"cachedArr" inJSON:JSON defaultValue:nil];
//    CachedMethod* cachedMethod = [[CachedMethod alloc]init];
//    self.cachedMethodsArr = [ParseValidator createArrayOfObjects:cachedMethod fromArray:arrCached];


   // self.dictMediaFile = [ParseValidator getDictionaryForKey:@"media_file" inJSON:JSON defaultValue:nil];
    
    
//    NSDictionary *dictTranslations = [[ApplicationManager sharedInstance] loadTranslationsFromDisk];
    
//    self.dictTranslations = [ParseValidator getDictionaryForKey:@"translationsArr" inJSON:JSON defaultValue:dictTranslations];
    
    
//    [[ApplicationManager sharedInstance]saveTranslationsToDisk:self.dictTranslations];
    
    
    //ERRORS ARARYS
    
    NSMutableArray *arrThrowError = [[NSMutableArray alloc] init];
    
    
    
    for (id errorId in [ParseValidator getArrayForKey:@"throw_errorArr" inJSON:JSON defaultValue:[[NSArray alloc]init]]) {
        if (errorId != nil) {
            [arrThrowError addObject:[NSString stringWithFormat:@"%@", errorId]];
        }
    }

    
    NSMutableArray *arrThrowToMenuErrors = [[NSMutableArray alloc] init];
    
    
    for (id errorId in [ParseValidator getArrayForKey:@"throw_to_menu_errorArr" inJSON:JSON defaultValue:[[NSArray alloc]init]]) {
        if (errorId != nil) {
            [arrThrowToMenuErrors addObject:[NSString stringWithFormat:@"%@", errorId]];
        }
    }
    
    
    NSMutableArray *arrThrowToLogginErrors = [[NSMutableArray alloc] init];
    
    for (id errorId in [ParseValidator getArrayForKey:@"throw_to_registrationArr" inJSON:JSON defaultValue:[[NSArray alloc]init]]) {
        if (errorId != nil) {
            [arrThrowToLogginErrors addObject:[NSString stringWithFormat:@"%@", errorId]];
        }
    }
    
    NSMutableArray *arrCGErrors = [[NSMutableArray alloc] init];
    
    for (id errorId in [ParseValidator getArrayForKey:@"cg_errorsArr" inJSON:JSON defaultValue:[[NSArray alloc]init]]) {
        if (errorId != nil) {
            [arrCGErrors addObject:[NSString stringWithFormat:@"%@", errorId]];
        }
    }
    
    
    self.arrThrowErrors=arrThrowError;
    self.arrToMenuErrors=arrThrowToMenuErrors;
    self.arrToRegistrationErrors=arrThrowToLogginErrors;
    self.arrCGErrors=arrCGErrors;

//    [[TimeManager sharedInstance]intTSNow];
    
    
    
}


-(NSArray *)convertNumberArrayToStringArray:(NSArray *)numbers {
    NSMutableArray* tempStringsArr = [NSMutableArray new];
    for (id number in numbers) {
        if ([number isKindOfClass:[NSNumber class]]) {
            [tempStringsArr addObject:[number stringValue]];
        }
        else if([number isKindOfClass:[NSString class]]){
            NSString* strNum = (NSString*)number;
            if (strNum.length > 0) {
                [tempStringsArr addObject:number];
            }
        }
    }
    return [NSArray arrayWithArray:tempStringsArr];
}



@end
