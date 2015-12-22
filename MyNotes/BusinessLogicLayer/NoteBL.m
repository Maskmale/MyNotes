//
//  NoteBL.m
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "NoteBL.h"
#import "Note.h"
#import "NoteDAO.h"

@implementation NoteBL

#pragma mark 插入备忘录
-(NSMutableArray *)createNote:(Note *)model{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao create:model];
    
    return [dao findAll];
}

#pragma mark 删除备忘录
-(NSMutableArray *)remove:(Note *)model{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao remove:model];
    
    return [dao findAll];
}

#pragma mark 修改备忘录
-(NSMutableArray *)modify:(Note *)model{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao modify:model];
    
    return [dao findAll];
}

#pragma mark 查询所有数据
-(NSMutableArray *)findAll{
    NoteDAO *dao = [NoteDAO sharedManager];
    return [dao findAll];
}

@end
