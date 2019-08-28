//
//  DYProjectView.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/16.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYProjectView.h"

static NSString * const MoreProjectTitle = @"...";

@interface DYProjectView ()

@property (nonatomic , strong)UIView * grayView;
@property (nonatomic , strong)UIView * backView;
@property (nonatomic , strong)QMUILabel * titleLable;
@property (nonatomic , strong)QMUIButton * cancelButton;
@property (nonatomic , strong)UIScrollView * scrollView;
@property (nonatomic , strong)UIView * contentView;
@property (nonatomic , strong)QMUIFloatLayoutView * floatLayoutView;
@property (nonatomic , strong)NSArray<NSString *> *suggestions;

@end

@implementation DYProjectView

- (instancetype)init{
    self = [super init];
    if (self) {
        @weakify(self)
        [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(0.0);
        }];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.grayView.mas_bottom);
            make.left.right.mas_offset(0.0);
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(15.0);
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.right.mas_offset(-15.0);
            make.centerY.equalTo(self.titleLable.mas_centerY);
        }];
        
        self.suggestions = @[@"东野圭吾三体三体三体三体三体三体三体三体三体三体三体三体三体三体三体", @"三体", @"爱", @"红楼梦", @"理智与情感理智与情感理智与情感理智与情感理智与情感", @"读书热榜", @"免费榜"];
        if (self.suggestions.count > 6) {
            NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:[self.suggestions subarrayWithRange:NSMakeRange(0, 6)]];
            [mutableArray addObject:MoreProjectTitle];
            [self setButtonTitles:[mutableArray copy]];
        }else{
            [self setButtonTitles:[self.suggestions copy]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self)
            [self updateBackView];
        });
    }
    return self;
}

- (void)updateBackView{
    @weakify(self)
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.mas_offset(DEVICE_HEIGHT - self.backView.qmui_height);
        make.left.right.mas_offset(0.0);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)showNew{
    [self.titleLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15.0 + StatusBarHeightConstant);
    }];
    
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.0);
        make.bottom.mas_offset(0.0);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)setButtonTitles:(NSArray <NSString *>*)list{
    
    self.backView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner|QMUILayerMaxXMinYCorner;
    [self.backView roundCorner:20.0];
    
    [self floatLayoutViewAddButton:list];
    [self.backView addSubview:self.floatLayoutView];
    CGFloat height = [self.floatLayoutView sizeThatFits:CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT)].height;
    @weakify(self)
    [self.floatLayoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(5.0);
        make.height.mas_offset(height);
        make.left.right.mas_offset(0.0);
        make.bottom.mas_offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 60.0);
    }];
}

- (void)showTopALLView:(NSArray <NSString *>*)list{
    @weakify(self)
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.titleLable.mas_bottom).mas_offset(5.0);
        make.left.right.mas_offset(0.0);
        make.bottom.mas_offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.mas_offset(0.0);
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
    [self.backView roundCorner:0.0];
    [self floatLayoutViewAddButton:list];
    [self.contentView addSubview:self.floatLayoutView];
    CGFloat height = [self.floatLayoutView sizeThatFits:CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT)].height;
    [self.floatLayoutView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.0);
        make.left.right.mas_offset(0.0);
        make.bottom.mas_offset(-SafeAreaInsetsConstantForDeviceWithNotch.bottom - 60.0);
        make.height.mas_offset(height);
    }];
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0.0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        [self showNew];
    });
}

- (void)floatLayoutViewAddButton:(NSArray <NSString *>*)list{
    [self.floatLayoutView qmui_removeAllSubviews];
    for (NSInteger i = 0; i < list.count; i++) {
        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
        button.ghostColor = UIColor.blueColor;
        [button setTitle:list[i] forState:UIControlStateNormal];
        button.titleLabel.font = UIFontMake(14);
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
        [button addTarget:self action:@selector(ghostButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.floatLayoutView addSubview:button];
    }
}

#pragma mark -- Action --
- (void)cancelButtonAction:(QMUIButton *)sender{
    [self cancelView];
}

- (void)cancelView{
    [self removeFromSuperview];
}

- (void)ghostButtonAction:(QMUIGhostButton *)sender{
    if ([sender.titleLabel.text isEqualToString:MoreProjectTitle]) {
        [self showTopALLView:self.suggestions];
    }
}

#pragma mark -- setter getter --

- (UIView *)grayView{
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor colorWithHex:0x999999 alpha:0.3];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelView)];
        [_grayView addGestureRecognizer:tap];
        [self addSubview:_grayView];
    }
    return _grayView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = UIColorWhite;
        [self addSubview:_backView];
    }
    return _backView;
}

- (QMUILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[QMUILabel alloc]init];
        _titleLable.text = @"选择项目";
        _titleLable.font = UIFontBoldMake(20.0);
        [self.backView addSubview:_titleLable];
    }
    return _titleLable;
}

- (QMUIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.backView addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}

- (QMUIFloatLayoutView *)floatLayoutView{
    if (!_floatLayoutView) {
        _floatLayoutView = [[QMUIFloatLayoutView alloc]init];
        _floatLayoutView.padding = UIEdgeInsetsMake(15, 15, 15, 15);
        _floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        _floatLayoutView.minimumItemSize = CGSizeMake(69, 29);// 以2个字的按钮作为最小宽度
        _floatLayoutView.maximumItemSize = CGSizeMake(DEVICE_WIDTH - 30.0, 29);
        _floatLayoutView.frame = CGRectMake(0, 0, DEVICE_WIDTH, QMUIViewSelfSizingHeight);
    }
    return _floatLayoutView;
}

@end
