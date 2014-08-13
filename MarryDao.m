//
//  MarryDao.m
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-11.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "MarryDao.h"
#import "DB.h"
#import <sqlite3.h>
#import "Collect.h"
@implementation MarryDao

static int num = 0;

+ (void)insert:(Collect*)collect
{

    sqlite3 *db = [DB dbOpne];
    //插入数据.  先写SQL语句, 存到字符串中.
    NSString *sqlStr = [NSString stringWithFormat:@"insert into collect (id, httpLocation) values(%d, '%@')", collect.collectId, collect.httploc];
    
   int result =  sqlite3_exec(db, [sqlStr UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    }
}
+(void)delete:(NSString *)httpLocation
{
    sqlite3 *db = [DB dbOpne];
    NSString *sqlStr = [NSString stringWithFormat:@"delete from collect where httpLocation = '%@'", httpLocation];
   int result =  sqlite3_exec(db, [sqlStr UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功!");
    }
}
+(BOOL)select:(NSString *)httpLocation
{
    sqlite3 *db = [DB dbOpne];
    sqlite3_stmt *stmt = nil;
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from collect where httpLocation = '%@'", httpLocation];
    // db , SQL语句, 返回长度(-1 无限长) &stmt替身,
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, NULL);

    if (result == SQLITE_OK) {
        //stmt指向下一个指针(链表的头指针), 并且判断下一行是否有数据
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //取查找到的一整行数据
            const unsigned char *httplocal = sqlite3_column_text(stmt, 1);
            
            NSString *http = [NSString stringWithUTF8String:(const char*)httplocal];

            sqlite3_finalize(stmt);
            if ([http isEqualToString:httpLocation]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        
    }
    //将替身清除
    sqlite3_finalize(stmt);
    return NO;
}
@end
