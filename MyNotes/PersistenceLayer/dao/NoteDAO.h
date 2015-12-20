//
//  NoteDAO.h
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;

@interface NoteDAO : NSObject

/**
 *  保存数据列表
 */
@property (nonatomic, strong) NSMutableArray *listData;

+(NoteDAO *)sharedManager;

/**
 *  插入备忘录
 */
-(int)create:(Note *)model;

/**
 *  删除备忘录
 */
-(int)remove:(Note *)model;

/**
 *  修改备忘录
 */
-(int)modify:(Note *)model;

/**
 *  查询所有数据
 */
-(NSMutableArray *)findAll;

/**
 *  按照主键查询数据
 */
-(Note *)findById:(Note *)model;

@end
