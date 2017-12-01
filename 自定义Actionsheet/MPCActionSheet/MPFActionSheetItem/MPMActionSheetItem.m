//
//  MPMActionSheetItem.m
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPMActionSheetItem.h"

@implementation MPMActionSheetItem

- (instancetype)initWithType:(MPMActionSheetItemType)actionType
                   imageName:(NSString*)imgName
                        text:(NSString*)text handler:(ActionSheetItemHandler)handler {
    if (self = [super init]) {
        _type = actionType;
        _imgName = imgName;
        _text = text;
        _handler = [handler copy];
    }
    
    return self;
}

+ (instancetype)textOnlyItem:(NSString*)text handler:(ActionSheetItemHandler)handler {
    MPMActionSheetItem *item = [[MPMActionSheetItem alloc]initWithType:MPMActionSheetItemTypeText imageName:nil text:text handler:handler];
    item.textAlignment = NSTextAlignmentCenter;
    return item;
}

+ (instancetype)imageAndTextItem:(NSString*)imgName text:(NSString*)text handler:(ActionSheetItemHandler)handler {
    MPMActionSheetItem *item = [[MPMActionSheetItem alloc]initWithType:MPMActionSheetItemTypeImageText imageName:imgName text:text handler:handler];
    return item;
}

+ (instancetype)destructionItemHandler:(ActionSheetItemHandler)handler {
    MPMActionSheetItem *item = [[MPMActionSheetItem alloc]initWithType:MPMActionSheetItemTypeText imageName:nil text:@"取消" handler:handler];
    item.titleFont = kActionSheetItemDefaultDestructionTitleFont;
    item.titleColor = kActionSheetItemDefaultDestructionTitleColor;
    item.lineColor = [UIColor whiteColor];
    return item;
}

+ (instancetype)spaceItem {
    MPMActionSheetItem *item = [[MPMActionSheetItem alloc]initWithType:MPMActionSheetItemTypeText imageName:nil text:nil handler:nil];
    item.backgroundColor = kActionSheetItemDefaultSpaceBgColor;
    return item;
}

- (CGFloat)itemHeight {
    if (_itemHeight > 0 ) {
        return _itemHeight;
    }
    
    return kActionSheetItemDefaultHeight;
}

- (UIFont *)titleFont {
    if (_titleFont) {
        return _titleFont;
    }
    
    return KActionSheetItemDefaultTitleFont;
}

- (UIColor *)titleColor {
    if (_titleColor) {
        return _titleColor;
    }
    
    return kActionSheetItemDefaultTitleColor;
}

- (UIColor *)backgroundColor {
    if (_backgroundColor) {
        return _backgroundColor;
    }
    
    return kActionSheetItemDefaultBackgroundColor;
}

- (UIColor *)lineColor {
    if (_lineColor) {
        return _lineColor;
    }
    
    return kActionSheetItemDefaultLineBgColor;
}

@end
