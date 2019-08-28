//
//  DYTextfiledTableViewCell.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/26.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYTextFiledTableViewCell.h"

@interface DYTextFiledTableViewCell ()

@property (nonatomic , strong)UIView * separatorView;

@end

@implementation DYTextFiledTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self)
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorWhite;
        [self roundCorner:0.5];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15.0);
            make.top.bottom.mas_offset(0.0);
            make.width.mas_offset(40.0);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.titleLabel.mas_right).mas_offset(15.0);
            make.top.bottom.mas_offset(0.0);
        }];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.textField.mas_right);
            make.centerY.equalTo(self.textField.mas_centerY);
            make.right.mas_offset(-15.0);
            make.height.width.mas_offset(22.0);
        }];
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15.0);
            make.bottom.mas_offset(0.0);
            make.right.mas_offset(0.0);
            make.height.mas_offset(0.5);
        }];
    }
    return self;
}

#pragma mark -- setter getter --
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc]init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (QMUITextField *)textField{
    if (!_textField) {
        _textField = [[QMUITextField alloc]init];
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = DYDEFAULTCELLARROWIMAGE;
        _arrowImageView.hidden = YES;
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

- (UIView *)separatorView{
    if (!_separatorView) {
        _separatorView = [[UIView alloc]init];
        _separatorView.backgroundColor = QMUICMI.tableViewSeparatorColor;
        [self addSubview:_separatorView];
    }
    return _separatorView;
}

@end
