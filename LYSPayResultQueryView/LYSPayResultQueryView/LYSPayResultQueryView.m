//
//  LYSPayResultQueryView.m
//  LYSPayResultQueryView
//
//  Created by jk on 2017/4/30.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPayResultQueryView.h"
#import "LYSLoadingButton.h"
#import "UIColor+image.h"
#import "NSString+autoSize.h"

@interface LYSPayResultQueryView ()

#pragma mark - 加载按钮
@property(nonatomic,strong)LYSLoadingButton *loadingBtn;

#pragma mark - 内层容器视图
@property(nonatomic,strong)UIView *innerContainerView;

#pragma mark - 外层容器视图
@property(nonatomic,strong)UIView *outerContainerView;

#pragma mark - duration
@property(nonatomic,assign)CGFloat duration;

#pragma mark - 关闭按钮
@property(nonatomic,strong)UIButton *closeBtn;

#pragma mark - 标题
@property(nonatomic,strong)UILabel *titleLb;

#pragma mark - 内容
@property(nonatomic,strong)UILabel *contentLb;

#pragma mark - 是否正在加载
@property(nonatomic,assign)BOOL isLoading;

@end

@implementation LYSPayResultQueryView

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initConfig];
    }
    return self;
}

#pragma mark - 初始化配置
-(void)initConfig{
    [self setDefaults];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [self addSubview:self.outerContainerView];
    [self.outerContainerView addSubview:self.innerContainerView];
    [self.outerContainerView addSubview:self.closeBtn];
    [self.innerContainerView addSubview:self.loadingBtn];
    [self.innerContainerView addSubview:self.titleLb];
    [self.innerContainerView addSubview:self.contentLb];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = self.title;
}


-(void)setContent:(NSString *)content{
    _content = content;
    self.contentLb.text = self.content;
}

#pragma mark - 缩放x
-(CGFloat)scaleX:(CGFloat)size{
    if ([UIScreen mainScreen].bounds.size.height > 480.f) {
        size = size * ([UIScreen mainScreen].bounds.size.width / 320.f);
    }
    return size;
}

#pragma mark - 缩放y
-(CGFloat) scaleY:(CGFloat)size{
    if ([UIScreen mainScreen].bounds.size.height > 480.f) {
        size = size * ([UIScreen mainScreen].bounds.size.height / 568.f);
    }
    return size;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.outerContainerView.frame = CGRectMake([self scaleX:40.f],
                                               (CGRectGetHeight(self.frame) - [self innerContainerH] - self.closeBtn.imageView.image.size.height) * 0.5,
                                               CGRectGetWidth(self.frame) - [self scaleX:80.f] ,
                                               [self innerContainerH] + self.closeBtn.imageView.image.size.height);
    
    self.closeBtn.frame = CGRectMake(CGRectGetWidth(self.outerContainerView.frame) - self.closeBtn.imageView.image.size.width,
                                     0,
                                     self.closeBtn.imageView.image.size.width,
                                     self.closeBtn.imageView.image.size.height);
    
    self.innerContainerView.frame = CGRectMake(CGRectGetWidth(self.closeBtn.frame) / 2,
                                               CGRectGetWidth(self.closeBtn.frame) / 2,
                                               CGRectGetWidth(self.outerContainerView.frame) - CGRectGetWidth(self.closeBtn.frame),
                                               [self innerContainerH]);
    
    self.titleLb.frame = CGRectMake(0, 0, CGRectGetWidth(self.innerContainerView.frame) , [self titleH]);
    
    self.contentLb.frame = CGRectMake([self scaleX:10],
                                      CGRectGetMaxY(self.titleLb.frame),
                                      CGRectGetWidth(self.innerContainerView.frame) - [self scaleX:20],
                                      [self contentH]);
    
    self.loadingBtn.frame = CGRectMake([self scaleX:40.f],
                                       CGRectGetMaxY(self.contentLb.frame) + [self scaleY:10],
                                       CGRectGetWidth(self.innerContainerView.frame) - [self scaleX:80.f],
                                       [self loadingBtnH]);
    
}

-(void)setCanClose:(BOOL)canClose{
    _canClose = canClose;
    self.closeBtn.hidden = !self.canClose;
}

#pragma mark - 标题高度
-(CGFloat)titleH{
    return [self scaleY:40.f];
}

#pragma mark - 内容的高度
-(CGFloat)contentH{
    return 60.f;
}

#pragma mark - 加载按钮的高度
-(CGFloat)loadingBtnH{
    return [self scaleY:30.f];
}

#pragma mark - 内部的高度
-(CGFloat)innerContainerH{
    return [self titleH] + [self contentH] + [self loadingBtnH] + [self scaleY:20];
}

#pragma mark - 设置默认值
-(void)setDefaults{
    _duration = 0.35;
    _loadingBtnTitle = @"开始查询";
    _normalTextColor = [UIColor hexString:@"414114"];
    _failTextColor = [UIColor redColor];
    _succTextColor = [UIColor hexString:@"65c5e9"];
    _loadBtnBgColor = [UIColor hexString:@"65c5e9"];
    _loadingContentText = @"正在查询结果...";
}

#pragma mark - 标题
-(UILabel*)titleLb{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.font = [UIFont systemFontOfSize:16];
        _titleLb.textColor = [UIColor hexString:@"414141"];
        _titleLb.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLb;
}

