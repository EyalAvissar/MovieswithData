//
//  ValidateParserType.m
//  Meshulam
//
//  Created by inmanage on 8/19/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "ParseValidator.h"

@implementation ParseValidator

+(NSString*)getStringForKey:(NSString*)key inJSON: (id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return defaultValue;
    id result = [JSON objectForKey:key];
    
    if(result == [NSNull null])
    {
        result = defaultValue;
    }
    else
    if([result isKindOfClass:[NSNumber class]])
    {
        result = [result stringValue];
    }
    else
    if([result isKindOfClass:[NSURL class]])
    {
        result = [result absoluteString];
    }

    else
        if([result isKindOfClass:[NSString class]])
        {
            //do nothing
        }

    else{
        result = defaultValue;
    }
    
    
    return   result;

}

+(NSString*)getImageStringFromJSON:(id)JSON {
    NSString *oldImage = [ParseValidator getStringForKey:@"image"     inJSON:JSON defaultValue:@""];
    NSString *newImage = [ParseValidator getStringForKey:@"new_image" inJSON:JSON defaultValue:@""];
    BOOL hasNewImage = newImage && [newImage length];
    return hasNewImage ? newImage : oldImage;
}


+(NSDictionary*)getDictionaryForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return defaultValue;

    id result = [JSON objectForKey:key];
    
    if(result == [NSNull null])
    {
        
        result = defaultValue;
    }
    else
    if ([result isKindOfClass:[NSDictionary class]]) {
        
        //do nothing
    }
    else
    if ([result isKindOfClass:[NSArray class]]) {
        
        result=defaultValue;
    }
    else{
        
        result = defaultValue;
    }
     
    return result;
}


+(NSArray*)getArrayForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return defaultValue;

    id result = [JSON objectForKey:key];
    
    if(result == [NSNull null])
    {
        result = defaultValue;
    }
    
    if ([result isKindOfClass:[NSArray class]]) {
        //do nothing
    }
    else
    if([result isKindOfClass:[NSDictionary class]]){
        NSArray *values = [result allValues];
        result=values;
    }
    else{
       
        result = defaultValue;
    }
    return result;
}

+(int)getIntForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return [defaultValue intValue];

    id result = [JSON objectForKey:key];
    
    if(result == [NSNull null] || result == nil)
    {
        result = defaultValue;
    }
    else
    if ([result isKindOfClass:[NSString class]]) {
            int temp=[result intValue];
            return temp;
    }
    else
    if ([result isKindOfClass:[NSNumber class]]){
        int temp=[result intValue];
        return temp;
    }
    else{
        //float , double
        int temp=(int)result;
        return temp;
    }
    
    return [result intValue];
}

+(float)getFloatForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return [defaultValue floatValue];

    id result = [JSON objectForKey:key];

    if(result == [NSNull null])
    {
        result = defaultValue;
    }
    
    return [result floatValue];
}

+(double)getDobuleForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return [defaultValue doubleValue];

    id result = [JSON objectForKey:key];
    
    if(result == [NSNull null])
    {
        result = defaultValue;
    }
    return [result doubleValue];
}

+(BOOL)getBoolForKey:(NSString *)key inJSON:(id)JSON defaultValue: (BOOL) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return defaultValue;
    
    if(![JSON objectForKey:key])
        return defaultValue;

    id strResult = [JSON objectForKey:key];
    
    
    if ([strResult isKindOfClass:[NSString class] ]&& ![strResult isEqualToString:@"1"]&& ![strResult isEqualToString:@"0"]) {
        if ([strResult isEqualToString:@"true"]||[strResult isEqualToString:@"True"]||[strResult isEqualToString:@"TRUE"]) {
            return YES;
        }
        else{
            return NO;
        }
    }
    else if ([strResult isKindOfClass:[NSNumber class] ]) {
        
        int val = [strResult intValue];
        if (val==0) {
            return NO;
        }
        else{
            return YES;
        }
    }
    else if ([strResult isKindOfClass:[NSNull class]]){
        return defaultValue;
    }

    BOOL result = [[JSON objectForKey:key]boolValue];

    return result;
    
}

+(NSNumber*)getNSnumberForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return defaultValue;

    id result = [JSON objectForKey:key];
    
    if(result == [NSNull null])
    {
        result = defaultValue;
    }
    else
    if ([result isKindOfClass:[NSString class]]) {
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numFormatter.maximumFractionDigits = 3;
        result=[numFormatter numberFromString:result];
    }
    if (!result)
        result=defaultValue;
    
    return result;
    
}


+(NSURL*)getNSURLForKey:(NSString *)key inJSON:(id)JSON defaultValue: (id) defaultValue
{
    if(![JSON isKindOfClass:[NSDictionary class]])
        return defaultValue;

    id result = [JSON objectForKey:key];

    if(result == [NSNull null])
    {
        
        result=defaultValue;
    }
    else
    if ([result isKindOfClass:[NSURL class]]) {
        //do nothing
    }
    else
    if([result isKindOfClass:[NSString class]]){
        NSURL* url=[NSURL URLWithString:result];
        result=url;
    }
    else{
        
        result=defaultValue;
    }
    
    return result;
    
}




