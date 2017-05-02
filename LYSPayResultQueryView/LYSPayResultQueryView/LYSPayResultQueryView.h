//
//  LYSPayResultQueryView.h
//  LYSPayResultQueryView
//
//  Created by jk on 2017/4/30.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSPayResultQueryView : UIView

#pragma mark - 按钮的颜色
@property(nonatomic,strong)UIColor *loadBtnBgColor;

#pragma mark - 加载中按钮的标题
@property(nonatomic,copy)NSString *loadingBtnTitle;

#pragma mark - 正常时的颜色
@property(nonatomic,strong)UIColor *normalTextColor;

#pragma mark - 异常时的颜色
@property(nonatomic,strong)UIColor *failTextColor;

#pragma mark - 成功时的颜色
@property(nonatomic,strong)UIColor *succTextColor;

#pragma mark - 正在加载的文本提示
@property(nonatomic,copy)NSString *loadingContentText;

#pragma mark - 标题
@property(nonatomic,copy)NSString *title;

#pragma mark - 内容
@property(nonatomic,copy)NSString *content;

#pragma mark - 加载按钮点击回调
@property(nonatomic,copy)void(^LoadingBtnClickBlock)(LYSPayResultQueryView * queryView);

#pragma mark - 关闭视图回调
@property(nonatomic,copy)void(^CloseWinBlock)(LYSPayResultQueryView * queryView);

#pragma mark - 点击外面是否取消
@property(nonatomic,assign)BOOL dismissTouchOutside;

#pragma mark - 是否能关闭
@property(nonatomic,assign)BOOL canClose;

#pragma mark - 关闭
-(void)dismiss:(void(^)())completion;

#pragma mark - 显示
-(void)show:(void(^)())completion;

#pragma mark - 开始查询
-(void)startQuery;

#pragma mark - 停止查询
-(void)stopQuery:(NSString*)tipMsg  loadingBtnTitle:(NSString*)loadingBtnTitle withResult:(BOOL)result LoadingBtnClickBlock:(void(^)(LYSPayResultQueryView * queryView))LoadingBtnClickBlock;

#pragma mark - 显示
-(void)showInView:(UIView*)view completion:(void(^)())completion;


@end
