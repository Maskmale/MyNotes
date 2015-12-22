//
//  DetailViewController.m
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIPopoverController *masterPopoverController;

-(void)configureView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item
-(void)setDetailItem:(id)detailItem
{
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
        //Update the view
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

-(void)configureView
{
    //Update the user interface for the detail item.
    if (self.detailItem) {
        Note *note = self.detailItem;
        self.txtView.text = note.content;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
    
    [self configureView];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
}

-(void)buildUI
{
    UITextView *txtView = [[UITextView alloc] initWithFrame:self.view.bounds];
    txtView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:txtView];
    self.txtView = txtView;
    
    //设置右上角按钮
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(clickSave)];
    self.navigationItem.rightBarButtonItem = save;

    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)clickSave
{
    NoteBL *bl = [[NoteBL alloc] init];
    Note *note = self.detailItem;
    note.content = self.txtView.text;
    NSMutableArray *reslist = [bl modify:note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:reslist userInfo:nil];
    [self.txtView resignFirstResponder];
}

-(void)insertNewObject:(id)sender
{
    AddViewController *addViewController = [[AddViewController alloc] init];
    addViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    addViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:addViewController animated:YES completion:nil];
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

#pragma mark - Split view
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = pc;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
