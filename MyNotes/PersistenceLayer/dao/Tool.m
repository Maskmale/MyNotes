//
//  Tool.m
//  MyNotes
//
//  Created by dengwei on 15/12/24.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "Tool.h"
#import "Note.h"

@implementation Tool

#pragma mark 遍历文件夹
+(NSArray *)ergodicMyFolders
{
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"];
	//获取当前目录下的所有文件
	NSArray *directoryContents = [[NSFileManager defaultManager] directoryContentsAtPath:path];
	NSLog(@"directoryContents:%@",directoryContents);
	return directoryContents;
}

#pragma mark 创建文件夹
+(void) createFileFolders
{
	//指向文件目录
	NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//创建一个目录
	[[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/myNotes", documentsDirectory] attributes:nil];
}

#pragma mark 将数据写入文件
+(void) writeFileWithNote:(Note *)note
{
	//对于错误信息
	NSError *error = nil;
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"];
	//创建文件名
	NSString *filePath= [path stringByAppendingPathComponent:note.date];
	//写入文件
	[note.content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	if(error){
		NSLog(@"write file error:%@",error);
	}
}

#pragma mark 移除指定文件
+(void) removeFileWithNote:(Note *)note
{
	//对于错误信息
	NSError *error = nil;
	// 创建文件管理器
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"];
	//创建文件名
	NSString *filePath= [path stringByAppendingPathComponent:note.date];
	//移除文件
	[fileMgr removeItemAtPath:filePath error:&error];
	if(error){
		NSLog(@"remove file error:%@",error);
	}
}

#pragma mark 读取指定文件
+(Note *)readFileWithName:(NSString *)fileName
{
	//对于错误信息
	NSError *error = nil;
	Note *note = [[Note alloc] init];
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
	//读取文件
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
	if(error){
		NSLog(@"read file error:%@",error);
	}
	note.date = fileName;
	note.content = content;
    
	return note;
}

#pragma mark 获取当前本地时间
+(NSString *)getLocalDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[[NSDate alloc] init]];
}

@end