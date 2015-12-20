//
//  MasterViewController.h
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"
#import "NoteBL.h"

@class DetailViewController;
@interface MasterViewController : UIViewController

@property (nonatomic, strong) DetailViewController *detailViewController;
/**
 *  保存数据列表
 */
@property (nonatomic, strong) NSMutableArray *listData;
/**
 *  保存数据列表
 */
@property (nonatomic, strong) NoteBL *bl;

@property (nonatomic, strong) UITableView *tableView;

@end
