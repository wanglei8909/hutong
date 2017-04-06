//
//  MainViewController.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "MainViewController.h"
#import "MainListTableViewCell.h"
#import "PlayerViewController.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *mTableView;

@end

@implementation MainViewController

//首页列表展示： 图片 名字 标签  签到（用图表） 点赞（用图表）
//播放页：上边图片轮播 名字 标签 签到（用图表） 点赞（用图表）  作者   反馈   包含内容列表   相关内容列表

//对接： 数据格式；高德地图采集；账号申请；启动图；

//列表加排序 ； 大头针用路牌；

- (void)customNavItems{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[playGifView shareInstance]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mTableView reloadData];
    if (AUDIOManager.playing) {
        [[playGifView shareInstance] play];
    }else{
        [[playGifView shareInstance] pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"北京胡同";
    self.view.backgroundColor = kSetColor(240, 240, 240);
    [self AddLeftImageBtn:[UIImage imageNamed:@"map"] target:self action:@selector(goMap)];
    [self customNavItems];
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DATAManager.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"MainListTableViewCell";
    MainListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MainListTableViewCell alloc] init];
    }
    [cell loadContent:DATAManager.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController *ctrl  = [PlayerViewController shareInstance];
    ListModel *model = DATAManager.dataArray[indexPath.row];
    if (![model.id isEqualToString:DATAManager.playingModel.id] || !AUDIOManager.playing) {
        DATAManager.playingModel = model;
        [AUDIOManager newPlay];
        [tableView reloadData];
    }
    [self.navigationController presentViewController:ctrl animated:YES completion:nil];    
}

- (void)searchClick{
    
}

- (void)goMap{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
