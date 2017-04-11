//
//  PlayerViewController.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/13.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "AudioToolView.h"
#import "DispalyPicView.h"
#import "SublistView.h"
#import "SubListCell.h"
#import <MessageUI/MessageUI.h>

@interface PlayerViewController ()<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong)DispalyPicView *displayView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *durationLabel;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *subLabel;
@property (nonatomic, strong)UILabel *praiseLabel;
@property (nonatomic, strong)UILabel *lookLabel;
@property (nonatomic, strong)UIButton *playAndPause;

@end

@implementation PlayerViewController


+ (instancetype)shareInstance{
    static PlayerViewController *instance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[PlayerViewController alloc] init];
    });
    return instance;
}


- (DispalyPicView *)displayView{
    if (!_displayView) {
        _displayView = [[DispalyPicView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    }
    return _displayView;
}

- (UILabel *)subLabel{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, kSCREEN_HEIGHT * 0.5 - 50, kSCREEN_WIDTH - 200, 40)];
        _subLabel.backgroundColor = [UIColor clearColor];
        _subLabel.textColor = [UIColor whiteColor];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        _subLabel.font = [UIFont systemFontOfSize:16];
    }
    return _subLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, kSCREEN_WIDTH - 200, 44)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nameLabel;
}

- (UILabel *)praiseLabel{
    if (!_praiseLabel) {
        _praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 50, kSCREEN_HEIGHT * 0.5 +60, 40, 20)];
        _praiseLabel.textColor = [UIColor whiteColor];
        _praiseLabel.backgroundColor = [UIColor clearColor];
        //_praiseLabel.textAlignment = NSTextAlignmentRight;
        _praiseLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _praiseLabel;
}

- (UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel= [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 150, kSCREEN_HEIGHT * 0.5 +60, 40, 20)];
        _lookLabel.textColor = [UIColor whiteColor];
        _lookLabel.backgroundColor = [UIColor clearColor];
        //_lookLabel.textAlignment = NSTextAlignmentRight;
        _lookLabel.font = [UIFont systemFontOfSize:13];
    }
    return _lookLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshStaus];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = kColorRed;
    
    [self.view addSubview:self.displayView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 20, 40, 40);
    [backBtn addTarget:self action:@selector(GoBack) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    imageView.frame = CGRectMake(0, 9, 22, 22);
    [backBtn addSubview:imageView];
    [self.view addSubview:backBtn];
    
    UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listBtn.frame = CGRectMake(kSCREEN_WIDTH - 55, 20, 40, 40);
    [listBtn addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchUpInside];
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sublist"]];
    imageView.frame = CGRectMake(10, 8, 27, 27);
    [listBtn addSubview:imageView];
    [self.view addSubview:listBtn];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(60, kSCREEN_HEIGHT  - 150, kSCREEN_WIDTH - 120, 3.5);
    self.progressView.progressTintColor = kColorRed;
    [self.displayView  addSubview:self.progressView];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.progressView.top - 10, 60, 20)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.text = @"00:00";
    [self.displayView  addSubview:self.timeLabel];
    
    self.durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 70, self.timeLabel.top, 60, 20)];
    self.durationLabel.textColor = [UIColor whiteColor];
    self.durationLabel.font = [UIFont systemFontOfSize:12];
    self.durationLabel.textAlignment = NSTextAlignmentRight;
    self.durationLabel.text = @"00:00";
    [self.displayView  addSubview:self.durationLabel];
    
    self.playAndPause = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playAndPause.frame = CGRectMake(0, 0, 40, 40);
    self.playAndPause.center = CGPointMake(kSCREEN_WIDTH * 0.5, self.progressView.top + 60);
    [self.playAndPause setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.playAndPause setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.playAndPause addTarget:self action:@selector(playAndPauseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.displayView addSubview:self.playAndPause];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(0, 0, 30, 30);
    nextBtn.center = CGPointMake(self.playAndPause.center.x + 80, self.playAndPause.center.y);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"下一首"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.displayView addSubview:nextBtn];
    
    UIButton *previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    previousBtn.frame = CGRectMake(0, 0, 30, 30);
    previousBtn.center = CGPointMake(self.playAndPause.center.x - (nextBtn.center.x - self.playAndPause.center.x), self.playAndPause.center.y);
    [previousBtn setBackgroundImage:[UIImage imageNamed:@"上一首"] forState:UIControlStateNormal];
    [previousBtn addTarget:self action:@selector(previousClick) forControlEvents:UIControlEventTouchUpInside];
    [self.displayView addSubview:previousBtn];
    
    UIButton *praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseBtn.frame = CGRectMake(self.praiseLabel.left - 25, self.praiseLabel.top  - 3, 20, 20);
    [praiseBtn setBackgroundImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
    [self.displayView addSubview:praiseBtn];
    
    UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBtn.frame = CGRectMake(self.lookLabel.left - 25, self.lookLabel.top - 3, 20, 20);
    [lookBtn setBackgroundImage:[UIImage imageNamed:@"脚印"] forState:UIControlStateNormal];
    [self.displayView addSubview:lookBtn];
    
    [self.displayView addSubview:self.nameLabel];
//    [self.displayView addSubview:self.subLabel];
    [self.displayView addSubview:self.praiseLabel];
    [self.displayView addSubview:self.lookLabel];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, _playAndPause.bottom + 50, 40, 14)];
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"作者:";
//    label.backgroundColor = [UIColor clearColor];
//    [self.displayView addSubview:label];
    
