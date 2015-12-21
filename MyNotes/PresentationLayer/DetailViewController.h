//
//  DetailViewController.h
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
#import "NoteDAO.h"
#import "NoteBL.h"
#import "Note.h"

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate>

@property (nonatomic, strong) id detailItem;

@property (nonatomic, strong) UILabel *detailDescriptionLabel;

@end
