//
//  ViewController.m
//  HHPlayer
//
//  Created by Now on 2019/5/17.
//  Copyright © 2019 任他疾风起. All rights reserved.
//

#import "ViewController.h"
#import "HHPlayer.h"
#import "HHAudioModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:[UIView new]];
    self.dataArray = [NSMutableArray array];
    HHAudioModel *model = [[HHAudioModel alloc] init];
    model.name = @"下一次爱情来的时候-蔡健雅";
    model.url = @"http://www.ytmp3.cn/down/53147.mp3";
    [self.dataArray addObject:model];
    
    HHAudioModel *model1 = [[HHAudioModel alloc] init];
    model1.name = @"牡丹亭外-任博然";
    model1.url = @"http://www.ytmp3.cn/down/31855.mp3";
    [self.dataArray addObject:model1];
    
    HHAudioModel *model2 = [[HHAudioModel alloc] init];
    model2.name = @"东南西北风-黄安";
    model2.url = @"http://www.ytmp3.cn/down/60413.mp3";
    [self.dataArray addObject:model2];
    
    HHAudioModel *model3 = [[HHAudioModel alloc] init];
    model3.name = @"不仅仅只是喜欢-萧全&孙语赛";
    model3.url = @"http://www.ytmp3.cn/down/47049.mp3";
    [self.dataArray addObject:model3];
    NSArray *array = @[@{@"name":@"水墨兰庭",@"url":@"http://www.ytmp3.cn/down/54723.mp3"},
                       @{@"name":@"下一次爱情来的时候-蔡健雅",@"url":@"http://www.ytmp3.cn/down/53147.mp3"},
                       @{@"name":@"牡丹亭外-任博然",@"url":@"http://www.ytmp3.cn/down/31855.mp3"},
                       @{@"name":@"东南西北风-黄安",@"url":@"http://www.ytmp3.cn/down/60413.mp3"},
                       @{@"name":@"不仅仅只是喜欢-萧全&孙语赛",@"url":@"http://www.ytmp3.cn/down/47049.mp3"},
                       @{@"name":@"菊花台",@"url":@"http://www.ytmp3.cn/down/31853.mp3"},
                       @{@"name":@"如果时光倒流-汪苏泷",@"url":@"http://www.ytmp3.cn/down/32503.mp3"},
                       @{@"name":@"妹妹背着洋娃娃",@"url":@"http://www.ytmp3.cn/down/68528.mp3"},
                       @{@"name":@"半山听雨",@"url":@"http://www.ytmp3.cn/down/50776.mp3"},];
    
    
}

#pragma mark UITableVieDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    HHAudioModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHAudioModel *model = self.dataArray[indexPath.row];
    [[HHPlayer sharePlayer] playURL:model.url];
}
#pragma mark creat UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100; //设置估计高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }return _tableView;
}


@end
