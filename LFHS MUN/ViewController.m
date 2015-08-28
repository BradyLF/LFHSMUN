//
//  ViewController.m
//  LFHS MUN
//
//  Created by Brady Africk on 6/15/15.
//  Copyright (c) 2015 Brady Africk. All rights reserved.
//

#import "Reachability.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize MainWebView;
@synthesize spinningWheel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NOT internet connection");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app. Essential features of LFHS MUN such as Breaking News will not function properly unless connected to the internet."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"There IS internet connection");
    }
    
    
    [self loadWebView];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    MainWebView.scrollView.bounces = NO;
    
    
    
}

- (void)loadWebView {
    // Remember that bundle resources do *not* have directories so all filenames must be unique.
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *homeIndexUrl = [mainBundle URLForResource:@"index" withExtension:@"html"];
    
    // The magic is loading a request, *not* using loadHTMLString:baseURL:
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:homeIndexUrl];
    [self.MainWebView loadRequest:urlReq];
    
    NSString * jsCallBack = @"window.getSelection().removeAllRanges();";
    [MainWebView stringByEvaluatingJavaScriptFromString:jsCallBack];
    
}
- (IBAction)loadPage:(id)sender;

{   NSBundle *Bundle = [NSBundle mainBundle];
    NSURL *homeIndexUrl = [Bundle URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:homeIndexUrl];
    [self.MainWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidUnload
{
    [self setMainWebView:nil];
    [self setSpinningWheel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)dismissModalView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)stopSpinning:(id)sender {
    [self.spinningWheel stopAnimating];
}

#pragma mark - Web View Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinningWheel startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinningWheel stopAnimating];
    spinningWheel.hidden = TRUE;
}
@end
