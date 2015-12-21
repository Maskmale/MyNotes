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
        self.detailDescriptionLabel.text = note.content;
    }
}

#pragma mark 懒加载
-(UILabel *)detailDescriptionLabel
{
    if (_detailDescriptionLabel == nil) {
        _detailDescriptionLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_detailDescriptionLabel];
    }
    return _detailDescriptionLabel;
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
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)insertNewObject:(id)sender
{
    AddViewController *addViewController = [[AddViewController alloc] init];
    addViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    addViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:addViewController animated:YES completion:nil];
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
