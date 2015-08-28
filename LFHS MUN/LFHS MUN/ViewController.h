//
//  ViewController.h
//  LFHS MUN
//
//  Created by Brady Africk on 6/15/15.
//  Copyright (c) 2015 Brady Africk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIWebView *MainWebView;
    BOOL theBool;
    BOOL hidden;
    //IBOutlet means you can place the progressView in Interface Builder and connect it to your code
    IBOutlet UIProgressView* myProgressView;
    NSTimer *myTimer;
    
    
}


- (IBAction)dismissModalView:(id)sender;
- (IBAction)stopSpinning:(id)sender;
- (IBAction)loadPage:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *MainWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinningWheel;

@end

