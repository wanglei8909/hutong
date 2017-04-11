//
//  DetailViewController.m
//  Hutong
//
//  Created by 王蕾 on 2017/4/10.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) UILabel *praiseLabel;
@property (nonatomic, strong) UILabel *lookLabel;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (UILabel *)praiseLabel{
    if (!_praiseLabel) {
        _praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 50, 180, 40, 20)];
        _praiseLabel.textColor = [UIColor whiteColor];
        _praiseLabel.backgroundColor = [UIColor clearColor];
        //_praiseLabel.textAlignment = NSTextAlignmentRight;
        _praiseLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _praiseLabel;
}

- (UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel= [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 150, 180, 40, 20)];
        _lookLabel.textColor = [UIColor whiteColor];
        _lookLabel.backgroundColor = [UIColor clearColor];
        //_lookLabel.textAlignment = NSTextAlignmentRight;
        _lookLabel.font = [UIFont systemFontOfSize:13];
    }
    return _lookLabel;
}

- (UIView *)getHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 215)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 140, 140)];
    imageView.image = [UIImage imageNamed:self.mModel.images[0]];
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 16, imageView.top + 16, kSCREEN_WIDTH - imageView.right - 30, 18)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.text = self.mModel.name;
    [view addSubview:nameLabel];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.right + 16, imageView.top + 56, 40, 40)];
    icon.image = [UIImage imageNamed:@"anchor"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 20;
    [view addSubview:icon];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + 10, icon.top + 16, kSCREEN_WIDTH - imageView.right - 30, 18)];
    aLabel.backgroundColor = [UIColor clearColor];
    aLabel.textColor = [UIColor whiteColor];
    aLabel.font = [UIFont systemFontOfSize:14];
    aLabel.text = @"东哥";
    [view addSubview:aLabel];
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseBtn.frame = CGRectMake(self.praiseLabel.left - 25, self.praiseLabel.top  - 3, 20, 20);
    [praiseBtn setBackgroundImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
    [view addSubview:praiseBtn];
    
    UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBtn.frame = CGRectMake(self.lookLabel.left - 25, self.lookLabel.top - 3, 20, 20);
    [lookBtn setBackgroundImage:[UIImage imageNamed:@"脚印"] forState:UIControlStateNormal];
    [view addSubview:lookBtn];
    
    [view addSubview:self.praiseLabel];
    [view addSubview:self.lookLabel];
    self.praiseLabel.text = self.mModel.praise;
    self.lookLabel.text = self.mModel.signin;
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kSetColor(240, 240, 240);
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 400)];
    backgroundImage.contentMode = UIViewContentModeScaleToFill;
    backgroundImage.image = [UIImage imageNamed:self.mModel.images[0]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = backgroundImage.bounds;
    [backgroundImage addSubview:effectView];
    [self.view addSubview:backgroundImage];
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.mTableView.backgroundColor = [UIColor clearColor];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.tableHeaderView = [self getHeaderView];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mTableView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 20, 40, 40);
    [backBtn addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    imageView.frame = CGRectMake(0, 9, 22, 22);
    [backBtn addSubview:imageView];
    [self.view addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, kSCREEN_WIDTH - 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"清单";
    [self.view addSubview:titleLabel];
    
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40, 39.3, kSCREEN_WIDTH, 0.7)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kSCREEN_WIDTH - 200, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = kSetColor(31, 31, 31);
    titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:titleLabel];
    if (section == 0) {
        titleLabel.text = @"播放全部";
    }else{
        titleLabel.text = @"相关推荐";
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.mModel.Audios.count;
    }else{
        return self.mModel.relationships.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"DcellID";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *name = @"";
    if (indexPath.section == 0) {
        name = self.mModel.Audios[indexPath.row];
    }else{
        name = self.mModel.relationships[indexPath.row][@"name"];
    }
    [cell loadContent:name :[NSString stringWithFormat:@"%ld.",indexPath.row + 1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListModel *model = DATAManager.dataArray[indexPath.row];
    DetailViewController *ctrl = [[DetailViewController alloc] init];
    ctrl.mModel = model;
    [self.navigationController pushViewController:ctrl animated:YES];
    //    PlayerViewController *ctrl  = [PlayerViewController shareInstance];
    //    if (![model.id isEqualToString:DATAManager.playingModel.id] || !AUDIOManager.playing) {
    //        DATAManager.playingModel = model;
    //        [AUDIOManager newPlay];
    //        [tableView reloadData];
    //    }
    //    [self.navigationController presentViewController:ctrl animated:YES completion:nil];
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
