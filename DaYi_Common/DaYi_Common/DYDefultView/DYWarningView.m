//
//  DYWarningView.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/20.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYWarningView.h"

@interface DYWarningView ()

@property (nonatomic , strong)UIImageView * iconImageView;
@property (nonatomic , strong)QMUILabel * titleLabel;

@end

@implementation DYWarningView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorOrangeLighten;
        @weakify(self)
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.mas_offset(15.0);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
            make.height.width.mas_offset(22.0);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.iconImageView.mas_right).mas_offset(5.0);
            make.top.mas_offset(3.0);
            make.bottom.mas_offset(-3.0);
            make.right.mas_offset(-15.0);
        }];
    }
    return self;
}

- (void)setTitleLabelText:(NSString *)text iconImageName:(NSString *)iconImageName{
    self.titleLabel.text = text;
    [self.iconImageView setImage:[UIImage imageWithName:iconImageName]];
}

#pragma mark -- setter getter --

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc]init];
        _titleLabel.font = UIFontMake(14.0);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = UIColorOrange;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
