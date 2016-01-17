//
//  MasterViewController.m
//  MyNotes
//
//  Created by dengwei on 15/11/30.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "PopViewController.h"
#import "PopView.h"
#import "QiniuSDK.h"
#import "Tool.h"

@interface MasterViewController ()<UITableViewDataSource, UITableViewDelegate, PopViewDelegate>

@property (nonatomic, copy) PopView *popView;
@property (nonatomic, copy) PopViewController *popViewController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
    [self buildTableView];
}

#pragma mark 设置界面
-(void)buildUI
{
    self.title = @"备忘录";
    //设置右上角按钮
    UIBarButtonItem *more = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    self.navigationItem.rightBarButtonItem = more;
    //设置左上角按钮
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    self.navigationItem.leftBarButtonItem = edit;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.bl = [[NoteBL alloc] init];
    self.listData = [self.bl findAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncFileData:) name:@"syncFileDataNotification" object:nil];
}

#pragma mark - 处理通知
-(void)reloadView:(NSNotification *)notification
{
    if (_popView) {
        [self.popView removePopView];
        self.popView = nil;
    }
    [self.popViewController.view removeFromSuperview];
    self.popViewController = nil;
    
    NSMutableArray *reslist = [notification object];
    if (reslist) {
        self.listData = reslist;
    }    
    [self.tableView reloadData];
}

-(void)syncFileData:(NSNotification *)notification
{
    if (_popView) {
        [self.popView removePopView];
        self.popView = nil;
    }
    [self.popViewController.view removeFromSuperview];
    self.popViewController = nil;
    
    //从服务器SDK获取的token
    NSString *token = @"sfPKD6WfFblx2v9I1CgI1A9ALzdpXDpGZzz2MSeI:dnF3GnFJli5lDJgioUg4zAt9mIA=:eyJzY29wZSI6Im15bm90ZXMiLCJkZWFkbGluZSI6MzIzMTA4MTM1N30=";
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    NSString *content;
    NSString *key;
    for (Note *note in self.listData) {
        key = note.date;
        Note *n = [Tool readFileWithName:note.date];
        content = n.content;
        
        NSData *data = [content dataUsingEncoding : NSUTF8StringEncoding];
        [upManager putData:data key:key token:token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      NSLog(@"info:\n%@", info);
                      NSLog(@"resp:\n%@", resp);
                  } option:nil];
    }
    
}

#pragma mark 设置tableview属性
-(void)buildTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark 编辑备忘录操作
-(void)editAction
{
    if (self.tableView.editing == YES){
        [self.tableView setEditing:NO animated:YES];
    }else{
        [self.tableView setEditing:YES animated:YES];
    }
}

#pragma mark 更多操作
-(void)moreAction
{   
    //  显示菜单
    CGFloat x = (self.view.frame.size.width - 100);
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    self.popView.contentView = self.popViewController.view;
    [self.popView showInRect:CGRectMake(x, y, 100, 145)];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Configure the cell ...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    Note *note = self.listData[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.text = note.content;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = [note.date description];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Note *note = self.listData[indexPath.row];
        self.detailViewController.detailItem = note;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Note *note = self.listData[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.detailItem = note;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark 是否可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 编辑完成
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [self.listData objectAtIndex:[indexPath row]];
        NoteBL *bl = [[NoteBL alloc] init];
        self.listData = [bl remove:note];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (PopViewController *)popViewController
{
    if (_popViewController == nil) {
        PopViewController *pop = [[PopViewController alloc] init];
        _popViewController = pop;
        
    }
    return _popViewController;
}
- (PopView *)popView
{
    if (_popView == nil) {
        
        PopView *v = [PopView popView];
        v.delegate = self;
        _popView = v;
    }
    return _popView;
}

#pragma mark - PopViewDelegate method
- (void)popViewDidDismiss:(PopView *)popView
{
    NSLog(@"popViewDidDismiss");
}


@end
