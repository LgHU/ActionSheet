//
//  MPCActionSheet.h
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMActionSheetItem.h"

#define kActionSheetMaxHeight ([UIScreen mainScreen].bounds.size.height / 2.0)

@interface MPCActionSheet : UIView

+ (instancetype)actionSheet:(NSArray<MPMActionSheetItem*>*)options;

- (void)show;
- (void)hideWithComplete:(void(^)(MPCActionSheet *sheet))complete;

@end
