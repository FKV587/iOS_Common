//
//  DYDefultTableViewCell.h
//  AFNetworking
//
//  Created by Fukai on 2019/8/12.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DYCellDefultState_A,//左边title 右边箭头
    DYCellDefultState_B,//左边title 右边message+箭头
    DYCellDefultState_C,//左边title 右边message
    DYCellDefultState_D,//右边头像大图
    DYCellDefultState_E,//右边二维码小图
} DYCellDefultState;

@interface DYDefultTableViewCell : QMUITableViewCell

@property (nonatomic , strong)QMUILabel * titleLabel;
@property (nonatomic , strong)QMUILabel * messageLabel;
@property (nonatomic , strong)UIImageView * rightImageView;

@property (nonatomic , assign)DYCellDefultState state;

@end

NS_ASSUME_NONNULL_END
