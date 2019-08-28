//
//  UIViewController+ImageDispose.m
//  DaYi_Defines
//
//  Created by Fukai on 2018/11/7.
//  Copyright © 2018年 FuKai. All rights reserved.
//

#import "UIViewController+ImageDispose.h"

static void * MaxSelectedImageCount = "MaxSelectedImageCount";

@implementation UIViewController (ImageDispose)

#pragma mark -- 查看大图

- (void)showGroupImageArray:(NSArray <NSString *>*)array selectedIndex:(int)selectedIndex{
    DaYiImagePreviewViewController * vc = [[DaYiImagePreviewViewController alloc]initWithImageURLs:array currentImageIndex:selectedIndex];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showImageWithImageArray:(NSArray <UIImage *>*)images{
    [self showImageWithImageArray:images selectedIndex:0];
}

- (void)showImageWithImageArray:(NSArray <UIImage *>*)images selectedIndex:(int)selectedIndex{
    DaYiImagePreviewViewController * vc = [[DaYiImagePreviewViewController alloc]initWithImages:images currentImageIndex:selectedIndex];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 相册图片选择 --
- (void)showActionSheetCameraOrPhotoLibrary{
    [self showActionSheetCameraOrPhotoLibraryMaxCount:1];
}

- (void)showActionSheetCameraOrPhotoLibraryMaxCount:(NSInteger) maxCount{
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:nil];
    @weakify(self)
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"拍照" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        @strongify(self)
        [self showImagePickerWithCamera];
    }];
    QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"从相册选择" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        @strongify(self)
        [self authorizationPresentAlbumViewControllerWithTitle:@"选择图片" maximumSelectImageCount:maxCount];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:QMUIAlertControllerStyleActionSheet];
    [alertController addAction:action1];
    [alertController addAction:action3];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
}

- (void)authorizationPresentAlbumViewControllerWithTitle:(NSString *)title{
    [self authorizationPresentAlbumViewControllerWithTitle:title maximumSelectImageCount:1];
}

- (void)authorizationPresentAlbumViewControllerWithTitle:(NSString *)title maximumSelectImageCount:(NSInteger)maximumSelectImageCount{
    if ([QMUIAssetsManager authorizationStatus] == QMUIAssetAuthorizationStatusNotDetermined) {
        [QMUIAssetsManager requestAuthorization:^(QMUIAssetAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentAlbumViewControllerWithTitle:title maximumSelectImageCount:[NSNumber numberWithInteger:maximumSelectImageCount]];
            });
        }];
    } else {
        [self presentAlbumViewControllerWithTitle:title maximumSelectImageCount:[NSNumber numberWithInteger:maximumSelectImageCount]];
    }
}

- (void)presentAlbumViewControllerWithTitle:(NSString *)title maximumSelectImageCount:(NSNumber *)maximumSelectImageCount{
        // 创建一个 QMUIAlbumViewController 实例用于呈现相簿列表
    QMUIAlbumViewController *albumViewController = [[QMUIAlbumViewController alloc] init];
    albumViewController.albumViewControllerDelegate = self;
    albumViewController.contentType = QMUIAlbumContentTypeOnlyPhoto;
    albumViewController.title = title ? title : @"选择多张图片";
    QMUINavigationController *navigationController = [[QMUINavigationController alloc] initWithRootViewController:albumViewController];
    
    objc_setAssociatedObject(albumViewController, MaxSelectedImageCount, maximumSelectImageCount, OBJC_ASSOCIATION_COPY);

// 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
//    [albumViewController pickLastAlbumGroupDirectlyIfCan];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - <QMUIAlbumViewControllerDelegate>

- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController{
    QMUIImagePickerViewController *imagePickerViewController = [[QMUIImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    NSNumber * number = objc_getAssociatedObject(albumViewController, MaxSelectedImageCount);

    imagePickerViewController.maximumSelectImageCount = [number integerValue];
    return imagePickerViewController;
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>

- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerViewController.assetsGroup ablumContentType:QMUIAlbumContentTypeOnlyPhoto userIdentify:nil];
    
    [self sendImageWithImagesAssetArray:imagesAssetArray];
}

- (QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController {
    QDMultipleImagePickerPreviewViewController *imagePickerPreviewViewController = [[QDMultipleImagePickerPreviewViewController alloc] init];
    imagePickerPreviewViewController.delegate = self;
    imagePickerPreviewViewController.maximumSelectImageCount = imagePickerViewController.maximumSelectImageCount;
    imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
    return imagePickerPreviewViewController;
}

#pragma - <QMUIImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didUncheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

// 更新选中的图片数量
- (void)updateImageCountLabelForPreviewView:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController {
    QDMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (QDMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
    NSUInteger selectedCount = [imagePickerPreviewViewController.selectedImageAssetArray count];
    if (selectedCount > 0) {
        customImagePickerPreviewViewController.imageCountLabel.text = [[NSString alloc] initWithFormat:@"%@", @(selectedCount)];
        customImagePickerPreviewViewController.imageCountLabel.hidden = NO;
        [QMUIImagePickerHelper springAnimationOfImageSelectedCountChangeWithCountLabel:customImagePickerPreviewViewController.imageCountLabel];
    } else {
        customImagePickerPreviewViewController.imageCountLabel.hidden = YES;
    }
}

#pragma - <QDMultipleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QDMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup ablumContentType:QMUIAlbumContentTypeOnlyPhoto userIdentify:nil];
    
    [self sendImageWithImagesAssetArray:imagesAssetArray];
}

#pragma -- 回调发送图片 --
- (void)sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> * _Nonnull)imagesAssetArray {
    @weakify(self)
    for (QMUIAsset *asset in imagesAssetArray) {
        [QMUIImagePickerHelper requestImageAssetIfNeeded:asset completion:^(QMUIAssetDownloadStatus downloadStatus, NSError *error) {
            @strongify(self)
            if (downloadStatus == QMUIAssetDownloadStatusDownloading) {
                [self.view showDaYiLoadingTitle:@"从 iCloud 加载中"];
            } else if (downloadStatus == QMUIAssetDownloadStatusSucceed) {
                [self sendImageWithImagesAssetArrayIfDownloadStatusSucceed:asset];
            } else {
                [self.view showDaYiLoadingTitle:@"iCloud 下载错误，请重新选图"];
            }
        }];
    }
}

- (void)sendImageWithImagesAssetArrayIfDownloadStatusSucceed:(QMUIAsset *)asset {
    if (asset.downloadStatus == QMUIAssetDownloadStatusSucceed) {
        UIImage * tempImage = [UIImage scaleImage:asset.originImage];
        [self sendCameraPickerImage:tempImage];
    }
}

#pragma mark -- UIImagePickerControllerDelegate --

- (void)showImagePickerWithCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -- UINavigationControllerDelegate,UIImagePickerControllerDelegate --

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *tempImage = [UIImage fixOrientation:info[UIImagePickerControllerOriginalImage]];
        tempImage = [UIImage scaleImage:tempImage];
        [self sendCameraPickerImage:tempImage];
    }];
}

- (void)sendCameraPickerImage:(UIImage *)image{
    NSLog(@"%@ -- %@",NSStringFromClass([self class]),image);
}

@end
