//
//  MPMActionSheetItem.h
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define kActionSheetItemDefaultHeight 50. //默认列表高度
#define KActionSheetItemDefaultTitleFont [UIFont systemFontOfSize:18.] //默认标题font
#define kActionSheetItemDefaultTitleColor COLOR_WITH_HEX(0x24242C) //默认标题颜色
#define kActionSheetItemDefaultDestructionTitleFont [UIFont systemFontOfSize:18.] //默认取消按钮字体
#define kActionSheetItemDefaultDestructionTitleColor COLOR_WITH_HEX(0x97979C) //默认取消按钮颜色
#define kActionSheetItemDefaultBackgroundColor [UIColor whiteColor] //默认选项背景色
#define kActionSheetItemDefaultSpaceBgColor COLOR_WITH_HEX(0xF8F8F8) //默认分割选项背景色
#define kActionSheetItemDefaultLineBgColor COLOR_WITH_HEX(0xededed) //默认选项底部分割线背景色

typedef NS_ENUM(NSInteger , MPMActionSheetItemType) {
    MPMActionSheetItemTypeText = 0,
    MPMActionSheetItemTypeImageText,
    MPMActionSheetItemTypeSpace
};

typedef void (^ActionSheetItemHandler)(void);

@interface MPMActionSheetItem : NSObject

/**
 类型
    type = MPMActionSheetItemTypeText 只需要设置text
    type = MPMActionSheetItemTypeImageText 要设置text和imgName
    type = MPMActionSheetItemTypeSpace 需要设置分割高度 itemHeight
 */
@property (nonatomic, assign) MPMActionSheetItemType type;

/**
 *图片名称
 */
@property (nonatomic, copy) NSString *imgName;

/**
 *选项名称
 */
@property (nonatomic, copy) NSString *text;

/**
 *选项点击事件
 */
@property (nonatomic, copy) ActionSheetItemHandler handler;

/*!
 *以下为选填，下面的值都有默认值
 */

//选项的高度，不设置的话是默认 50
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *lineColor;

- (instancetype)initWithType:(MPMActionSheetItemType)actionType
                   imageName:(NSString*)imgName
                        text:(NSString*)text handler:(ActionSheetItemHandler)handler;

/**
 获取一个 type = MPMActionSheetItemTypeText 选项

 @param text 文字
 @param handler 事件回调
 @return 选项
 */
+ (instancetype)textOnlyItem:(NSString*)text handler:(ActionSheetItemHandler)handler;

/**
 获取一个 type = MPMActionSheetItemTypeImageText 选项
 
 @param imgName 图片名称
 @param text 文字
 @param handler 事件回调
 @return 选项
 */
+ (instancetype)imageAndTextItem:(NSString*)imgName text:(NSString*)text handler:(ActionSheetItemHandler)handler;

/**
 获取取消或者删除选项
   注意：该方法默认设置的text为‘取消’,type = MPMActionSheetItemTypeText
 @param handler 事件
 @return 选项
 */
+ (instancetype)destructionItemHandler:(ActionSheetItemHandler)handler;

/**
 获取间隔选项
   注意：该方法默认设置 handler = nil
 @return 选项
 */
+ (instancetype)spaceItem;


@end
