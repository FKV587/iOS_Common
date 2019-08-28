//
//  DYDefultTableViewCell.m
//  AFNetworking
//
//  Created by Fukai on 2019/8/12.
//

#import "DYDefultTableViewCell.h"

@interface DYDefultTableViewCell()

@property (nonatomic , strong)UIView * separatorView;

@end

@implementation DYDefultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self defultState_B];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.state) {
        case DYCellDefultState_A:
            self.rightImageView.image = DYDEFAULTCELLARROWIMAGE;
            [self defultState_A];
            break;
        case DYCellDefultState_B:
            self.rightImageView.image = DYDEFAULTCELLARROWIMAGE;
            [self defultState_B];
            break;
        case DYCellDefultState_C:
            self.rightImageView.image = DYDEFAULTCELLARROWIMAGE;
            [self defultState_C];
            break;
        case DYCellDefultState_D:
            self.rightImageView.image = DYDEFAULTAVATARIMAGE;
            [self defultState_D];
            break;
        case DYCellDefultState_E:
            self.rightImageView.image = DYDEFAULTAVATARIMAGE;
            [self defultState_E];
            break;

        default:
            break;
    }
}

- (void)defultState_A{
    self.titleLabel.hidden = NO;
    self.rightImageView.hidden = NO;
    self.messageLabel.hidden = YES;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    @weakify(self)
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.mas_offset(-15.0);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(5.0);
    }];
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)defultState_B{
    self.titleLabel.hidden = NO;
    self.rightImageView.hidden = NO;
    self.messageLabel.hidden = NO;
    @weakify(self)
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.mas_offset(-15.0);
    }];
    
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(5.0);
        make.right.equalTo(self.rightImageView.mas_left).mas_offset(-5.0);
    }];
}

- (void)defultState_C{
    self.titleLabel.hidden = NO;
    self.rightImageView.hidden = YES;
    self.messageLabel.hidden = NO;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    }];
    @weakify(self)
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(5.0);
        make.right.mas_offset(-15.0);
    }];
}

- (void)defultState_D{
    [self.rightImageView roundCorner:22.0];
    self.titleLabel.hidden = NO;
    self.rightImageView.hidden = NO;
    self.messageLabel.hidden = YES;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    @weakify(self)
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.mas_offset(-15.0);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(5.0);
        make.height.width.mas_offset(44.0);
    }];
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)defultState_E{
    self.titleLabel.hidden = NO;
    self.rightImageView.hidden = NO;
    self.messageLabel.hidden = YES;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15.0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    @weakify(self)
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.mas_offset(-15.0);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(5.0);
        make.height.width.mas_offset(22.0);
    }];
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

#pragma mark -- setter getter --

- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc]init];
        _titleLabel.text = @"名称";
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (QMUILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[QMUILabel alloc]init];
        _messageLabel.text = @"备注";
        _messageLabel.textAlignment = NSTextAlignmentRight;
        _messageLabel.font = UIFontMake(12.0);
        [self.contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_rightImageView];
    }
    return _rightImageView;
}

- (UIView *)separatorView{
    if (!_separatorView) {
        _separatorView = [[UIView alloc]init];
        _separatorView.backgroundColor = UIColorSeparator;
        [self.contentView addSubview:_separatorView];
    }
    return _separatorView;
}

@end
