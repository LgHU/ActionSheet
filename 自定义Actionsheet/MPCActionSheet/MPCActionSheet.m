//
//  MPCActionSheet.m
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPCActionSheet.h"
#import "MPFActionSheetBaseCell.h"
#import "MPFActionSheetDefaultCell.h"
#import "MPFActionSheetImageAndTextCell.h"
#import "MPFActionSheetSpaceCell.h"
#import "Masonry.h"

@interface MPCActionSheet ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *options;

@end

@implementation MPCActionSheet

#pragma mark - Inherit

+ (instancetype)actionSheet:(NSArray<MPMActionSheetItem*>*)options {
    MPCActionSheet *actionSheet = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:actionSheet];
    [actionSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(actionSheet.superview);
    }];
    [actionSheet initUI:options];
    return actionSheet;
}

#pragma mark - Public
- (void)show {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).with.offset(-self.totalHeight);
    }];
    
    [UIView animateWithDuration:.001 * self.totalHeight animations:^{
        self.backgroundColor = [UIColor lightGrayColor];
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }];
}

- (void)hideWithComplete:(void(^)(MPCActionSheet *sheet))complete{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
    }];
    
    [UIView animateWithDuration:.001 * self.totalHeight animations:^{
        self.backgroundColor = [UIColor whiteColor];
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (complete) {
            complete(self);
        }
    }];
}

#pragma mark - UI
- (void)initUI:(NSArray<MPMActionSheetItem*>*)options {
    if (!options || ![options isKindOfClass:[NSArray class]]) {
        return ;
    }
    
    [self initOptions:options];
    
    
    self.totalHeight = 0.f;
    for (NSInteger i = 0; i < self.options.count; i++) {
        MPMActionSheetItem *item = options[i];
        self.totalHeight += item.itemHeight;
    }
    
    self.totalHeight = self.totalHeight > kActionSheetMaxHeight ? kActionSheetMaxHeight : self.totalHeight;
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView registerClass:[MPFActionSheetDefaultCell class] forCellReuseIdentifier:@"MPFActionSheetDefaultCell"];
        [tableView registerClass:[MPFActionSheetImageAndTextCell class] forCellReuseIdentifier:@"MPFActionSheetImageAndTextCell"];
        [tableView registerClass:[MPFActionSheetSpaceCell class] forCellReuseIdentifier:@"MPFActionSheetSpaceCell"];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.sectionHeaderHeight = .0;
        tableView.sectionFooterHeight = .0;
        tableView.estimatedRowHeight = .0;
        tableView.estimatedSectionHeaderHeight = .0;
        tableView.estimatedSectionFooterHeight = .0;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:tableView];
        tableView;
    });
    
    [self layoutViews];
}

- (void)layoutViews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.totalHeight);
    }];
    
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}


#pragma mark - Private Methods

- (void)initOptions:(NSArray *)options {
    self.options = [NSMutableArray array];
    for (NSInteger i = 0; i < options.count; i++) {
        MPMActionSheetItem *item = options[i];
        if ([self isValidateActionSheetItem:item]) {
            [self.options addObject:item];
        }
    }
}

- (BOOL)isValidateActionSheetItem:(MPMActionSheetItem*)item {
    if (item && [item isKindOfClass:[MPMActionSheetItem class]]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Actions

#pragma mark - Delegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMActionSheetItem *item = nil;
    if (indexPath.row < self.options.count) {
        item = self.options[indexPath.row];
    }
   
    NSString *reuserIdentifier = @"MPFActionSheetDefaultCell";
    if (item.type == MPMActionSheetItemTypeImageText) {
        reuserIdentifier = @"MPFActionSheetImageAndTextCell";
    } else if (item.type == MPMActionSheetItemTypeSpace) {
        reuserIdentifier = @"MPFActionSheetSpaceCell";
    }
    
    return [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.options.count) {
        MPMActionSheetItem *item = self.options[indexPath.row];
        [((MPFActionSheetBaseCell*)cell) updateWithActionSheetItem:item];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.options.count) {
        MPMActionSheetItem *item = self.options[indexPath.row];
        if (item.handler) {
            item.handler();
        }
        [self hideWithComplete:^(MPCActionSheet *sheet) {
            [sheet removeFromSuperview];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.options.count) {
        MPMActionSheetItem *item = self.options[indexPath.row];
        return item.itemHeight;
    }
   
    return 0;
}

#pragma mark - Data

#pragma mark - Notification

#pragma mark - Getter/Setter

@end
