//
//  BaseManager.h
//  Azrieli
//
//  Created by Idan Dreispiel on 12/16/15.
//  Copyright © 2015 shani daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerRequestDoneProtocol.h"
//#import "BaseViewController.h"
@interface BaseManager : NSObject <ServerRequestDoneProtocol>

- (void)reset;

//-(void)vcDidLoad:(BaseViewController*)vc;
//-(void)vcWillApear:(BaseViewController*)vc;
//-(void)vcDidApear:(BaseViewController*)vc;
//-(void)vcWillDissapear:(BaseViewController*)vc;
//-(void)vcDidDisspear:(BaseViewController*)vc;
@end
