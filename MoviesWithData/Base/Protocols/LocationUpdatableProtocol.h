//
//  LocationUpdatableProtocol.h
//  Azrieli
//
//  Created by Idan Dreispiel on 12/23/15.
//  Copyright © 2015 shani daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
@protocol LocationUpdatableProtocol <NSObject>
@required
-(void)didGetNewLocation: (CLLocation*)location;
@end
