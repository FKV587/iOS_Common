//
//  DYPhotoSelectedView.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/14.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYPhotoSelectedView.h"

static CGFloat const MenuWidth = 60.0;
static CGFloat const MenuHeight = 70.0;
static CGFloat const MenuTopMargin = 20.0;
static CGFloat const MenuLeftMargin = 21.0;

static void * PhotoImageURL = "PhotoImageURL";

@interface DYPhotoSelectedView ()

@property (nonatomic , strong)NSArray * photos;
@property (nonatomic , assign)NSInteger maxCount;

@end

@implementation DYPhotoSelectedView

- (CGFloat)viewHeight{
    CGFloat conunt = (self.photos.count / 4 + ((self.photos.count == self.maxCount) ? (((self.photos.count % 4) == 0) ? 0 : 1) : 1));
    CGFloat height = conunt * (MenuTopMargin + MenuHeight) + MenuTopMargin;
    return height;
}

- (void)setPhotos:(NSArray *)photos withMaxConunt:(NSInteger)maxCount{
    CGFloat spacing = (SCREEN_WIDTH - (MenuLeftMargin * 2) - (MenuWidth * 4)) / 3.0;
    if (!photos){
        [self qmui_removeAllSubviews];
        CGFloat X = (1 % 4) * (spacing + MenuWidth) + MenuLeftMargin;
        CGFloat Y = (1 / 4) * (MenuTopMargin + MenuHeight) + MenuTopMargin;
        [self addPhotoView:CGRectMake(X, Y, MenuWidth, MenuHeight)];
    }else if (!([self.photos isEqualToArray:photos] && self.maxCount == maxCount)) {
        [self qmui_removeAllSubviews];
        self.maxCount = maxCount;
        self.photos = [photos copy];
        
        for (int idx = 0; idx < self.maxCount; idx ++) {
            CGFloat X = (idx % 4) * (spacing + MenuWidth) + MenuLeftMargin;
            CGFloat Y = (idx / 4) * (MenuTopMargin + MenuHeight) + MenuTopMargin;
            if (self.photos.count > idx) {
                id obj = self.photos[idx];
                [self phothImageView:CGRectMake(X, Y, MenuWidth, MenuHeight) imageURL:obj];
            }else{
                [self addPhotoView:CGRectMake(X, Y, MenuWidth, MenuHeight)];
                break;
            }
        }
    }
}

- (void)addPhotoView:(CGRect)rect{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:rect];
//    imageView.image = [UIImage imageNamed:@""];
    imageView.backgroundColor = UIColorRed;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]init];
    [tapRecognize addTarget:self action:@selector(addPhotoAction)];
    [imageView addGestureRecognizer:tapRecognize];
}

- (void)phothImageView:(CGRect)rect imageURL:(NSString *)url{
    __block UIImageView * imageView = [[UIImageView alloc]initWithFrame:rect];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = UIColorBlue;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]init];
    [tapRecognize addTarget:self action:@selector(showPhotoAction:)];
    objc_setAssociatedObject(tapRecognize, PhotoImageURL, url, OBJC_ASSOCIATION_COPY);
    [imageView addGestureRecognizer:tapRecognize];

    QMUIButton * deleteButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:@"X" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_top).mas_offset(-10);
        make.right.equalTo(imageView.mas_right).mas_offset(10);
        make.height.width.mas_offset(20.0);
    }];
    objc_setAssociatedObject(deleteButton, PhotoImageURL, url, OBJC_ASSOCIATION_COPY);
}

#pragma mark -- Action --

- (void)addPhotoAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPhoto)]) {
        [self.delegate addPhoto];
    }
}

- (void)showPhotoAction:(UITapGestureRecognizer *)gesture{
    NSString * url = objc_getAssociatedObject(gesture, PhotoImageURL);
    if (self.delegate && [self.delegate respondsToSelector:@selector(showPhoto:)]) {
        [self.delegate showPhoto:url];
    }
}

- (void)deleteButtonAction:(QMUIButton *)sender{
    NSString * url = objc_getAssociatedObject(sender, PhotoImageURL);
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletePhoto:)]) {
        [self.delegate deletePhoto:url];
    }
}

@end
