//
//  utilities.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/26/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"

@interface utilities : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>
{
	NSMutableData *_responseData;
}
@property (nonatomic, retain) DAO *dao;
- (void)importStockPrice:(UITableView*)tableView;

@end
