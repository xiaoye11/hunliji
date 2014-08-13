//
//  AsynGETConnect.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-7.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "AsynGETConnect.h"

@implementation AsynGETConnect
- (void)dealloc
{
    [super dealloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)startConnect:(NSString *)urlStr dictionary:(NSDictionary*)dictionary block:(AsynGetConnectBlock)block
{
    self.asynBlock = block;
    
    NSString *str = [[NSString alloc] init];
    for (NSArray *key in [dictionary allKeys]) {
        str = [NSString stringWithFormat:@"%@=%@",key, [dictionary objectForKey:key]];
    }
    NSString *string = [NSString stringWithFormat:@"%@?%@",urlStr,str];
    
    NSURL *url = [NSURL URLWithString:string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.asynBlock(self.data);
}
@end
