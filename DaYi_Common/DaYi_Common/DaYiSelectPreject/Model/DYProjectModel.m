//
//  DYProjectModel.m
//  DaYi_Common
//
//  Created by Fukai on 2019/8/21.
//  Copyright © 2019 FuKai. All rights reserved.
//

#import "DYProjectModel.h"

@implementation DYProjectModel

+ (DYProjectModel *)fakeDYProjectModel{
    DYProjectModel * model = [[DYProjectModel alloc]init];
    model.projectName = @"青白江一期项目";//项目名称
    model.projectState = @"在建";//项目状态
    model.enterpriseName = @"四川省成都市中交四局";//所属企业
    model.addressName = @"四川省成都市高新区一区西三标段";//项目地址
    model.periodName = @"2019-10-10  至  2010-10-10";//周期
    return model;
}

@end