#pragma mark - 内容
-(UILabel*)contentLb{
    if (!_contentLb) {
        _contentLb = [UILabel new];
        _contentLb.textColor = self.normalTextColor;
        _contentLb.text = self.loadingContentText;
        _contentLb.textAlignment = NSTextAlignmentCenter;
        _contentLb.font = [UIFont systemFontOfSize:14];
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}


#pragma mark - 显示
-(void)showInView:(UIView*)view completion:(void(^)())completion{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
    [view addSubview:self];
    self.alpha = 0;
    self.outerContainerView.transform = CGAffineTransformMakeScale(0.1,0.1);
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        MyWeakSelf.outerContainerView.transform = CGAffineTransformMakeScale(1.0,1.0);
        MyWeakSelf.alpha = 1;
    } completion:^(BOOL finished) {
        [MyWeakSelf startQuery];
        if (finished) {
            if (completion) {
                completion();
            }
        }
    }];
}

#pragma mark - 关闭按钮
-(UIButton*)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.hidden = !self.canClose;
        [_closeBtn setImage:[UIImage imageNamed:@"LYSPayResultQueryView.bundle/close"] forState:UIControlStateNormal];
        [_closeBtn setImage:[UIImage imageNamed:@"LYSPayResultQueryView.bundle/close"] forState:UIControlStateHighlighted];
        [_closeBtn setImage:[UIImage imageNamed:@"LYSPayResultQueryView.bundle/close"] forState:UIControlStateSelected];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UIView*)innerContainerView{
    if (!_innerContainerView) {
        _innerContainerView = [UIView new];
        _innerContainerView.backgroundColor = [UIColor whiteColor];
        _innerContainerView.layer.cornerRadius = 5.f;
        _innerContainerView.layer.masksToBounds = YES;
    }
    return _innerContainerView;
}


-(UIView*)outerContainerView{
    if (!_outerContainerView) {
        _outerContainerView = [UIView new];
        _outerContainerView.backgroundColor = [UIColor clearColor];
    }
    return _outerContainerView;
}

#pragma mark - 关闭按钮被点击
-(void)closeBtnClicked:(UIButton*)sender{
    [self dismiss:nil];
}

#pragma mark - 显示
-(void)show:(void(^)())completion{
    [self showInView:nil completion:completion];
}


#pragma mark - 加载按钮
-(LYSLoadingButton*)loadingBtn{
    if (!_loadingBtn) {
        _loadingBtn = [LYSLoadingButton buttonWithType:UIButtonTypeCustom];
        _loadingBtn.disableWhenLoad = YES;
        _loadingBtn.layer.cornerRadius = 8.f;
        _loadingBtn.layer.masksToBounds = YES;
        [_loadingBtn setTitle:self.loadingBtnTitle forState:UIControlStateNormal];
        [_loadingBtn setTitle:self.loadingBtnTitle forState:UIControlStateHighlighted];
        [_loadingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loadingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _loadingBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _loadingBtn.backgroundColor = self.loadBtnBgColor;
        [_loadingBtn addTarget:self action:@selector(loadingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loadingBtn;
}

#pragma mark - 设置加载按钮的标题
-(void)setLoadingBtnTitle:(NSString *)loadingBtnTitle{
    _loadingBtnTitle = loadingBtnTitle;
    [self.loadingBtn setTitle:self.loadingBtnTitle forState:UIControlStateNormal];
    [self.loadingBtn setTitle:self.loadingBtnTitle forState:UIControlStateHighlighted];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.outerContainerView.frame, point)) {
        if(self.dismissTouchOutside){
            [self dismiss:nil];
        }
    }
}

#pragma mark - 开始查询
-(void)startQuery{
    self.closeBtn.hidden = YES;
    self.content = self.loadingContentText;
    self.contentLb.textColor = self.normalTextColor;
    [self.loadingBtn beginLoading];
}

#pragma mark - 停止查询
-(void)stopQuery:(NSString*)tipMsg  loadingBtnTitle:(NSString*)loadingBtnTitle withResult:(BOOL)result LoadingBtnClickBlock:(void(^)(LYSPayResultQueryView * queryView))LoadingBtnClickBlock{
    __weak typeof (self)MyWeakSelf = self;
    self.LoadingBtnClickBlock = LoadingBtnClickBlock;
    [self.loadingBtn endLoading:^{
        MyWeakSelf.closeBtn.hidden = !MyWeakSelf.canClose;
        MyWeakSelf.content = tipMsg;
        MyWeakSelf.loadingBtnTitle = loadingBtnTitle;
        MyWeakSelf.contentLb.textColor = result ? MyWeakSelf.succTextColor : MyWeakSelf.failTextColor;
    }];
}


#pragma mark - 加载按钮被点击
-(void)loadingBtnClicked:(UIButton*)sender{
    if (self.LoadingBtnClickBlock) {
        self.LoadingBtnClickBlock(self);
    }
}

#pragma mark - 关闭
-(void)dismiss:(void(^)())completion{
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:self.duration animations:^{
        MyWeakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [MyWeakSelf removeFromSuperview];
        if (completion) {
            completion();
        }
        if (MyWeakSelf.CloseWinBlock) {
            MyWeakSelf.CloseWinBlock(MyWeakSelf);
        }
    }];
}

@end
