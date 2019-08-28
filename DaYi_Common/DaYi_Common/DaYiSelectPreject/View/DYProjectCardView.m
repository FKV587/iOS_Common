//
//  DYProjectCardView.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/13.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYProjectCardView.h"

@interface DYProjectCardView()

@property (nonatomic , strong)QMUILabel * projectNameLabel;
@property (nonatomic , strong)QMUILabel * projectStateLabel;
@property (nonatomic , strong)QMUILabel * businessNameLabel;
@property (nonatomic , strong)QMUILabel * addressNameLabel;
@property (nonatomic , strong)QMUILabel * cycleNameLabel;//周期

@end

@implementation DYProjectCardView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorGreen;
        [self roundCorner:8.0];
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews{
    @weakify(self)
    [self.projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20.0);
        make.left.mas_offset(15.0);
    }];
    [self.projectStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.projectNameLabel.mas_right).mas_offset(5.0);
        make.right.mas_lessThanOrEqualTo(-15.0);
        make.centerY.equalTo(self.projectNameLabel.mas_centerY);
    }];
    [self.businessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.projectNameLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(self.projectNameLabel.mas_left);
        make.right.mas_lessThanOrEqualTo(-15.0);
    }];
    [self.addressNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.businessNameLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(self.projectNameLabel.mas_left);
        make.right.mas_lessThanOrEqualTo(-15.0);
    }];
    [self.cycleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addressNameLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(self.projectNameLabel.mas_left);
        make.right.mas_lessThanOrEqualTo(-15.0);
        make.bottom.mas_offset(-20.0);
    }];
}

#pragma mark -- setter getter --

- (void)setProjectModel:(id)projectModel{
    _projectModel = projectModel;
    
}

- (QMUILabel *)projectNameLabel{
    if (!_projectNameLabel) {
        _projectNameLabel = [[QMUILabel alloc] init];
        _projectNameLabel.text = @"项目名称";
        _projectNameLabel.font = UIFontBoldMake(20.0);
        [self addSubview:_projectNameLabel];
    }
    return _projectNameLabel;
}

- (QMUILabel *)projectStateLabel{
    if (!_projectStateLabel) {
        _projectStateLabel = [[QMUILabel alloc] init];
        _projectStateLabel.text = @"状态";
        _projectStateLabel.textColor = UIColorWhite;
        _projectStateLabel.font = UIFontMake(12.0);
        _projectStateLabel.contentEdgeInsets = UIEdgeInsetsMake(2, 10, 2, 12);
        _projectStateLabel.backgroundColor = UIColorRed;
        [_projectStateLabel roundCorner:2.0];
        [self addSubview:_projectStateLabel];
    }
    return _projectStateLabel;
}

- (QMUILabel *)businessNameLabel{
    if (!_businessNameLabel) {
        _businessNameLabel = [[QMUILabel alloc]init];
        _businessNameLabel.text = @"所属企业：公司名称";
        _businessNameLabel.font = UIFontMake(17.0);
        [self addSubview:_businessNameLabel];
    }
    return _businessNameLabel;
}

- (QMUILabel *)addressNameLabel{
    if (!_addressNameLabel) {
        _addressNameLabel = [[QMUILabel alloc]init];
        _addressNameLabel.text = @"项目地址：详细地址";
        _addressNameLabel.font = UIFontMake(17.0);
        [self addSubview:_addressNameLabel];
    }
    return _addressNameLabel;
}

- (QMUILabel *)cycleNameLabel{
    if (!_cycleNameLabel) {
        _cycleNameLabel = [[QMUILabel alloc]init];
        _cycleNameLabel.text = @"项目周期：2019-10-10  至  2010-10-10";
        _cycleNameLabel.font = UIFontMake(17.0);
        [self addSubview:_cycleNameLabel];
    }
    return _cycleNameLabel;
}

@end
