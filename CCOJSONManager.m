//
//  CCOJSONManager.m
//  CCOJSONManagerExample
//
//  Created by Chris on 5/14/14.
//  Copyright (c) 2014 ChrisCombs. All rights reserved.
//

#import "CCOJSONManager.h"

@interface CCOJSONManager ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) id storedData;
@property (nonatomic, strong) NSURL *jsonURL;
@end

@implementation CCOJSONManager

+ (CCOJSONManager*)sharedInstance {
    static CCOJSONManager *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [CCOJSONManager new];
    });
    return singleton;
}

// Using an operation queue to automatically return the leaderboard data if it exists
- (void)getLeaderboardDataWithCompletionHandler:(void (^)(NSArray *data))completion {
    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        completion(self.storedData);
    }];
    [self.queue addOperation:block];
}

- (void)setJSONURL:(NSURL *)url {
    self.jsonURL = url;
    [self sendRequest];
}

#pragma mark - Private (ish)

-(id)init {
    self = [super init];
    if (self) {
        _queue = [NSOperationQueue new];
        [_queue setSuspended:YES];
    }
    return self;
}

- (void)sendRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.jsonURL];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            self.storedData = JSON;
            [self.queue setSuspended:NO];
            
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"%@", error);
        }];
    [operation start];
}

@end
