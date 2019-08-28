//
//  DYProjectModel.h
//  DaYi_Common
//
//  Created by Fukai on 2019/8/21.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYProjectModel : NSObject

@property (nonatomic , strong)NSString * projectName;//项目名称
@property (nonatomic , strong)NSString * projectState;//项目状态
@property (nonatomic , strong)NSString * enterpriseName;//所属企业
@property (nonatomic , strong)NSString * addressName;//项目地址
@property (nonatomic , strong)NSString * periodName;//周期

+ (DYProjectModel *)fakeDYProjectModel;

@end

NS_ASSUME_NONNULL_END
