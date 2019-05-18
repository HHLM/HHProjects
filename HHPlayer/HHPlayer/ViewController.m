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
#import "UIView+ZZExt.h"
#import "HHPlayToolBar.h"
#import "YYModel/YYModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,HHPlayerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HHPlayToolBar *toolBar;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:[UIView new]];
    [self.view addSubview:self.toolBar];
    self.dataArray = [NSMutableArray array];
    [HHPlayer sharePlayer].delegate = self;;
    [self.dataArray setArray:[HHAudioModel audioArray]];
    [self.tableView reloadData];
    [self initToolBar];
}
- (void)initToolBar {
    [self.toolBar.lastBtn addTarget:self action:@selector(lastPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar.nextBtn addTarget:self action:@selector(nextPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar.playBtn addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lastPlay {
    [self playLast];
}
- (void)nextPlay {
    [self playNext];
}
- (void)playAudio:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [[HHPlayer sharePlayer] pausePlayer];
    }else {
        [[HHPlayer sharePlayer] stopPlayer];
    }
}
- (void)audioPlayerAllTime:(NSInteger)allTime currentTime:(NSInteger)cuttentTime {
    self.toolBar.currentLab.text = [NSString stringWithFormat:@"%02ld:%02ld",cuttentTime/60,cuttentTime%60];
    self.toolBar.allLab.text = [NSString stringWithFormat:@"%02ld:%02ld",allTime/60,allTime%60];
    self.toolBar.progressview.progress = (CGFloat)cuttentTime/allTime;
}
- (void)audioPlayerBeiginLoadVoice {
    
}
- (void)audioPlayerBeiginPlay {
    
}
- (void)audioPlayerFailPlay {
    [self playNext];
}
- (void)audioPlayerDidFinishPlay {
    [self playNext];
}
- (void)playLast {
    self.currentIndex --;
    if (self.currentIndex < 0) {
        self.currentIndex = self.dataArray.count-1;
    }
    [self playing];
}
- (void)playNext {
    self.currentIndex ++;
    if (self.currentIndex >= self.dataArray.count) {
        self.currentIndex = 0;
    }
    [self playing];
}
- (void)playing {
    [self resetToolBar];
    HHAudioModel *model = self.dataArray[self.currentIndex];
    self.title = model.name;
    [[HHPlayer sharePlayer] playURL:model.url];
}
- (void)resetToolBar {
    self.toolBar.currentLab.text = @"00:00";
    self.toolBar.allLab.text = @"00:00";
    self.toolBar.progressview.progress = 0;
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
    self.currentIndex = indexPath.row;
    [self playing];
}

#pragma mark creat UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.height = self.view.height - 80;
        _tableView.estimatedRowHeight = 100; //设置估计高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }return _tableView;
}

- (HHPlayToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [HHPlayToolBar loadInstanceFromNib];
        _toolBar.height = 80;
        _toolBar.y = self.view.height - 80-40;
        _toolBar.x = 0;
        _toolBar.width = self.view.width;
        _toolBar.progressview.progress = 0.0f;
    }return _toolBar;
}
@end
