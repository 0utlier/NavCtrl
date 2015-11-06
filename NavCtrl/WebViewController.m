//
//  WebViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/19/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
//@property (retain, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	//convert nsstring to nsurl
	NSURL *myurl = [[NSURL alloc] initWithString:self.url];
	// load the url
	NSURLRequest *req = [[NSURLRequest alloc] initWithURL:myurl];
	[self.myWebView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
	[_myWebView release];
	NSLog(@"webview dealloc");
	[super dealloc];
}
@end
