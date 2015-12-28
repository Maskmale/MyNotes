//
//  AddViewController.m
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "AddViewController.h"
#import "Tool.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    
}

-(void)buildUI
{
    UITextView *txtView = [[UITextView alloc] initWithFrame:self.view.bounds];
    txtView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:txtView];
    self.txtView = txtView;
    
    //设置右上角按钮
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSave)];
    self.navigationItem.rightBarButtonItem = save;
    //设置左上角按钮
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCancel)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.title = @"新建";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickSave
{    
    NoteBL *bl = [[NoteBL alloc] init];
    Note *note = [[Note alloc] init];
    note.date = [Tool getLocalDateStr];
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
