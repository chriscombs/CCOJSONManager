//
//  CCOJSONManager.h
//  CCOJSONManagerExample
//
//  Created by Chris on 5/14/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCOJSONManager : NSObject
/** 
 Singleton instance. Initialization doesn't do much.
 */
+ (CCOJSONManager*)sharedInstance;

/**
 Sets the URL to download the JSON from. 
 
 Calling this method will also start a new HTTP request. You should really only set this once, 
 if you change the URL there is no indication if you're retrieving the old data or new data.
 
 @param url The url to access.
 */
- (void)setJSONURL:(NSURL*)url;

/**
 Gets the current data that the manager is... managing.
 
 You can call this method as early as you want. The manager uses an operation queue to block 
 the completion block from firing until the data is downloaded. If the data is already downloaded, 
 then the queue is open and it executes right away.
 
 @param completion The completion block to fire. It takes one argument, the data that is returned,
 by the manager.
 */
- (void)getLeaderboardDataWithCompletionHandler:(void (^)(NSArray *data))completion;


@end