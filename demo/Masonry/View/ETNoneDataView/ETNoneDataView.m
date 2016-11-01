//
//  ETNoneDataView.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "ETNoneDataView.h"
static NSString *const ErrorMessage = @"数据获取失败\n请检查网络连接是否正常";

static NSString *const ErrorAction = @"重新加载";

@interface ETNoneDataView(){
       ViewType _viewType;         /**< 视图类型 */
       UIView *_superView;         /**< 父视图 */
}
@property (nonatomic, strong) UIButton *actionButton;      /**< 按钮 */
@property (nonatomic, strong) UIImageView *imageView;    /**< 图片 */
@property (nonatomic, strong) UILabel *label;            /**< 文字 */
@end

@implementation ETNoneDataView
- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _actionButton.backgroundColor = hexColor(FF6600);
        [_actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchDown];
        _actionButton.layer.cornerRadius = 5;
    }
    return _actionButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = systemFont(14);
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
    }
    return _label;
}
- (instancetype)initWithViewType:(ViewType)viewType errorParameters:(id)parameters error:(NSError *)error target:(id)target{
    if (self = [super init]) {
        
        _delegate = target;
        _viewType = viewType;
        
      [self superViewType];//判断父视图类型，加载视图
      [self creatUIWithParameters:parameters errorMessage:error];//更新视图内容
   
        
        
    }
    return self;
}

- (void)superViewType{
    //判断父视图类型
    if ([_delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)_delegate;
        _superView = vc.view;
    }
    
    self.frame = CGRectMake(0, 0, _superView.bounds.size.width, _superView.bounds.size.height);
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self addSubview:self.actionButton];
   
}

//更新视图内容
- (void)creatUIWithParameters:(id)parameters errorMessage:(NSError *)errorMessage {
    
   //网络错误
    if (_viewType == NetWorkError) {
        [self setNetWorkErrorUIWithParameters:parameters errorMessage:errorMessage];
    }
}

// 设置网络错误视图
- (void)setNetWorkErrorUIWithParameters:(id)parameters errorMessage:(NSError *)errorMessage {
    
    
    _imageView.image = [UIImage imageNamed:@"System_NetworkError"];
    _label.textColor = hexColor(797979);
    [_actionButton setBackgroundColor:hexColor(FAFAFA)];
    [_actionButton setTitleColor:hexColor(797979) forState:UIControlStateNormal];
    _actionButton.layer.borderColor = hexColor(797979).CGColor;
    _actionButton.layer.borderWidth = 0.5f;
    _label.text = [self networkErrorMessageWithParameters:parameters errorMessage:errorMessage];
    [_actionButton setTitle:[self actionButtonTitleMessage] forState:UIControlStateNormal];
}
// 网络错误判断
- (NSString *)networkErrorMessageWithParameters:(id)parameters errorMessage:(NSError *)errorMessage {
    
  
    /*
     当 parameters 为空时，证明没有连接到数据库
     先判断是否连接到数据库
     */
    if ([parameters isKindOfClass:[NSDictionary class]]) {
    
    }else{
     //网络异常
        if ([[errorMessage.userInfo allKeys] containsObject:@"NSLocalizedDescription"]) {
            
            if ([errorMessage.userInfo[@"NSLocalizedDescription"] isEqualToString:@"The operation timed out."]) {
                return @"连接超时,请重试";
            }else{
                return ErrorMessage;
            }
        }else{
                return ErrorMessage;
        }
    }
    
    
    
    return ErrorMessage;
}

//按钮显示的文字
- (NSString *)actionButtonTitleMessage {
   
      return ErrorAction;
}

- (void)show{
  
     [_superView addSubview:self];
}

- (void)actionButtonClicked:(UIButton *)sender{
    
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(ETNoneDataViewDelegate)]){
        [self removeFromSuperview];
        [self.delegate BtnClickAction];
    }
    
}

// 控件布局
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak ETNoneDataView *__weakSelf = self;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(__weakSelf.mas_centerX);
        make.width.equalTo(@(100));
        make.height.equalTo(@(100));
        make.top.equalTo(@(AUTO_MATE_HEIGHT(100)));
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(__weakSelf);
        make.top.equalTo(_imageView.mas_bottom).offset(20);
        make.centerX.equalTo(__weakSelf.mas_centerX);
    }];
    [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(AUTO_MATE_WIDTH(150)));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(30)));
        make.top.equalTo(_label.mas_bottom).offset(25);
        make.centerX.equalTo(__weakSelf.mas_centerX);
    }];
}

@end
