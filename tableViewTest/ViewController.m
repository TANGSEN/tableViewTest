//
//  ViewController.m
//  tableViewTest
//
//  Created by 唐建平 on 16/1/5.
//  Copyright © 2016年 tangjp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,weak) UITableView *table;
@property (nonatomic ,weak) UIView *backGroundView;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated{
    
#warning 一定要先添加backGroundView,才能达到在文字后面移动的效果
    
    // 1. 创建一个要移动的背景view 并且把frame设置成跟table的cell一样大
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    
    // 设置背景色 不然移动的时候看不出效果
    backGroundView.backgroundColor = [UIColor redColor];
    
    // 添加到视图上
    [self.view addSubview:backGroundView];
    
    // 保存引用,留到下面做操作
    self.backGroundView = backGroundView;
    
    // 2. 创建一个tableView
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.frame];
    
    // 把table的背景色设置为透明色
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.table = table;
}

/**
 *  选中某一行所执行的方法
 *
 *  @param tableView tableView
 *  @param indexPath 当前选中的位置
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.frame = CGRectMake(0, self.backGroundView.bounds.size.height * indexPath.row, self.view.bounds.size.width, 44);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
    }
    // 这里必须要设置cell的背景颜色为纯洁的
    cell.backgroundColor = [UIColor clearColor];
    // 选中样式要取消掉 必须这样做
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"test---%ld",indexPath.row];
    
    return cell;
}
@end
