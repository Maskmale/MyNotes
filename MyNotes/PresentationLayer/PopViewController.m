//
//  PopViewController.m
//  MyNotes
//
//  Created by dengwei on 16/1/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "PopViewController.h"
#import "AddViewController.h"

@interface PopViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _data = [NSArray arrayWithObjects:@"立即同步", @"新建", @"设置",  @"关于", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = _data[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    
    // 不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
    // 加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) { //"立即同步"
        [[NSNotificationCenter defaultCenter] postNotificationName:@"syncFileDataNotification" object:nil userInfo:nil];
    }else if (indexPath.row == 1) {  //"新建"
        AddViewController *addController = [[AddViewController alloc] init];
        UINavigationController *addNav = [[UINavigationController alloc] initWithRootViewController:addController];
        [self presentViewController:addNav animated:YES completion:^{
            self.tableView.hidden = YES;
        }];
    }
    
    
}


@end
