//
//  UserAccountManagerProtocol.h
//  Azrieli
//
//  Created by Idan Dreispiel on 17/03/2016.
//  Copyright © 2016 shani daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserAccountManagerProtocol <NSObject>
-(void)userLoggedInWithCompletion: (void(^)())completion;
-(void)userFailedToLogIn;

@end
