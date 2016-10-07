
//
//  DBHelperDAV.m
//  DAV
//
//  Created by Davis.Qiao on 16/5/10.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DBHelperDAV.h"

#import "shopModelDAV.h"

#define db_name @"db.sqlite"

@interface DBHelperDAV ()



@end


static FMDatabase *database=nil;

@implementation DBHelperDAV


+(BOOL)openDataBase{

    if(!database)
    {
        database= [self creatDB];
    }
    
    if (![database open]) {
        
        NSLog(@"打开数据库失败");
        return NO;
    }
    
    return YES;
}

+ (void) closeDatabase {
    
    if (database) {
        [database close];
        database = nil;
    }
}

#pragma mark -dbFilePath


+(FMDatabase *)creatDB
{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"DAV.sqlite"];
    
   
   FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
   
    
    NSLog(@"DB----%@",dbpath);
    
  
   
    BOOL flag = [db open];
    if (flag) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
    BOOL create =  [db executeUpdate:@"create table if not exists shop(id integer primary key  autoincrement, name text,price text)"];
    if (create) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }

    return db;
}


+(void)insertShopModel:(shopModelDAV *)model
{
 

    
    BOOL insert = [database executeUpdate:@"insert into shop(name,price) values(?,?)",[NSString stringWithFormat:@"%@",model.proName],[NSString stringWithFormat:@"%@",model.proPrice]];
    if (insert) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
    
}

+(void)deleteShopModel:(shopModelDAV *)model
{
   
    BOOL delete = [database executeUpdate:@"delete from shop where id =?",model.proId];
    if (delete) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
}

+(NSArray *)selectAllhopModel
{
   
    FMResultSet *set = [database executeQuery:@"select * from shop "];
    while ([set next]) {
        NSString *name =  [set stringForColumn:@"name"];
        NSString *phone = [set stringForColumn:@"price"];
        NSLog(@"name : %@ phone: %@",name,phone);
    }
    
    return nil;
}
@end
