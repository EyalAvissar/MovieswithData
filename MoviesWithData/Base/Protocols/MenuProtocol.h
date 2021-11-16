//
//  MenuProtocol.h
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#ifndef MenuProtocol_h
#define MenuProtocol_h

@protocol MenuProtocol <NSObject>

-(void)didPressNumber:(long )pressed;

@optional
-(void)didPressMovie:(long)pressed :(NSString *)at;

@end

#endif /* MenuProtocol_h */
