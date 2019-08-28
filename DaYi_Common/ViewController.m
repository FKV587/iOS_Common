//
//  ViewController.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/12.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "ViewController.h"
#import "DaYiSelectedProjectViewController.h"
#import "DYProjectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    QMUIButton * button = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = UIColorBlue;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    @weakify(self)
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.center.equalTo(self.view);
        make.height.width.mas_offset(100);
    }];
}

- (void)buttonAction{

    DYProjectView * view = [[DYProjectView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.0);
        make.left.right.mas_offset(0.0);
        make.bottom.mas_offset(0.0);
    }];
//    DaYiSelectedProjectViewController * vc = [[DaYiSelectedProjectViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
