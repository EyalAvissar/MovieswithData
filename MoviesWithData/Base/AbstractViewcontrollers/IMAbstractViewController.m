//
//  AbstractViewController.m
//  Aroma - iOS
//
//  Created by Simon Janevski on 3/22/16.
//  Copyright © 2016 Idan. All rights reserved.
//

#import "IMAbstractViewController.h"
#import "Applicationmanager.h"


// For keyboard animation
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.9;//0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;



@implementation IMAbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.skipUpdatingAccessibility = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.navigationItem.leftBarButtonItem = nil;

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self fillTextWithTrans];
    
    [[ApplicationManager sharedInstance].requestManager addServerRequestDoneDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    

    [self checkAndShowStackedAlert];
    
//    [self reportScreenName];
 
    self.view.accessibilityElementsHidden = NO;

//    if (!self.skipUpdatingAccessibility) {
//        [self updateAccessibility];
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.accessibilityElementsHidden = YES;
}

- (void) checkAndShowStackedAlert {
//    [[ApplicationManager sharedInstance].alertsManager checkAndShowStackedAlert];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[ApplicationManager sharedInstance].requestManager removeServerRequestDoneDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fillTextWithTrans {
}

//-(void)reportScreenName{
//
//    NSString* strScreenName = [self getScreenName];
//
//    if (strScreenName.length == 0 && DebugMode) {
//        [[ApplicationManager sharedInstance].alertsManager showGeneralAlertWithTitle:[NSString stringWithFormat:@"יש לממש ב%@ מתודת: getScreenName על מנת לדווח לגוגל אנליטיקס",[self class]]];
//    }
//    else{
//        // May return nil if a tracker has not already been initialized with a
//        // property ID.
//        id tracker = [[GAI sharedInstance] defaultTracker];
//
//        // This screen name value will remain set on the tracker and sent with
//        // hits until it is set to a new value or to nil.
//        [tracker set:kGAIScreenName
//               value:strScreenName];
//
//        // New SDK versions
//        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
//
//    }
//
//}

-(NSString*)getScreenName{
    
    return @"";
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
        
    //animation for keyboard
    CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
//        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
//        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    CGRect viewFrame = self.view.frame;
    

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    //animation for keyboard
    CGRect textFieldRect =[self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
//        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
//        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    //keyboard animation
    CGRect viewFrame = self.view.frame;
    
//    int y = kStatusBarHeight + self.navigationController.navigationBar.height;
//    if (viewFrame.origin.y != y) {
////        viewFrame.origin.y += animatedDistance;
//    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Header



#pragma mark - ServerRequestDoneProtocol

- (void)serverRequestSucceed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest {
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
}


#pragma mark - LocationUpdatable

- (void)didGetNewLocation:(CLLocation*)location{
    
//    [ApplicationManager sharedInstance].locationManager.currentLocation = location;
}

- (void)focusOnHeaderAccessibility {
}

- (void)updateAccessibility {

}

@end
