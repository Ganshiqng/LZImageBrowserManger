//
//  LZImageBrowserManger.m
//  LZImageDetail
//
//  Created by shenzhenshihua on 2018/7/16.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "LZImageBrowserManger.h"
#import "LZImageBrowserForceTouchViewController.h"
#import "LZImageBrowserViewController.h"
#import "LZImageBrowserHeader.h"

@interface LZImageBrowserManger ()<UIViewControllerPreviewingDelegate>
//链接数组
@property(nonatomic,copy)NSArray * imageUrls;
//图片所在数组
@property(nonatomic,copy)NSArray * originImageViews;
//控制器
@property(nonatomic,weak)UIViewController * controller;
//点击回调Block
@property(nonatomic,copy)ForceTouchActionBlock forceTouchActionBlock;
//长按显示的数组
@property(nonatomic,copy)NSArray * previewActionTitls;
@end
@implementation LZImageBrowserManger

+ (id)imageBrowserMangerWithUrlStr:(NSArray<NSString *>*)imageUrls originImageViews:(NSArray<UIImageView *>*)originImageViews originController:(UIViewController *)controller  forceTouchActionTitles:(nullable NSArray <NSString *>*)titles forceTouchActionComplete:(nullable ForceTouchActionBlock)forceTouchActionBlock {
    LZImageBrowserManger *imageBrowserManger = [[LZImageBrowserManger alloc] init];
    imageBrowserManger.imageUrls = imageUrls;
    imageBrowserManger.originImageViews = originImageViews;
    imageBrowserManger.controller = controller;
    if ( titles.count) {
        imageBrowserManger.previewActionTitls = titles;
        imageBrowserManger.forceTouchActionBlock = forceTouchActionBlock;
    }
    
    return imageBrowserManger;
}
- (void)showImageBrowser {
    LZImageBrowserViewController * imageBrowserViewController = [[LZImageBrowserViewController alloc] initWithUrlStr:self.imageUrls originImageViews:self.originImageViews selectPage:self.selectPage];
    if (self.previewActionTitls) {
        imageBrowserViewController.previewActionTitls = self.previewActionTitls;
        imageBrowserViewController.forceTouchActionBlock = self.forceTouchActionBlock;
    }
    [self.controller presentViewController:imageBrowserViewController animated:YES completion:nil];
}

#pragma mark --UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSInteger selectPage = [self.originImageViews indexOfObject:[previewingContext sourceView]];
    self.selectPage = selectPage;
    UIImage * showOriginForceImage = (UIImage *)[self.originImageViews[selectPage] image];
    NSString * showForceImageUrl = self.imageUrls[selectPage];
    
    LZImageBrowserForceTouchViewController * forceTouchController = [[LZImageBrowserForceTouchViewController alloc] init];
    forceTouchController.showOriginForceImage = showOriginForceImage;
    forceTouchController.showForceImageUrl = showForceImageUrl;
    if (self.previewActionTitls.count) {
        forceTouchController.previewActionTitls = self.previewActionTitls;
        forceTouchController.forceTouchActionBlock = self.forceTouchActionBlock;
    }

    CGFloat showImageViewW;
    CGFloat showImageViewH;
    CGFloat showImageW = showOriginForceImage.size.width;
    CGFloat showImageH = showOriginForceImage.size.height;
    if (showImageH/showImageW > Screen_Height/Screen_Width) {
        showImageViewH = Screen_Height;
        showImageViewW = Screen_Height * showImageW/showImageH;
    } else {
        showImageViewW = Screen_Width;
        showImageViewH = Screen_Width * showImageH/showImageW;
    }
    
    //设置展示大小
    forceTouchController.preferredContentSize = CGSizeMake((showImageViewW-2)/1, (showImageViewH-2)/1);
    
    return forceTouchController;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    LZImageBrowserViewController * imageBrowserViewController = [[LZImageBrowserViewController alloc] initWithUrlStr:self.imageUrls originImageViews:self.originImageViews selectPage:self.selectPage];
    [self.controller presentViewController:imageBrowserViewController animated:NO completion:nil];
}

@end
