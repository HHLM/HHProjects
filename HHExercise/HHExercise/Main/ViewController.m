//
//  ViewController.m
//  HHExercise
//
//  Created by Now on 2019/3/28.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "ViewController.h"
#import "HHBaseViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titlesArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = @[@"RunLoop",@"Runtime",@"KVO",@"KVC"];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark UITableVieDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }cell.textLabel.text = self.titlesArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = [NSString stringWithFormat:@"HH%@ViewController",self.titlesArray[indexPath.row]];
    
    HHBaseViewController  *vc = [[NSClassFromString(className) alloc] init];
    vc.navigationItem.title = self.titlesArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark creat UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100; //设置估计高度
        _tableView.rowHeight = UITableViewAutomaticDimension; _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }return _tableView;
}


@end
