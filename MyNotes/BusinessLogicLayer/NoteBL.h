//
//  NoteBL.h
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;

@interface NoteBL : NSObject

/**
 *  插入备忘录
 */
-(NSMutableArray *)createNote:(Note *)model;

/**
 *  删除备忘录
 */
-(NSMutableArray *)remove:(Note *)model;

/**
 *  修改备忘录
 */
-(NSMutableArray *)modify:(Note *)model;

/**
 *  查询所有数据
 */
-(NSMutableArray *)findAll;

@end
