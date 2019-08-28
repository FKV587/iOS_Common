//
//  DYProjectCardTableViewCell.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/13.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYProjectCardTableViewCell.h"
#import "DYProjectCardView.h"

@interface DYProjectCardTableViewCell()

@property (nonatomic , strong)DYProjectCardView * cardView;

@end

@implementation DYProjectCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadViews{
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10.0);
        make.bottom.mas_offset(0.0);
        make.left.mas_offset(15.0);
        make.right.mas_offset(-15.0);
    }];
}

#pragma mark == setter getter --

- (DYProjectCardView *)cardView{
    if (!_cardView) {
        _cardView = [[DYProjectCardView alloc]init];
        [self addSubview:_cardView];
    }
    return _cardView;
}

@end
