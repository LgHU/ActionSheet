//
//  MPFActionSheetImageAndTextCell.m
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPFActionSheetImageAndTextCell.h"
#import "Masonry.h"

@interface MPFActionSheetImageAndTextCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *label_Title;
@property (nonatomic, strong) UIView *view_Line;

@end

@implementation MPFActionSheetImageAndTextCell

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
    [self.imgView setImage:[UIImage imageNamed:item.imgName]];
    [self.label_Title sizeToFit];
}


#pragma mark - UI
- (void)initUI {
    self.label_Title = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        label;
    });
    
    UIView *imgViewContent = ({
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        view;
    });
    
    self.imgView = ({
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgViewContent addSubview:imgView];
        imgView;
    });
    
    [self.label_Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgViewContent.mas_right);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
    [imgViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(60.);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imgViewContent);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    [self.contentView addSubview:lineView];
    self.view_Line = lineView;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView);
        make.left.equalTo(imgViewContent.mas_right);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(.5);
    }];
}

@end
