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
        
        sharedManager = [[self alloc] init];
        sharedManager.listData = [[NSMutableArray alloc] init];
        [Tool createFileFolders];
        NSArray *allFiles = [Tool ergodicMyFolders];
        NSString *header;
        NSInteger len = 0;
        for(NSString *fileName in allFiles){
            header = [fileName substringToIndex:1];
            if (![header isEqualToString:@"."]) {
                Note *note = [Tool readFileWithName:fileName];
                len = note.content.length > 30 ? 30 : note.content.length;
                note.content = [note.content substringToIndex:len];
                [sharedManager.listData addObject:note];
            }
        }
    });
    return sharedManager;
}

#pragma mark 插入备忘录
-(int)create:(Note *)model{    
    [Tool writeFileWithNote:model];
    NSInteger len = model.content.length > 30 ? 30 : model.content.length;
    model.content = [model.content substringToIndex:len];
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