//    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, label.bottom + 10, 50, 50)];
//    imageView.image = [UIImage imageNamed:@"anchor"];
//    imageView.layer.masksToBounds = YES;
//    imageView.layer.cornerRadius = 22.5;
//    [self.displayView addSubview:imageView];
//    
//    label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 8, _playAndPause.bottom + 10, 40, 14)];
//    label.bottom = imageView.bottom - 2;
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"承东";
//    label.backgroundColor = [UIColor clearColor];
//    [self.displayView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kSCREEN_WIDTH - 55, kSCREEN_HEIGHT - 50 , 40, 22);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"反馈" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 11;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    [btn addTarget:self action:@selector(feedbackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.displayView addSubview:btn];
    /*
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kSCREEN_WIDTH - 75, self.praiseLabel.top  , 60, 22);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"相关推荐" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 11;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    [btn addTarget:self action:@selector(recommendClick) forControlEvents:UIControlEventTouchUpInside];
    [self.displayView addSubview:btn];
    */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimeDisplay:) name:UPDATETIMENotification object:nil];
}

- (void)playAndPauseClick:(UIButton *)sender{
    if (sender.selected) {
        [AUDIOManager pause];
    }else{
        [AUDIOManager play];
    }
    sender.selected = !sender.selected;
}

- (void)updateTimeDisplay:(NSNotification *)notifi{
    NSDictionary *userinfo = notifi.userInfo;
    //NSLog(@"%@", userinfo);
    self.progressView.progress = [userinfo[@"progress"] floatValue];
    self.timeLabel.text = userinfo[@"currentTime"];
    self.durationLabel.text = userinfo[@"duration"];
}

- (void)showList{
    SublistView *view = [[SublistView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    view.callBack = ^{
        [self refreshStaus];
    };
    [self.view addSubview:view];
}

- (void)nextClick{
    [AUDIOManager playNext];
    [self refreshStaus];
}
- (void)previousClick{
    [AUDIOManager playPrevious];
    [self refreshStaus];
}

- (void)refreshStaus{
    [self.displayView setContent:DATAManager.playingModel.images];
    self.nameLabel.text = DATAManager.playingModel.name;
    self.praiseLabel.text = DATAManager.playingModel.praise;
    self.lookLabel.text = DATAManager.playingModel.signin;
    self.playAndPause.selected = AUDIOManager.playing;
    NSString *name = [DATAManager.playingModel.Audios objectAtIndex:DATAManager.currentIndex];
    self.subLabel.text = name;
}

- (void)feedbackClick{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"发短信",@"发邮件", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//发短信
        if( [MFMessageComposeViewController canSendText] )
        {
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
            controller.recipients = @[@"+8615810108820"];
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                            message:@"该设备不支持短信功能"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if (buttonIndex == 1){//发邮件
        
        if( [MFMailComposeViewController canSendMail] )
        {
            MFMailComposeViewController * controller = [[MFMailComposeViewController alloc] init];
            [controller setToRecipients:@[@"wanglei890925@613.com"]];
            controller.mailComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                            message:@"该设备不支持邮件功能"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)recommendClick{
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        caseMFMailComposeResultCancelled:
            
            break;
        caseMFMailComposeResultSaved:
            
            break;
        caseMFMailComposeResultSent:
            
            break;
        caseMFMailComposeResultFailed:
            
            break;
        default:
            break;
            
    }
}

- (void)dealloc{
    
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
