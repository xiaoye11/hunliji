//
//  DB.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-11.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DB : NSObject
+(sqlite3 *)dbOpne;
@end