+(NSArray*)createArrayOfObjects: (BaseResponse*) response fromArray: (NSArray*)arrBeforeParsing{
    NSMutableArray * tempResultArray=[[NSMutableArray alloc]init];
   
    
    for(NSDictionary * dictObjectInfo in arrBeforeParsing)
    {
        BaseResponse * theResponse = [response createResponse:dictObjectInfo];
        if(theResponse)
        [tempResultArray addObject:theResponse];
        
            
    }
    
    
    
        NSArray* sorted = [tempResultArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSNumber * first = ((BaseResponse*)obj1).numSortOrder;
            NSNumber * second = ((BaseResponse*)obj2).numSortOrder;
            
            if(!first)
                first=[NSNumber numberWithInt:99];
            if(!second)
                second=[NSNumber numberWithInt:99];

            return [first compare:second];
        }];
    return [NSArray arrayWithArray:sorted];
    
}

+(NSArray*)createArrayOfObjects: (BaseResponse*) response fromDictionary: (NSDictionary*)dictBeforeParsing{
    NSMutableArray * tempResultArray=[[NSMutableArray alloc]init];
    
    
    for(NSString * key in [dictBeforeParsing allKeys])
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[dictBeforeParsing objectForKey:key] forKey:key];
        [tempResultArray addObject:[response createResponse:dict]];
        
        
    }
    
    return [NSArray arrayWithArray:tempResultArray];
    
}

+(NSDictionary*)createDictOfObjects: (BaseResponse*) response fromDictionary: (NSDictionary*)dictBeforeParsing{
    NSMutableDictionary * tempResultDict=[[NSMutableDictionary alloc]init];
    
    for(NSString * key in [dictBeforeParsing allKeys])
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[dictBeforeParsing objectForKey:key] forKey:key];
        if ([key isEqualToString:@"00"]) {
            [tempResultDict setObject:[response createResponse:[dict objectForKey:key]] forKey:@"0"];

        }
        else{
            [tempResultDict setObject:[response createResponse:[dict objectForKey:key]] forKey:key];

        }
        
    }
    
    return [[NSDictionary alloc]initWithDictionary:tempResultDict];
    
}


+(NSArray*)numbersArrToStringArr:(NSArray*)arr{
    NSMutableArray* temparr=[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        [temparr addObject:[NSString stringWithFormat:@"%@",[arr objectAtIndex:i]]];
    }
    return (NSArray*)temparr;
}


+(NSArray*)createArrayOfObjectsWithsubDict: (BaseResponse*) response fromDictionary: (NSDictionary*)dictBeforeParsing{
    NSMutableArray * tempResultArray=[[NSMutableArray alloc]init];
    
    for(NSString* mainKey in [dictBeforeParsing allKeys])
    {
        NSMutableDictionary * mainDict = [[NSMutableDictionary alloc]init];
        [mainDict setObject:[dictBeforeParsing objectForKey:mainKey] forKey:mainKey];
        
        for(NSString * key in [mainDict allKeys])
        {
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            dict = [mainDict valueForKey:key];
            [tempResultArray addObject:[response createResponse:dict]];
            
            
        }
        
        
        
    }

    return [NSArray arrayWithArray:tempResultArray];
    
}

+(NSArray*)sortArrBySortOrder:(NSArray*)arr{
    NSArray* sorted = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber * first = ((BaseResponse*)obj1).numSortOrder;
        NSNumber * second = ((BaseResponse*)obj2).numSortOrder;
        
        if(!first)
            first=[NSNumber numberWithInt:99];
        if(!second)
            second=[NSNumber numberWithInt:99];
        
        return [first compare:second];
    }];
    
    return [NSArray arrayWithArray:sorted];
}

+(NSDictionary*)parseUrlToJson:(NSString*)url fromSubString:(NSString*)subString
{
    NSString* stringParseToJson;
    NSRange start = [url rangeOfString:subString];
    stringParseToJson = [url substringFromIndex:start.location + start.length];
    
    NSArray *myArray = [stringParseToJson componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&"]];
    NSString* stringOfJson;
    if([myArray count] > 0)
    {
        stringOfJson = [myArray objectAtIndex:0];
    }
    
    
    NSString *decoded = [stringOfJson stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [decoded dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return json;
    
}

+ (float)getFloatForKey:(NSString*)key fromJSONDict:(id)JSONDict withDefaultValue:(float)defaultValue {
    
    if (![JSONDict isKindOfClass:[NSDictionary class]])
        return defaultValue;
    
    id value = [JSONDict objectForKey:key];
    
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    
    return defaultValue;
}

@end
