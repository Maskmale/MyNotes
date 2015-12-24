//
//  FileTool.h
//  MyNotes
//
//  Created by dengwei on 15/12/24.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;
@interface FileTool : NSObject

/**
 *  遍历文件夹
 */
+(NSArray *)ergodicMyFolders;

/**
 *  创建文件夹
 */
+(void) createFileFolders;

/**
 *  将数据写入文件
 */
+(void) writeFileWithNote:(Note *)note;

/**
 *  移除指定文件
 */
+(void) removeFileWithNote:(Note *)note;

/**
 *  读取指定文件
 */
+(Note *)readFileWithName:(NSString *)fileName;

@end