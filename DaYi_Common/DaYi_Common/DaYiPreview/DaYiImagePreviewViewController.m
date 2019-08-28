//
//  DaYiImagePreviewViewController.m
//  DaYi_Defines
//
//  Created by Fukai on 2019/8/5.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DaYiImagePreviewViewController.h"

@interface DaYiImagePreviewViewController ()<QMUIImagePreviewViewDelegate>

@property(nonatomic, strong) QMUIImagePreviewView *imagePreviewView;
@property(nonatomic, strong) NSArray * images;
@property(nonatomic, assign) NSUInteger currentImageIndex;

@end

@implementation DaYiImagePreviewViewController

- (instancetype)initWithImages:(NSArray<UIImage *> *)images currentImageIndex:(NSUInteger)currentImageIndex{
    self = [super init];
    if (self) {
        self.currentImageIndex = currentImageIndex;
        self.images = images;
    }
    return self;
}

- (instancetype)initWithImageURLs:(NSArray<NSString *> *)imageURLs currentImageIndex:(NSUInteger)currentImageIndex{
    self = [super init];
    if (self) {
        self.currentImageIndex = currentImageIndex;
        self.images = imageURLs;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imagePreviewView.frame = CGRectMake(0, NavigationContentTopConstant, DEVICE_WIDTH, DEVICE_HEIGHT - NavigationContentTopConstant - SafeAreaInsetsConstantForDeviceWithNotch.bottom);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = [self titleForIndex:self.imagePreviewView.currentImageIndex];
}

- (NSString *)titleForIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%@ / %@", @(index + 1), @(self.images.count)];
}
#pragma mark - <QMUIImagePreviewViewDelegate>

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return self.images.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    
    zoomImageView.contentMode = UIViewContentModeScaleAspectFit;
    id object = self.images[index];
    if ([object isKindOfClass:[UIImage class]]){
        zoomImageView.image = self.images[index];
    }else{
        UIImage * image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:object];
        if (image) {
            zoomImageView.image = image;
            [zoomImageView hideEmptyView];// 把 loading 隐藏掉
        }else{
            zoomImageView.image = nil; // 第 2 张图将图片清空，模拟延迟加载的场景
            [zoomImageView showLoading];// 显示 loading（loading 也可与图片同时显示）
            [[SDWebImageManager sharedManager]loadImageWithURL:[NSURL URLWithString:self.images[index]] options:SDWebImagePreloadAllFrames progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (finished) {
                    NSUInteger indexForZoomImageView = [imagePreviewView indexForZoomImageView:zoomImageView];
                    if (indexForZoomImageView == index) {
                        zoomImageView.image = image;
                        [zoomImageView hideEmptyView];// 把 loading 隐藏掉
                    }
                }
            }];
        }
    }
}

- (QMUIImagePreviewMediaType)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView assetTypeAtIndex:(NSUInteger)index {
    return QMUIImagePreviewMediaTypeImage;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView willScrollHalfToIndex:(NSUInteger)index {
    self.title = [self titleForIndex:index];
}

#pragma mark -- setter getter --

- (QMUIImagePreviewView *)imagePreviewView{
    if (!_imagePreviewView) {
        _imagePreviewView = [[QMUIImagePreviewView alloc] init];
        _imagePreviewView.delegate = self;
        _imagePreviewView.loadingColor = UIColorGray;// 设置每张图片里的 loading 的颜色，需根据业务场景来修改
        _imagePreviewView.collectionViewLayout.minimumLineSpacing = 0;// 去掉每张图片之间的间隙
        _imagePreviewView.currentImageIndex = self.currentImageIndex;
        [self.view addSubview:_imagePreviewView];
    }
    return _imagePreviewView;
}

@end
