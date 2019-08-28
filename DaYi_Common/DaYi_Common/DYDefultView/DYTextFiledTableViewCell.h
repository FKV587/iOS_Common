//
//  DYTextfiledTableViewCell.h
//  DaYi_Common
//
//  Created by Fukai on 2019/8/26.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYTextFiledTableViewCell : QMUITableViewCell

@property (nonatomic , strong)QMUILabel * titleLabel;
@property (nonatomic , strong)QMUITextField * textField;
@property (nonatomic , strong)UIImageView * arrowImageView;

@end

NS_ASSUME_NONNULL_END
