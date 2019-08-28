//
//  DYPhotoSelectedView.h
//  DaYi_Common
//
//  Created by Fukai on 2019/8/14.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DYPhotoSelectedViewDelegate <NSObject>

- (void)deletePhoto:(NSString *)url;
- (void)showPhoto:(NSString *)url;
- (void)addPhoto;

@end

@interface DYPhotoSelectedView : UIView

@property (nonatomic , weak)id<DYPhotoSelectedViewDelegate> delegate;

- (CGFloat)viewHeight;
- (void)setPhotos:(NSArray *)photos withMaxConunt:(NSInteger)maxCount;

@end

NS_ASSUME_NONNULL_END
