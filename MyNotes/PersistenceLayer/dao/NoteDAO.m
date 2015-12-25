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
        NSArray *allFiles = [Tool ergodicMyFolders];
        for(NSString *fileName in allFiles){
            Note *note = [Tool readFileWithName:fileName];
            note.content = [note.content substringToIndex:10];
            [sharedManager.listData addObject:note];
        }
        Note *note1 = [[Note alloc] init];
        note1.date = [Tool getLocalDateStr];
        note1.content = @"Welcome to MyNotes.";
        
        Note *note2 = [[Note alloc] init];
        note2.date = [Tool getLocalDateStr];
        note2.content = @"欢迎使用 MyNotes.";
        
        sharedManager = [[self alloc] init];
        sharedManager.listData = [[NSMutableArray alloc] init];
        [Tool writeFileWithNote:note1];
        [Tool writeFileWithNote:note2];
        note1.content = [note1.content substringToIndex:10];
        note2.content = [note2.content substringToIndex:10];
        [sharedManager.listData addObject:note1];
        [sharedManager.listData addObject:note2];
    });
    return sharedManager;
}

#pragma mark 插入备忘录
-(int)create:(Note *)model{    
    [Tool writeFileWithNote:model];
    model.content = [model.content substringToIndex:10];
    [self.listData addObject:model];
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
