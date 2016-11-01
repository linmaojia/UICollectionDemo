//
//  ETCollectBrandHeaderView.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/6.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "ETHotHeadView.h"
#import <HYBLoopScrollView.h>
#import "HMSegmentedControl.h"
@interface ETHotHeadView()

@property (nonatomic, weak) HYBLoopScrollView *loop;   /**< 广告轮播图 */
@property (nonatomic, strong) NSMutableArray *imagesArray;   /**< 图片数组 */
@property (nonatomic, strong) UIView *centerView;   /**< 中间类型部分视图 */
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;//第三方    /**< 分段控制器 */
@property (nonatomic, strong) NSArray *centerArray;   /**< 中间视图的更换数组 */
@end

@implementation ETHotHeadView
#pragma mark 懒加载控件
- (NSMutableArray *)imagesArray
{
    if(!_imagesArray)
    {
        _imagesArray = [NSMutableArray new];
    }
    return _imagesArray;
}
- (NSArray *)centerArray
{
    if(!_centerArray)
    {
        _centerArray = [NSMutableArray new];
    }
    return _centerArray;
}
- (UIView *)centerView
{
    if(!_centerView)
    {
        _centerView = [[UIView alloc]init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.borderWidth = 1;
        _centerView.layer.borderColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1.0].CGColor;
    }
    return _centerView;
}
- (HYBLoopScrollView *)loop
{
    
    
    if(!_loop)
    {
        _loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectZero imageUrls:nil timeInterval:5 didSelect:^(NSInteger atIndex) {
            
            NSLog(@"---%ld",atIndex);
        } didScroll:^(NSInteger toIndex) {
            NSLog(@"--xxxx-%ld",toIndex);//切换页面时调用
        }];
        _loop.placeholder = [UIImage imageNamed:@"StartDefult"];
        _loop.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"diamond_upholstery"]];
        _loop.alignment = kPageControlAlignCenter;
        _loop.pageControl.currentPageIndicatorTintColor = mainColor;
        _loop.imageContentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _loop;
}
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"类型",@"空间",@"风格",@"最热"]];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.verticalDividerEnabled = YES;
        _segmentedControl.verticalDividerColor = RGB(238, 238, 238);
        _segmentedControl.verticalDividerWidth = 1.f;
        [_segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = nil;
            if (selected) {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
            } else {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}];
            }
            return attString;
        }];
        [_segmentedControl addTarget:self action:@selector(segmentedControlIndexChange:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.hidden = YES;
    }
    return _segmentedControl;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
       [self addSubview:self.loop];
       [self addSubview:self.segmentedControl];
       [self addSubview:self.centerView];
       
        
    }
    return self;
}

- (void)setModel:(ETBuyHomeModel *)model{
    _segmentedControl.hidden = NO;
    _model = model;
    NSMutableArray *imgArray = [NSMutableArray array];
    for(Bannders *bannder in model.bannders){
        
        [imgArray addObject:[bannder.picUri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSLog(@"----%@",self.imagesArray);
    self.loop.imageUrls = imgArray;
    _segmentedControl.selectedSegmentIndex = 0;
    
    [self greateView:_model.dict.types];//创建类型视图
    
    
}

- (void)greateView:(NSArray *)array{
    
    for(UIView *view in self.centerView.subviews){
        [view removeFromSuperview];
    }
    
    self.centerArray = array;
    
    CGFloat btn_h = AUTO_MATE_WIDTH(45);//按钮宽高
    CGFloat spaceLeft = 20;//距离左边的距离
    CGFloat spacetop = 5;//距离上边距的距离
    CGFloat lab_h = 15;//文字的高度
    CGFloat space = (SCREEN_WIDTH - spaceLeft*2 - btn_h *4)/3;//按钮之间的空隙
    /*
     计算centerView 的高度
     */
//    CGFloat heights = AUTO_MATE_WIDTH(45)*2+30+10
    NSInteger index = 0;
    for(int j = 0;j<2;j++){
        NSInteger count = 4;
        if(j == 1){
            count = array.count - count;
        }
        
     for(int i=0;i<count;i++){
        Types *types = array[index];
        NSURL *imgUrl = [NSURL URLWithString:[types.picUri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(spaceLeft+i*(space+btn_h), spacetop+j*(btn_h+lab_h+spacetop), btn_h, btn_h)];
        [imageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"Default_Image"]];
        imageView.layer.cornerRadius = btn_h*0.5;
        imageView.layer.masksToBounds = YES;
         imageView.tag = 100+index;
         imageView.userInteractionEnabled = YES;
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClickAction:)];
         [imageView addGestureRecognizer:tap];
         
        [self.centerView addSubview:imageView];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(spaceLeft+i*(space+btn_h), btn_h+spacetop+j*(btn_h+lab_h+spacetop), btn_h, lab_h)];
        lab.text = types.name;
//         lab.backgroundColor = [UIColor grayColor];
        lab.font = systemFont(12);
        lab.textAlignment = NSTextAlignmentCenter;
        [self.centerView addSubview:lab];
         index++;
        
         
        
//        NSString *imgUrl = [types.picUri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(i*(space+btn_h), 5, btn_h, btn_h);
//        [button setImage:[UIImage imageNamed:imgUrl] forState:0];
//        button.layer.cornerRadius = btn_h*0.5;
//        button.layer.masksToBounds = YES;
//        button.tag=100+i;
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.centerView addSubview:button];
        
    }
        }

}

- (void)imgClickAction:(UITapGestureRecognizer *)sender{
    NSInteger index = (long)sender.view.tag;
    Types *type = self.centerArray[index-100];
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(ETHotHeadViewDelegete)]){
        [self.delegate imgClickWithDcid:type.dcId];
    }
    
   // NSLog(@"---%@",self.centerArray[index - 100]);
}

#pragma mark - 分栏控制器选择方法
- (void)segmentedControlIndexChange:(HMSegmentedControl *)seg{
    
    for(UIView *view in self.centerView.subviews){
        [view removeFromSuperview];
    }
    
    switch (seg.selectedSegmentIndex) {
        case 0:
             [self greateView:_model.dict.types];
            break;
        case 1:
            [self greateView:_model.dict.spaces];
            break;
        case 2:
            [self greateView:_model.dict.styles];
            break;
        case 3:
            [self greateView:_model.dict.hot];
            break;
        default:
            break;
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
       [_loop mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.top.left.equalTo(self);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(100)));
    }];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loop.bottom);
        make.right.left.equalTo(self);
        make.height.equalTo(@(40));
    }];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.bottom);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.height.equalTo(@(AUTO_MATE_WIDTH(45)*2+30+15));
    }];
}

@end
