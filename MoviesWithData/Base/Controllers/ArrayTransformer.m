//
//  ArrayTransformer.m
//  MoviesWithData
//
//  Created by inmanage on 02/12/2021.
//

#import "ArrayTransformer.h"

@implementation ArrayTransformer

+ (NSArray<Class> *)allowedTopLevelClasses {
    return @[[ArrayTransformer class], [NSArray class]];
}

    /// Registers the transformer.
+(void)register{
    ArrayTransformer *transformer = [ArrayTransformer new];
    [NSValueTransformer setValueTransformer:transformer forName:[ArrayTransformer class]];
}

@end
