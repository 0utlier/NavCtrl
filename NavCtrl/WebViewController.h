//
//  WebViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/19/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController
@property (retain, nonatomic) IBOutlet WKWebView *myWebView;
@property (nonatomic, retain) NSString *url;
@end
