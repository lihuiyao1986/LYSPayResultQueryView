//
//  ViewController.m
//  LYSPayResultQueryView
//
//  Created by jk on 2017/4/30.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSPayResultQueryView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 120, self.view.frame.size.width, 44);
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnclick{
    LYSPayResultQueryView * queryView = [[LYSPayResultQueryView alloc]init];
    queryView.dismissTouchOutside = NO;
    queryView.title = @"支付结果查询";
    [queryView show:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [queryView stopQuery:@"付款已成功，但燃气公司系统异常，我们会尽快给付款已成功，但燃气公司系统异常，我们会尽快给您处理，请稍后查看交易记付款" loadingBtnTitle:@"重新查询" withResult:NO LoadingBtnClickBlock:^(LYSPayResultQueryView *queryView) {
                [queryView startQuery];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [queryView stopQuery:@"付款已成功，您需要写卡完成整个购气操作。" loadingBtnTitle:@"立即写卡" withResult:YES LoadingBtnClickBlock:^(LYSPayResultQueryView *queryView) {
                        [queryView dismiss:nil];
                    }];
                });
            }];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
