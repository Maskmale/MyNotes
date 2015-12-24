//
//  FileTool.m
//  MyNotes
//
//  Created by dengwei on 15/12/24.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "FileTool.h"
#import "Note.h"

@implementation FileTool

+(NSArray *)ergodicFolders
{
	// 创建文件管理器
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"];
	//获取当前目录下的所有文件
	NSArray *directoryContents = [[NSFileManager defaultManager] directoryContentsAtPath: path];
	NSLog(@"directoryContents:%@",directoryContents);
	return directoryContents;
}

+(void) createFileFolders
{
	// 创建文件管理器
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	//指向文件目录
	NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//创建一个目录
	[[NSFileManager defaultManager] createDirectoryAtPath: [NSString stringWithFormat:@"%@/myNotes", NSHomeDirectory()] attributes:nil];
}

+(void) writeFileWithNote:(Note *)note
{
	//对于错误信息
	NSError *error = nil;
	// 创建文件管理器
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"];
	//创建文件名
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fileName = [dateformatter stringFromDate:note.date];
	NSString *filePath= [path stringByAppendingPathComponent:fileName];
	//写入文件
	[note.content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
	if(error){
		NSLog(@"write file error:%@",error);
	}
}

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
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fileName = [dateformatter stringFromDate:note.date];
	NSString *filePath= [path stringByAppendingPathComponent:fileName];
	//移除文件
	[fileMgr removeItemAtPath:filePath error:&error];
	if(error){
		NSLog(@"remove file error:%@",error);
	}
}

+(Note *)readFileWithName:(NSString *)fileName
{  
	//对于错误信息
	NSError *error = nil;
	Note *note = [Note alloc] init];
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	//获取文件夹路径
	NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [document stringByAppendingPathComponent:@"myNotes"]; 
    NSString *filePath = [path stringByAppendingPathComponent:fileName]; 
	//读取文件
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error]; 
	if(error){
		NSLog(@"read file error:%@",error);
	}
	note.content = content; 
 
	return note;
}

@end