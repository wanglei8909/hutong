//
//  SublistView.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/30.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "SublistView.h"
#import "SubListCell.h"

@implementation SublistView
{
    UITableView *mTableView;
    UITableView *rTableView;
    UIVisualEffectView *effectView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.bounds;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT - 250);
        [self addSubview:effectView];
        
        for (int i = 0; i< 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * 0.5 * kSCREEN_WIDTH, 0, 0.5 * kSCREEN_WIDTH, 55);
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitle:(i == 0?@"专辑列表":@"相关推荐") forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:kColorRed forState:UIControlStateSelected];
            btn.tag = 1000 + i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [effectView addSubview:btn];
            if(i==0) btn.selected = YES;
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH * 0.5, 10, 1, 35)];
        lineView.backgroundColor = [UIColor whiteColor];
        [effectView addSubview:lineView];
        
        /*
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 55)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17];
        label.text = @"专辑列表";
        [effectView addSubview:label];
        */
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, kSCREEN_WIDTH, 0.7)];
        line.backgroundColor = [UIColor whiteColor];
        [effectView addSubview:line];
        
        mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, kSCREEN_WIDTH, kSCREEN_HEIGHT - 250 - 40 - 55)];
        mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mTableView.backgroundColor = [UIColor clearColor];
        mTableView.delegate = self;
        mTableView.dataSource = self;
        [effectView addSubview:mTableView];
        
        rTableView = [[UITableView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH, 55, kSCREEN_WIDTH, kSCREEN_HEIGHT - 250 - 40 - 55)];
        rTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rTableView.backgroundColor = [UIColor clearColor];
        rTableView.delegate = self;
        rTableView.dataSource = self;
        [effectView addSubview:rTableView];
        
        [effectView addSubview: [self getFooterView]];
        
        line = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - 250 - 39.5, kSCREEN_WIDTH, 0.7)];
        line.backgroundColor = [UIColor whiteColor];
        [effectView addSubview:line];
        
    }
    return self;
}

- (void)btnClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    for (int i = 0; i< 2; i++) {
        UIButton *btn = (UIButton *)[effectView viewWithTag:1000 + i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    if (sender.tag == 1000) {
        [UIView animateWithDuration:0.3 animations:^{
            mTableView.left = 0;
            rTableView.left = kSCREEN_WIDTH;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            mTableView.left = -kSCREEN_WIDTH;
            rTableView.left = 0;
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == mTableView) {
        if (DATAManager.currentIndex == indexPath.row && AUDIOManager.playing) {
            return;
        }
        DATAManager.currentIndex = indexPath.row;
        [AUDIOManager newPlay];
        [tableView reloadData];
    }
    if (tableView == rTableView) {
        NSDictionary *dict = [DATAManager.playingModel.relationships objectAtIndex:indexPath.row];
        NSInteger index = [dict[@"id"] integerValue];
        if (index >= DATAManager.dataArray.count) {
            NSLog(@"数据不全");
            return;
        }
        ListModel *model = DATAManager.dataArray[index];
        DATAManager.playingModel = model;
        [AUDIOManager newPlay];
        [self close];
    }
    
    if (self.callBack) {
        self.callBack();
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == rTableView) {
        return DATAManager.playingModel.relationships.count;
    }
    return DATAManager.playingModel.Audios.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == rTableView) {
        static NSString *rCellID = @"rCellID";
        SubListCell *cell = [tableView dequeueReusableCellWithIdentifier:rCellID];
        if (!cell) {
            cell = [[SubListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rCellID];
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        NSDictionary *dict = [DATAManager.playingModel.relationships objectAtIndex:indexPath.row];
        cell.nameLabel.text = dict[@"name"];
        cell.nameLabel.textColor = [UIColor whiteColor];
        cell.mImageView.hidden = YES;
        
        return cell;
    }
    static NSString *cellID = @"cellID";
    SubListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SubListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.nameLabel.text = [DATAManager.playingModel.Audios objectAtIndex:indexPath.row];
    
    if (indexPath.row == DATAManager.currentIndex && AUDIOManager.playing) {
        cell.nameLabel.textColor = kColorRed;
        cell.mImageView.hidden = NO;
    }else{
        cell.nameLabel.textColor = [UIColor whiteColor];
        cell.mImageView.hidden = YES;
    }
    
    return cell;
}

- (void)didMoveToSuperview{
    [UIView animateWithDuration:0.5 animations:^{
        effectView.top = 250;
    }];
}

- (void)close{
    [UIView animateWithDuration:0.5 animations:^{
        effectView.top = kSCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIView *)getFooterView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kSCREEN_HEIGHT - 250 - 40, kSCREEN_WIDTH, 40);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
