//
//  MPFActionSheetSpaceCell.m
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPFActionSheetSpaceCell.h"

@implementation MPFActionSheetSpaceCell

- (void)updateWithActionSheetItem:(MPMActionSheetItem*)item {
    [super updateWithActionSheetItem:item];
    self.contentView.backgroundColor = item.backgroundColor;
}


@end
