//
//  NoInternetResponse.m
//  Meshulam
//
//  Created by shani daniel on 20 Kislev 5776.
//  Copyright © 5776 inmanage. All rights reserved.
//

#import "NoInternetResponse.h"

@implementation NoInternetResponse
{
    
    NSInteger status;
    NSDictionary* error;
    NSString* messageTitle;
    NSString* messageSubtitle;
    
    
}

-(id)init{
    self=[super init];
    if (self) {
        status = 0;
        error = [NSDictionary dictionaryWithObject:@"-1" forKey:@"id"];
//        NSString *errorMsg = [[StringsCreator sharedCreator] stringFromKey:tServerConnectionErrorPopupTitle];
//        NSString *errorMsgSubtitle = [[StringsCreator sharedCreator] stringFromKey:tServerConnectionErrorPopupSubtitle];
//        messageTitle = errorMsg.length ? errorMsg : alertNoAccessToServerDefault;
//        messageSubtitle = errorMsgSubtitle.length ? errorMsg : alertNoAccessToServerSubtitleDefault;
        self.errorID = -1;
        self.strMessage = messageTitle;
        self.strSubtitle = messageSubtitle;
    }
    return self;
}

@end
