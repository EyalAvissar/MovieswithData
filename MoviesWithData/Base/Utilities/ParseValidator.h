//
//  ValidateParserType.h
//  Azrieli
//
//  Created by inmanage on 8/19/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
@interface ParseValidator : NSObject

+(NSString*)getStringForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(NSDictionary*)getDictionaryForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(NSArray*)getArrayForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(int)getIntForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(float)getFloatForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(double)getDobuleForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(BOOL)getBoolForKey:(NSString*)key inJSON: (id)JSON defaultValue: (BOOL) defaultValue;
+(NSNumber*)getNSnumberForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(NSURL*)getNSURLForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue;
+(NSArray*)createArrayOfObjects: (BaseResponse*) response fromArray: (NSArray*)arrBeforeParsing;
+(NSArray*)createArrayOfObjects: (BaseResponse*) response fromDictionary: (NSDictionary*)dictBeforeParsing;
+(NSArray*)numbersArrToStringArr:(NSArray*)arr;
+(NSArray*)createArrayOfObjectsWithsubDict: (BaseResponse*) response fromDictionary: (NSDictionary*)dictBeforeParsing;
+(NSDictionary*)createDictOfObjects: (BaseResponse*) response fromDictionary: (NSDictionary*)dictBeforeParsing;
+(NSArray*)sortArrBySortOrder:(NSArray*)arr;
+(NSString*)getImageStringFromJSON:(id)JSON;
+(NSDictionary*)parseUrlToJson:(NSString*)url fromSubString:(NSString*)subString;
+ (float)getFloatForKey:(NSString*)key fromJSONDict:(id)JSONDict withDefaultValue:(float)defaultValue;
@end
