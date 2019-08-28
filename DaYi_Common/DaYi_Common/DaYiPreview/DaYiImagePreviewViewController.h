//
//  DaYiImagePreviewViewController.h
//  DaYi_Defines
//
//  Created by Fukai on 2019/8/5.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DaYiImagePreviewViewController : QMUICommonViewController

- (instancetype)initWithImageURLs:(NSArray<NSString *> *)imageURLs currentImageIndex:(NSUInteger)currentImageIndex;
- (instancetype)initWithImages:(NSArray<UIImage *> *)images currentImageIndex:(NSUInteger)currentImageIndex;

@end

NS_ASSUME_NONNULL_END
