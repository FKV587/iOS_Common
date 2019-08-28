//
//  DaYiSelectedProjectViewController.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/12.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DaYiSelectedProjectViewController.h"
#import "DYProjectCardTableViewCell.h"
#import "DaYiSelectedProjectCardView.h"

@interface DaYiSelectedProjectViewController()<QMUITableViewDelegate,QMUITableViewDataSource>

@property (nonatomic , strong)QMUITableView * tableView;
@property (nonatomic , strong)DaYiSelectedProjectCardView * selectedProjectView;

@end

@implementation DaYiSelectedProjectViewController

- (void)initSubviews{
    [super initSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(NavigationContentTopConstant);
        make.left.right.mas_offset(0.0);
        make.bottom.mas_offset(- SafeAreaInsetsConstantForDeviceWithNotch.bottom);
    }];
}

#pragma mark -- QMUITableViewDelegate,QMUITableViewDataSource --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYProjectCardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DYProjectCardTableViewCell" forIndexPath:indexPath];
    return cell;
}


#pragma mark -- setter getter --
- (QMUITableView *)tableView{
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.selectedProjectView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DYProjectCardTableViewCell class] forCellReuseIdentifier:@"DYProjectCardTableViewCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (DaYiSelectedProjectCardView *)selectedProjectView{
    if (!_selectedProjectView) {
        _selectedProjectView = [[DaYiSelectedProjectCardView alloc]init];
        _selectedProjectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    }
    return _selectedProjectView;
}

@end
