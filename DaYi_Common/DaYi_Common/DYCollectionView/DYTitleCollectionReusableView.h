//
//  DYTitleCollectionReusableView.h
//  NP_DaYi_JRXB
//
//  Created by Fukai on 2019/8/20.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYTitleCollectionReusableView : UICollectionReusableView

- (void)setTitleLabelText:(NSString *)text;
- (void)setTitleLabelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
