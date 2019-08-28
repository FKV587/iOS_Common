//
//  DaYiSelectedProjectView.h
//  DaYi_Common
//
//  Created by Fukai on 2019/8/12.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DaYiSelectedProjectCardViewDelegate <NSObject>


/**
 滚动到某个cell

 @param model model
 */
- (void)selectedProjectModel:(id)model;

/**
 点击cell

 @param model model
 */
- (void)didSelectedProjectModel:(id)model;

@end

@interface DaYiSelectedProjectCardView : UIView

@property (nonatomic , weak)id<DaYiSelectedProjectCardViewDelegate>delegate;
@property (nonatomic , strong)NSArray * list;

@end

NS_ASSUME_NONNULL_END
