//
//  AsynGETConnect.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-7.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AsynGetConnectBlock)(NSData *data);

@interface AsynGETConnect : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSMutableData *data;

//@property (nonatomic, assign) id<AsynGETConnectDelegate> delegate;

@property (nonatomic, copy) AsynGetConnectBlock asynBlock;

-(void)startConnect:(NSString *)urlStr dictionary:(NSDictionary*)dictionary block:(AsynGetConnectBlock) block;

@end
