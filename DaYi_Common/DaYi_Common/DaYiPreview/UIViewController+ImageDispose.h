//
//  UIViewController+ImageDispose.h
//  DaYi_Defines
//
//  Created by Fukai on 2018/11/7.
//  Copyright © 2018年 FuKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDMultipleImagePickerPreviewViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ImageDispose)<QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate,QDMultipleImagePickerPreviewViewControllerDelegate,UIImagePickerControllerDelegate>

/**
 显示大图

 @param array string
 @param selectedIndex 选中
 */
- (void)showGroupImageArray:(NSArray <NSString *> *)array selectedIndex:(int)selectedIndex;

/**
 显示大图

 @param images 图片详情
 */
- (void)showImageWithImageArray:(NSArray <UIImage *>*)images;

/**
 显示大图
 
 @param images 图片详情
 @param selectedIndex 当前展示第一张图
 */
- (void)showImageWithImageArray:(NSArray <UIImage *>*)images selectedIndex:(int)selectedIndex;


/**
 弹窗选择拍照还是相册选择 默认只可以选择一张
 */
- (void)showActionSheetCameraOrPhotoLibrary;

/**
 弹窗选择拍照还是相册选择

 @param maxCount 最大选择张数
 */
- (void)showActionSheetCameraOrPhotoLibraryMaxCount:(NSInteger) maxCount;
/**
 选择本地相册图片
 选择一张
 @param title 顶部title
 */
- (void)authorizationPresentAlbumViewControllerWithTitle:(NSString *)title;

/**
 选择返回图片

 @param image 图片
 */
- (void)sendCameraPickerImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
