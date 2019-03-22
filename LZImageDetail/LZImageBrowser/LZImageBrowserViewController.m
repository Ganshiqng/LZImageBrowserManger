//
//  LZImageBrowserViewController.m
//  LZImageDetail
//
//  Created by shenzhenshihua on 2018/7/16.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "LZImageBrowserViewController.h"
#import "LZImageBrowserMainView.h"
#import "LZImageBrowserTranslation.h"
#import "LZImageBrowserHeader.h"
#import "SQMultipleView.h"
@interface LZImageBrowserViewController ()<UIViewControllerTransitioningDelegate, LZImageBrowserMainViewDelegate,SQMultipleViewDelegate>
@property (nonatomic , copy) NSArray * imageUrls;
@property (nonatomic , copy) NSArray * originImageViews;
@property (nonatomic , assign) NSInteger selectPage; ///< 选中哪一个imageView

@property (nonatomic , strong) LZImageBrowserMainView * browserMainView;
@property (nonatomic , strong) LZImageBrowserTranslation * browserTranslation;
@property (nonatomic , strong) UIViewController * controller;
//x滑动选择视图
@property (nonatomic , strong) SQMultipleView * sqMultipleView;
@end

@implementation LZImageBrowserViewController
- (id)initWithUrlStr:(NSArray<NSString *>*)imageUrls originImageViews:(NSArray<UIImageView *>*)originImageViews selectPage:(NSInteger)selectPage {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.transitioningDelegate = self;
        self.imageUrls = imageUrls;
        self.originImageViews = originImageViews;
        self.selectPage = selectPage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
    [self.view addSubview:self.browserMainView];

}
-(void)setPreviewActionTitls:(NSArray *)previewActionTitls
{
    _previewActionTitls = previewActionTitls;
   
}

#pragma mark --LZImageBrowserMainViewDelegate
/* 单击 后的操作 */
- (void)imageBrowserMianViewSingleTapWithModel:(LZImageBrowserModel *)imageBrowserModel {
   
         [self dismissViewControllerAnimated:YES completion:nil];
}
/* 长按后的操作 */
-(void)SQ_imageBrowserMianViewLongPressWithModel:(LZImageBrowserModel *)imageBrowserModel
{
    if (self.previewActionTitls.count) {
         [self.sqMultipleView SQqxddViewShow];
    }
}
/* 改变主视图 的 透明度 */
- (void)imageBrowserMainViewTouchMoveChangeMainViewAlpha:(CGFloat)alpha {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
}

#pragma mark --UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.browserTranslation.isBrowserMainView = YES;
    return self.browserTranslation;
}

#pragma mark SQMultipleViewDelegate
/* 选中的项 */
- (void)SQ_BrowserSQMultipleViewTouch:(NSInteger)index
{
    WS(weakSelf);
    if (self.forceTouchActionBlock) {
        weakSelf.forceTouchActionBlock(weakSelf.browserMainView.selectPage, weakSelf.previewActionTitls[index]);
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.browserTranslation.isBrowserMainView = NO;
    return self.browserTranslation;
}


#pragma mark -lazy
- (LZImageBrowserMainView *)browserMainView {
    if (_browserMainView == nil) {
        _browserMainView = [LZImageBrowserMainView imageBrowserMainViewUrlStr:self.imageUrls originImageViews:self.originImageViews selectPage:self.selectPage];
        _browserMainView.delegate = self;
    }
    return _browserMainView;
}

- (LZImageBrowserTranslation *)browserTranslation {
    if (_browserTranslation == nil) {
        _browserTranslation = [[LZImageBrowserTranslation alloc] init];
        _browserTranslation.mainBrowserMainView = self.browserMainView;
        _browserTranslation.browserControllerView = self.view;
    }
    return _browserTranslation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选项弹窗
-(SQMultipleView*)sqMultipleView
{
   if (!_sqMultipleView) {
      _sqMultipleView = [SQMultipleView SQMultipleBrowserforceTouchActionTitles:_previewActionTitls];
      _sqMultipleView.delegate = self;
      [self.view addSubview:_sqMultipleView];
   }
    return _sqMultipleView;
}

@end
