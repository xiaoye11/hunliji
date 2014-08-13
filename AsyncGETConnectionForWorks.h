//
//  AsyncGETConnectionForWorks.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-7.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsynGETConnectForWorksDelegate <NSObject>

-(void)sendDataFrowWoks:(NSData *)data;

@end

@interface AsyncGETConnectionForWorks : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSMutableData *data;

@property (nonatomic, assign) id<AsynGETConnectForWorksDelegate> delegate;

-(void)startConnectForWorks:(NSString *)urlStr dictionary:(NSDictionary*)dictionary;

@end
