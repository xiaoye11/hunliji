//
//  MarryDao.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-11.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Collect.h"
@interface MarryDao : NSObject

+ (void)insert:(Collect*)collect;
+ (void)delete:(NSString *)httpLocation;
+(BOOL)select:(NSString *)httpLocation;
@end
