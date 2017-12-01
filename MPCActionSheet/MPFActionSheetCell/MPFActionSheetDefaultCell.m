//
//  MPFActionSheetDefaultCell.m
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPFActionSheetDefaultCell.h"
#import "Masonry.h"

@interface MPFActionSheetDefaultCell ()

@property (nonatomic, strong) UILabel *label_Title;
@property (nonatomic, strong) UIView *view_Line;


@end

@implementation MPFActionSheetDefaultCell

#pragma mark - inherit

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    
    return self;
}


#pragma mark - Public
- (void)updateWithActionSheetItem:(MPMActionSheetItem*)item {
    [super updateWithActionSheetItem:item];
    self.view_Line.backgroundColor = item.lineColor;
    self.label_Title.font = item.titleFont;
    self.label_Title.textColor = item.titleColor;
    self.label_Title.textAlignment = item.textAlignment;
    self.contentView.backgroundColor = item.backgroundColor;
    
    self.label_Title.text = item.text;
    [self.label_Title sizeToFit];
}


#pragma mark - UI
- (void)initUI {
    self.label_Title = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label;
    });
    
    UIView *lineView = [[UIView alloc]init];
    [self.contentView addSubview:lineView];
    self.view_Line = lineView;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(.5);
    }];
    
    [self.label_Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}


@end
