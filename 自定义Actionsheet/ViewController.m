//
//  ViewController.m
//  自定义Actionsheet
//
//  Created by LG on 2017/11/30.
//  Copyright © 2017年 my. All rights reserved.
//

#import "ViewController.h"
#import "MPCActionSheet.h"
#import "UIImage+MPCActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MPMActionSheetItem *item1 = [MPMActionSheetItem imageAndTextItem:@"收藏-常态" text:@"收藏到影单" handler:^{
        NSLog(@"删除聊天记录...");
    }];
    MPMActionSheetItem *item2 = [MPMActionSheetItem imageAndTextItem:@"举报-常态" text:@"举报" handler:^{
        NSLog(@"举报...");
    }];
    item2.lineColor = [UIColor whiteColor];
    
    MPMActionSheetItem *item4 = [MPMActionSheetItem spaceItem];
    item4.itemHeight = 20;
    item4.backgroundColor = [UIColor whiteColor];
    MPCActionSheet *sheet = [MPCActionSheet actionSheet:@[item1,item2,item4]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sheet show];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
