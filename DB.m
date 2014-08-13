//
//  DB.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-11.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "DB.h"
#import <sqlite3.h>

static sqlite3 *dbPoint = nil;

@implementation DB

+(sqlite3 *)dbOpne
{
    if (dbPoint) {
        return dbPoint;
    }
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    
    path = [path stringByAppendingString:@"/mysql.db"];
    
    //判断文件是否存在,如果不存在, 则从bundle中拷贝到documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //进行拷贝准备
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Marray" ofType:@"rdb"];
        
        //拷贝到document
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:path error:nil];
    }
    //2,获得数据库指针    [path UTF8String] 转化为cont char
    sqlite3_open([path UTF8String], &dbPoint);
    
    return dbPoint;
}
@end
