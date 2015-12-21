//
//  AddViewController.m
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)clickDone
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickSave:(UIButton *)sender
{
    NoteBL *bl = [[NoteBL alloc] init];
    Note *note = [[Note alloc] init];
    note.date = [[NSDate alloc] init];
    note.content = self.txtView.text;
    NSMutableArray *reslist = [bl createNote:note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:reslist userInfo:nil];
    [self.txtView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
