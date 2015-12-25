//
//  NoteDAO.m
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "NoteDAO.h"
#import "Note.h"
#import "Tool.h"

@implementation NoteDAO

static NoteDAO *sharedManager = nil;

+(NoteDAO *)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [Tool createFileFolders];
        
        Note *note1 = [[Note alloc] init];
        note1.date = [Tool getLocalDateStr];
        note1.content = @"Welcome to MyNotes.";
        
        Note *note2 = [[Note alloc] init];
        note2.date = [Tool getLocalDateStr];
        note2.content = @"欢迎使用 MyNotes.";
        
        sharedManager = [[self alloc] init];
        sharedManager.listData = [[NSMutableArray alloc] init];
        [sharedManager.listData addObject:note1];
        [sharedManager.listData addObject:note2];
        [Tool writeFileWithNote:note1];
        [Tool writeFileWithNote:note2];
    });
    return sharedManager;
}

#pragma mark 插入备忘录
-(int)create:(Note *)model{
    [self.listData addObject:model];
    [Tool writeFileWithNote:model];
    return 0;
}

#pragma mark 删除备忘录
-(int)remove:(Note *)model{
    for (Note *note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToString:model.date]) {
            [self.listData removeObject:note];
            [Tool removeFileWithNote:note];
            break;
        }
    }
    return 0;
}

#pragma mark 修改备忘录
-(int)modify:(Note *)model{
    for (Note *note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToString:model.date]) {
            note.content = model.content;
            [Tool writeFileWithNote:note];
            break;
        }
    }
    [Tool ergodicMyFolders];
    return 0;
}

#pragma mark 查询所有数据
-(NSMutableArray *)findAll{
    return self.listData;
}

#pragma mark 按照主键查询数据
-(Note *)findById:(Note *)model{
    for (Note *note in self.listData) {
        //比较日期主键是否相等
        if ([note.date isEqualToString:model.date]) {
            return note;
        }
    }
    return nil;
}

@end
