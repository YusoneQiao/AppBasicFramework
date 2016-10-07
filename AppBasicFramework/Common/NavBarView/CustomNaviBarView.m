//
// 
//  PPNavTest
//
//  Created by Davis.Qiao on 16/4/6.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "CustomNaviBarView.h"


static const CGFloat TitleSizeNormalMax=19.0f;
static const CGFloat TitleSizeNormalMine=14.0f;

@interface CustomNaviBarView ()

@property (nonatomic, readonly) UIButton *m_btnBack;
//@property (nonatomic, readonly) UILabel *m_labelTitle;
@property (nonatomic, readonly) UIButton *m_btnTitle;

@property (nonatomic, readonly) UIImageView *m_imgViewBg;
@property (nonatomic, readonly) UIButton *m_btnLeft;
@property (nonatomic, readonly) UIButton *m_btnRight;



@end

@implementation CustomNaviBarView

@synthesize m_btnBack = _btnBack;
@synthesize m_btnTitle = _btnTitle;
@synthesize m_imgViewBg = _imgViewBg;
@synthesize m_btnLeft = _btnLeft;
@synthesize m_btnRight = _btnRight;



+ (CGRect)rightBtnFrame
{

    return Rect(DAV_SCREEN_WIDTH-62, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGSize)barBtnSize
{
    return Size(60.0f, 40.0f);
}

+ (CGSize)barSize
{
    return Size(DAV_SCREEN_WIDTH, NAV_BAR_HEIGHT);
}

+ (CGRect)titleViewFrame
{
    return Rect(65.0f, 22.0f, DAV_SCREEN_WIDTH-130, 40.0f);
}

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [btn.titleLabel setFont:[UIFont fontWithName:MicroSoftYaHei size:12]];

    return btn;
}

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight target:(id)target action:(SEL)action
{
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:strImg forState:UIControlStateNormal];
    [btn setImage:(strImgHighlight ? strImgHighlight : strImg) forState:UIControlStateHighlighted];
    
    
    
    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - strImg.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - strImg.size.height)/2.0f;
    
  

    
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight+5, fDeltaWidth, fDeltaHeight, fDeltaWidth-5)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -strImg.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}

+(UIButton *)creatNavNorBack:(UIImage *)strImg imgHighlight:(UIImage *)strImgHighlight
{
    strImg=strImg?:[UIImage imageNamed:@"Nav_back"];
    strImgHighlight=strImgHighlight?:[UIImage imageNamed:@"Nav_back"];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn setImage:strImg forState:UIControlStateNormal];
    [btn setImage:(strImgHighlight ? strImgHighlight : strImg) forState:UIControlStateHighlighted];
    
    
    
    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - strImg.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - strImg.size.height)/2.0f;

    
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth-15, fDeltaHeight, fDeltaWidth+15)];
 
    return btn;
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self initUI];
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)initUI
{
 
//    self.backgroundColor=DAV_COLOR_16(FF4800);
    // 默认左侧显示返回按钮
//    _btnBack = [[self class] createImgNaviBarBtnByImgNormal:[UIImage imageNamed:@"nav_back_normal"] imgHighlight:[UIImage imageNamed:@"nav_back_select"] target:self action:@selector(btnBack:)];

    _btnTitle = [[UIButton alloc] initWithFrame:CGRectZero];
    _btnTitle.backgroundColor = [UIColor clearColor];
    [_btnTitle setTitleColor:DAV_COLOR_16(323232) forState:UIControlStateNormal];
    _btnTitle.titleLabel.font = [UIFont systemFontOfSize:TitleSizeNormalMax];
    _btnTitle.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _imgViewBg = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgViewBg.image = [[UIImage imageNamed:@"NaviBar_Bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _imgViewBg.alpha = 0.98f;
    
  
    _btnTitle.frame = [[self class] titleViewFrame];
    _imgViewBg.frame = self.bounds;
    
    [self addSubview:_imgViewBg];
    [self addSubview:_btnTitle];
    [self addSubview:_lineNaviView];
    [self setLeftBtn:_btnBack];
}

- (void)setTitle:(NSString *)strTitle image:(UIImage *)imageTitle
{
    [_btnTitle setTitle:strTitle forState:UIControlStateNormal];
    _btnTitle.titleLabel.font = FontWithMicrosoft(18.0);
    [_btnTitle setImage:imageTitle forState:UIControlStateNormal];
}







- (void)setLeftBtn:(UIButton *)btn
{
    if (!btn) return;
    
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
        _btnLeft = btn;
        _btnLeft.frame = Rect(2.0f, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
        [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [self addSubview:_btnLeft];

}

- (void)setRightBtn:(UIButton *)btn
{
    if (_btnRight)
    {
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }
    
    _btnRight = btn;
    if (_btnRight)
    {
        _btnRight.frame = [[self class] rightBtnFrame];
        _btnRight.titleLabel.font = Font(14.0);
        [_btnRight setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [self addSubview:_btnRight];
    }else{}
}


- (void)btnBack:(id)sender
{
    if (self.m_viewCtrlParent)
    {
        [self.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
    }
}




#pragma mark - 搜索页面，DAVSearchViewController.h

//搜索页面加载
-(void)setSearchView{
    [self removeAllSubviews];
    [self initUIWithSearchView];
}

//搜索页面视图UI加载
-(void)initUIWithSearchView{
    
//    self.backgroundColor=DAV_COLOR_16(FF4800);

    _btnTitle = [[UIButton alloc] initWithFrame:Rect(40.0f, 32.0f, DAV_SCREEN_WIDTH-50, 22.0f)];
    [_btnTitle setBackgroundColor:[UIColor whiteColor]];
    [_btnTitle setImage:[UIImage imageNamed:@"searchVC_search.png"] forState:UIControlStateNormal];
    [_btnTitle setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, DAV_SCREEN_WIDTH - 90+4)];
    _btnTitle.layer.masksToBounds = YES;
    _btnTitle.layer.cornerRadius = 5.0;
    [_btnTitle addTarget:self action:@selector(searchViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnTitle];
    [self addSubview:_lineNaviView];
    [self setLeftBtn:_btnBack];
}


-(void)searchViewAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SEARCHVIEWCLICKACTION"
                                                        object:nil];
}


-(UIView *)lineNaviView{
    if (!_lineNaviView) {
        _lineNaviView = [[UIView alloc]initWithFrame:Rect(0, 63.5, DAV_SCREEN_WIDTH, 0.5)];
        _lineNaviView.backgroundColor = DAV_COLOR_16(C7C7C7);
    }
    return _lineNaviView;
}

@end
