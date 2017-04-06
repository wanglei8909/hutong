//
//  BaseViewController.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/19.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[Commom imageWithColor:kColorRed] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[Commom imageWithColor:kSetColor(225, 225, 225)]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
}

- (void)GoBack {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.leftBarButtonItem = [self GetImageBarItem:image target:target action:action];
}

- (UIBarButtonItem *)GetImageBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    int iBtnWidth = 40;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, iBtnWidth, 40);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 10, 24, 24);
    [rightBtn addSubview:imageView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
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
