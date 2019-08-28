//
//  DYTitleCollectionReusableView.m
//  NP_DaYi_JRXB
//
//  Created by Fukai on 2019/8/20.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYTitleCollectionReusableView.h"

@interface DYTitleCollectionReusableView()

@property (nonatomic , strong)QMUILabel * titleLabel;

@end

@implementation DYTitleCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15.0);
            make.top.bottom.mas_offset(0.0);
        }];
    }
    return self;
}

- (void)setTitleLabelText:(NSString *)text{
    [self setTitleLabelWithText:text font:nil color:nil];
}

- (void)setTitleLabelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color{
    self.titleLabel.text = text;
    if (font) {
        self.titleLabel.font = font;
    }
    if (color) {
        self.titleLabel.textColor = color;
    }
}

#pragma mark -- setter getter --
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc]init];
        _titleLabel.font = UIFontMake(15.0);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


@end
