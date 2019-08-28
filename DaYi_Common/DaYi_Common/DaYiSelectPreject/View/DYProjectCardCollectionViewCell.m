//
//  DYProjectCardCollectionViewCell.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/13.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYProjectCardCollectionViewCell.h"
#import "DYProjectCardView.h"

@interface DYProjectCardCollectionViewCell()

@property (nonatomic , strong)DYProjectCardView * cardView;

@end

@implementation DYProjectCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
        self.contentView.backgroundColor = QMUICMI.tableViewBackgroundColor;
    }
    return self;
}

- (void)loadViews{
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0.0);
        make.left.mas_offset(5.0);
        make.right.mas_offset(-5.0);
    }];
}

#pragma mark -- setter getter --
- (DYProjectCardView *)cardView{
    if (!_cardView) {
        _cardView = [[DYProjectCardView alloc]init];
        [self addSubview:_cardView];
    }
    return _cardView;
}

@end
