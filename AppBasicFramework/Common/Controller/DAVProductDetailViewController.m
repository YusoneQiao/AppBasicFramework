//
//  DAVProductDetailViewController.m
//  DAV
//
//  Created by Davis.Qiao on 16/3/28.
//  Copyright © 2016年 Davis.Qiao. All rights reserved.
//

#import "DAVProductDetailViewController.h"
#import "DAVCarouselAdView.h"
//#import "DAVShoppingCartViewController.h"
//#import "DAVPaymentOrderViewController.h"
#import "DAVRecordTableViewCell.h"



@interface DAVProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) ENUM_Products_Status_ActionType products_Status_ActionType;

@property (nonatomic,strong) UITableView *productDetailTableView;//主页的tableView
@property (nonatomic,strong) UITableView *recordTableView;//显示记录的tableView
@property (nonatomic,strong) DAVCarouselAdView *carouselView;//广告视图
@property (nonatomic,strong) UIView *titleView;//广告视图


@property (nonatomic,strong) UIView *products_Status_OngoingView;//正在进行状态View
@property (nonatomic,strong) UIView *products_Status_AnnouncingView;//揭晓中状态View
@property (nonatomic,strong) UIView *products_Status_AnnouncedView;//已揭晓状态View


@property (nonatomic,strong) UIImageView *progressView_BG;//进度条背景
@property (nonatomic,strong) UIImageView *progressView;//进度条显示

@property (nonatomic,strong) UIView *bottomButtonView;//底部的bottomButtonView
@property (nonatomic,strong) UIView *joinThisView;//底部的bottomButtonView
@property (nonatomic,strong) UIView *joinNextView;//底部的bottomButtonView


@property (nonatomic,assign) NSInteger totalNumber;
@property (nonatomic,assign) NSInteger leftNumber;

@property (nonatomic,assign) BOOL recordViewIsOpen;//是否打开recordTableView

@property (nonatomic,strong) NSMutableArray *sectionHeaderArray_recordTableView;//是否打开



@end

@implementation DAVProductDetailViewController

#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initNavigation];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.carouselView startTimer];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    [self.carouselView stopTimer];
}


#pragma mark - initUI
-(void)initUI{
    self.view.backgroundColor=[UIColor yellowColor];
    [self setTableViewUI];
    [self initButtonViewUI];
}


-(void)initNavigation{
    [self setNaviBarTitle:@"商品详情" image:nil];
}

//tableView页面设置
-(void)setTableViewUI{
    
    self.productDetailTableView = [self setCustomerTableViewWithTableView:self.productDetailTableView];
    NSLog(@"self.productDetailTableView == %f",self.productDetailTableView.contentOffset.y);
    [self.view addSubview:self.productDetailTableView];
    
    self.recordTableView = [self setCustomerTableViewWithTableView:self.recordTableView];
    self.recordTableView.scrollEnabled = NO;

    [self setTableHeaderView:self.productDetailTableView];
}

//重写父类方法，不显示Tabbar
-(UITableView *)setCustomerTableViewWithTableView:(UITableView *)tableView
{
    UITableView *cusTomerView;
    if ([tableView isEqual:self.productDetailTableView]) {
        cusTomerView=[[UITableView alloc]initWithFrame:[self.view visibleBoundsShowNav:YES showTabBar:NO] style:UITableViewStylePlain];
    }else{
        cusTomerView=[[UITableView alloc]initWithFrame:[self.view visibleBoundsShowNav:YES showTabBar:NO] style:UITableViewStylePlain];
    }
    cusTomerView.delegate=self;
    cusTomerView.dataSource=self;
    cusTomerView.backgroundColor = DAV_BACKGROUND_COLOR;
    cusTomerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cusTomerView.showsVerticalScrollIndicator=NO;
    cusTomerView.showsHorizontalScrollIndicator=NO;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DAV_SCREEN_WIDTH, self.bottomButtonView.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    [cusTomerView setTableFooterView:view];
    return cusTomerView;
}





//设置表头视图
-(void)setTableHeaderView:(UITableView *)tableView{
    
    UIView * selectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DAV_SCREEN_WIDTH, 0)];
    //添加广告视图
    [self initCarouselAdViewWithView:selectionView];

    //状态View
    UIView *statusView = [[UIView alloc]init];
    float noticeLabelHeight = 0;
    CGRect prizeWinnerIdentifierFrame = CGRectZero;
    //不同商品状态，区分不同的statusView
    switch (self.products_Status_ActionType) {
        case ENUM_Products_Status_Ongoing:
            statusView = self.products_Status_OngoingView;
            noticeLabelHeight = 60;
            self.bottomButtonView = self.joinThisView;
            break;
        case ENUM_Products_Status_Announcing:
            statusView = self.products_Status_AnnouncingView;
            noticeLabelHeight = 40;
            self.bottomButtonView = self.joinNextView;
            break;
        case ENUM_Products_Status_Announced:
            statusView = self.products_Status_AnnouncedView;
            noticeLabelHeight = 40;
            self.bottomButtonView = self.joinNextView;
            prizeWinnerIdentifierFrame = CGRectMake(self.titleView.frame.origin.x - 2, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10 - 2, 40, 40);
            break;
        default:
            break;
    }

    //添加TitleView
    [selectionView addSubview:self.titleView];
    //添加状态View
    [selectionView addSubview:statusView];
    
    //已揭晓页面会有获奖者标识，别的页面frame为0
    UIImageView *prizeWinnerIdentifierIV = [[UIImageView alloc]initWithFrame:prizeWinnerIdentifierFrame];
    prizeWinnerIdentifierIV.image = [UIImage imageNamed:@"productDetail_prizeWinnerIdentifier.png"];
    [selectionView addSubview:prizeWinnerIdentifierIV];

    
    UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(statusView.frame.origin.x, statusView.frame.origin.y+  statusView.frame.size.height + 10, statusView.frame.size.width , noticeLabelHeight)];
    noticeLabel.backgroundColor = [UIColor whiteColor];
    noticeLabel.text = @"你还没有参与本期商品哦！";
    noticeLabel.font = [UIFont systemFontOfSize:12.0];
    noticeLabel.textColor = DAV_COLOR_16(909090);
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    [selectionView addSubview:noticeLabel];
    
    //确定表头视图高度
    [selectionView setFrame:CGRectMake(0, 0, DAV_SCREEN_WIDTH, noticeLabel.frame.origin.y+  noticeLabel.frame.size.height)];
    self.productDetailTableView.tableHeaderView = selectionView;
}

//设置标题页面
-(void)initStatusTitleViewWithStatusString:(NSString *)statusString{
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(10, self.carouselView.frame.origin.y + self.carouselView.frame.size.height + 20, DAV_SCREEN_WIDTH - 20, 30)];
    //进行中等等标签
    UIButton *identifierButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 3, 60, 24)];
    [identifierButton setBackgroundImage:[UIImage imageNamed:@"productDetail_identifierButton.png"] forState:UIControlStateNormal];
    [identifierButton setTitle:statusString forState:UIControlStateNormal];
    identifierButton.titleLabel.font = [UIFont fontWithName:@"微软雅黑" size:14.0];
    [identifierButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleView addSubview:identifierButton];
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(identifierButton.frame.origin.x + identifierButton.frame.size.width + 10, 0, _titleView.frame.size.width - identifierButton.frame.origin.x - identifierButton.frame.size.width - 10, 30)];
    titleLabel.text = @"Apple MacBook Pro 15.4英寸笔记本电脑";
    titleLabel.font = [UIFont systemFontOfSize: 14.0];
    titleLabel.textColor = DAV_COLOR_16(323232);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:titleLabel];

}




-(void)initCarouselAdViewWithView:(UIView *)selectionView{//广告视图
    
    /*
     //可以为网络图片，也可以为本地图片
     1、 本地图片
     NSArray *arr1 = @[[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"2.jpg"], [UIImage imageNamed:@"3.jpg"]];
     2、网络图片
     NSArray *arr2 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg"];
     3、既有本地图片也有网络图片
     NSArray *arr3 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", [UIImage imageNamed:@"2.jpg"], [UIImage imageNamed:@"1.jpg"]];
     */
    NSString *ad_1_path = [[NSBundle mainBundle] pathForResource:@"ad_1" ofType:@"png"];
    NSString *ad_2_path = [[NSBundle mainBundle] pathForResource:@"ad_2" ofType:@"png"];
    NSString *ad_3_path = [[NSBundle mainBundle] pathForResource:@"ad_3" ofType:@"png"];
    NSString *ad_4_path = [[NSBundle mainBundle] pathForResource:@"ad_4" ofType:@"png"];
    
    NSArray *arr3 = @[[UIImage imageWithContentsOfFile:ad_1_path],[UIImage imageWithContentsOfFile:ad_2_path],[UIImage imageWithContentsOfFile:ad_3_path],[UIImage imageWithContentsOfFile:ad_4_path],];
    //    NSArray *describeArray = @[@"这是第一张图片的描述", @"这是第二张图片的描述", @"这是第三张图片的描述", @"这是第四张图片的描述"];
    self.carouselView = [DAVCarouselAdView carouselViewWithImageArray:arr3 describeArray:nil];
    self.carouselView.imageClickBlock = ^(NSInteger index) {
        NSLog(@"第%ld张图片被点击", index);
    };
    self.carouselView.frame = CGRectMake((DAV_SCREEN_WIDTH - 150)/2, 15, 150, 150);
    CGRect pageControlFrame = self.carouselView.pageControl.frame;
    self.carouselView.pageControl.frame = CGRectMake(pageControlFrame.origin.x, pageControlFrame.origin.y + 20, pageControlFrame.size.width, pageControlFrame.size.height);
    [selectionView addSubview:self.carouselView];
    
}






//设置下边加入购物车按钮
-(void)initButtonViewUI{
    [self.view insertSubview:self.bottomButtonView aboveSubview:self.productDetailTableView];
}




#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger numberOfSections = 0;
    if ([tableView isEqual:self.productDetailTableView]) {
        numberOfSections = 2;
    }else if ([tableView isEqual:self.recordTableView]){
       numberOfSections = self.sectionHeaderArray_recordTableView.count;
    }
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRowsInSection = 0;
    if ([tableView isEqual:self.productDetailTableView]) {
        
        if (section == 0) {
            numberOfRowsInSection = 3;
        }else if (section == 1){
            numberOfRowsInSection = 1;
        }else{
        }
       
    }else if ([tableView isEqual:self.recordTableView]){
        numberOfRowsInSection = 5;
    }
     return numberOfRowsInSection;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if ([tableView isEqual:self.productDetailTableView]) {
        if (indexPath.section == 0) {
            //cell左侧内容
            if (indexPath.row ==0) {
                NSString *detailString = [NSString stringWithFormat:@"图文详情（建议wifi下查看）"];
                NSMutableAttributedString *attributedDetailString = [[NSMutableAttributedString alloc]initWithString:detailString];
                [attributedDetailString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(323232) range:NSMakeRange(0, 4)];
                [attributedDetailString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(909090) range:NSMakeRange(4, attributedDetailString.length - 4)];
                cell.textLabel.attributedText = attributedDetailString;
            }else if (indexPath.row ==1){
                cell.textLabel.text = @"往期揭晓";
            }else if (indexPath.row ==2){
                cell.textLabel.text = @"晒单分享";
            }
            //cell详细内容
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.section == 1){
            //cell左侧内容
            NSString *timeString = @"（自2015-12-09 15:03:30开始）";
            NSString *recordString = [NSString stringWithFormat:@"所有参与记录%@", timeString];
            NSMutableAttributedString *attributedRecordString = [[NSMutableAttributedString alloc]initWithString:recordString];
            [attributedRecordString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(323232) range:NSMakeRange(0, 6)];
            [attributedRecordString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(909090) range:NSMakeRange(6, attributedRecordString.length - 6)];
            cell.textLabel.attributedText = attributedRecordString;
            //cell详细内容
            UIButton *moreRecordButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
            [moreRecordButton setBackgroundImage:[UIImage imageNamed:@"productDetail_moreRecord.png"] forState:UIControlStateNormal];
            cell.accessoryView= moreRecordButton;
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell = [self addLineViewTotableViewCell:cell tableView:self.productDetailTableView];

    }else if ([tableView isEqual:self.recordTableView]){
        static NSString *recordTableViewCell = @"recordTableViewCell";
        DAVRecordTableViewCell *recordCell = [tableView dequeueReusableCellWithIdentifier:recordTableViewCell];
        if (!recordCell) {
            [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DAVRecordTableViewCell class]) bundle:nil] forCellReuseIdentifier:recordTableViewCell];
            recordCell = [tableView dequeueReusableCellWithIdentifier:recordTableViewCell];
        }
        
        cell = recordCell;
    }
      return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {

        if (indexPath.row ==0) {//图文详情页面
           
            
        }else if (indexPath.row ==1){//往期揭晓

            
        }else if (indexPath.row ==2){//晒单分享

            
        }

    }else if (indexPath.section == 1){//往期参与记录，下来出来
        if (self.recordViewIsOpen) {
            [self closeRecordView];
            self.recordViewIsOpen = NO;
        }else{
            [self showRecordView];
            self.recordViewIsOpen = YES;
        }
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float heightForRow = 0;
    if ([tableView isEqual:self.productDetailTableView]) {
        self.productDetailTableView.rowHeight = 45;
        heightForRow =self.productDetailTableView.rowHeight;
    }else{
        self.recordTableView.rowHeight = 60;
        heightForRow =self.recordTableView.rowHeight;
    }
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSInteger heightForHeaderInSection = 0;
    if ([tableView isEqual:self.productDetailTableView]) {
        heightForHeaderInSection = 20;
    }else if ([tableView isEqual:self.recordTableView]){
        heightForHeaderInSection = 40;
    }
    return heightForHeaderInSection;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    if ([tableView isEqual:self.recordTableView]) {

        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DAV_SCREEN_WIDTH, 40)];
        //日期标签
        UIButton *dateButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10,90 , 30)];
        [dateButton setTitle:self.sectionHeaderArray_recordTableView[section] forState:UIControlStateNormal];
        [dateButton setTitleColor:DAV_COLOR_16(909090) forState:UIControlStateNormal];
        dateButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [dateButton setBackgroundImage:[UIImage imageNamed:@"productDetail_dateButton.png"] forState:UIControlStateNormal];
        
        [headerView addSubview:dateButton];
        //分隔线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(59.5, 0, 1.0, 40)];
        lineView.backgroundColor = DAV_COLOR_16(909090);
        [headerView insertSubview:lineView belowSubview:dateButton];
        
        
        view = headerView;
    }
    return view;
}





-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.productDetailTableView]) {
        //设置进度条
        float distance = ((float)self.leftNumber/self.totalNumber)* self.progressView_BG.frame.size.width;
        CGRect progressViewFrame = CGRectMake( - distance, 0, self.progressView_BG.frame.size.width, self.progressView_BG.frame.size.height);
        
        //关闭动画
//        CGRect progressViewStartTimeFrame = CGRectMake( - self.progressView_BG.frame.size.width, 0, self.progressView_BG.frame.size.width, self.progressView_BG.frame.size.height);
        
//        [UIView animateWithDuration:0.0 animations:^{
//            [self.progressView setFrame:progressViewStartTimeFrame];
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:1.0 animations:^{
                [self.progressView setFrame:progressViewFrame];
//            }];
//        }];
    }else{
        [self initTableViewCell:(DAVRecordTableViewCell *)cell WithIndexPath:indexPath];
        cell.backgroundColor = self.recordTableView.backgroundColor;
//        cell = (DAVRecordTableViewCell *)[self addLineViewTotableViewCell:cell tableView:self.recordTableView];//不需要添加分隔线，因为颜色都是背景色
    }
}

//设置cell
-(void)initTableViewCell:(DAVRecordTableViewCell *)cell WithIndexPath:(NSIndexPath *)indexPath
{
    [cell.iconImageView setImage:[UIImage imageNamed:@"4.png"]];
    
    NSString *neckString = @"折翼天使不是你";
    NSString *IPString = @"（广东省深圳市）";
    NSMutableAttributedString *attributedNeckLabelString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@==%ld",neckString,IPString,indexPath.row]];
    [attributedNeckLabelString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(0036FF) range:NSMakeRange(0, [neckString length])];
    cell.neckLabel.attributedText = attributedNeckLabelString;
    
    NSInteger countNumber = 3343523;
    NSString *countString = [NSString stringWithFormat:@"参与了%ld人次",countNumber];
    NSString *timeString = @"  2015-12-09 15:03:30";
    NSMutableAttributedString *attributedTimeLabelString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",countString,timeString]];
    [attributedTimeLabelString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(FF3939) range:NSMakeRange(3, [countString length] - 5)];
    cell.timeLabel.attributedText = attributedTimeLabelString;
}
#pragma mark - 私有方法
//给cell添加横线
-(UITableViewCell *)addLineViewTotableViewCell:(UITableViewCell *)cell tableView:(UITableView *)tableView
{
    float rowHeight = 0;
    if ([tableView isEqual:self.productDetailTableView]) {
        rowHeight = self.productDetailTableView.rowHeight - 1;
    }else{
        rowHeight = self.recordTableView.rowHeight - 1;
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, rowHeight, DAV_SCREEN_WIDTH, 1)];
    lineView.backgroundColor = self.productDetailTableView.backgroundColor;
    [cell.contentView insertSubview:lineView atIndex:0];
    return cell;
}

#pragma mark - 懒加载

//正在进行View
-(UIView *)products_Status_OngoingView{
    if (!_products_Status_OngoingView) {
        
        [self initStatusTitleViewWithStatusString:@"进行中"];
        _products_Status_OngoingView = [[UIView alloc]initWithFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, DAV_SCREEN_WIDTH - 20, 0)];
        
        //期号
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , _products_Status_OngoingView.frame.size.width, 20)];
        numberLabel.text = @"期号：100002311";
        numberLabel.font = [UIFont systemFontOfSize:12.0];
        numberLabel.textColor = DAV_COLOR_16(909090);
        numberLabel.textAlignment = NSTextAlignmentLeft;
        [_products_Status_OngoingView addSubview:numberLabel];
        
        //进度条
        self.progressView_BG = [[UIImageView alloc]initWithFrame:CGRectMake(numberLabel.frame.origin.x, numberLabel.frame.origin.y + numberLabel.frame.size.height + 5, numberLabel.frame.size.width, 10)];
        [self.progressView_BG setImage:[UIImage imageNamed:@"home_progressView_BG.png"]];
        self.progressView_BG.layer.masksToBounds = YES;
        self.progressView_BG.layer.cornerRadius = 5;
        self.progressView = [[UIImageView alloc]initWithFrame:self.progressView_BG.bounds];
        self.progressView.image = [UIImage imageNamed:@"home_progressView.png"];
        self.progressView.layer.masksToBounds = YES;
        self.progressView.layer.cornerRadius = 5;
        [self.progressView_BG addSubview:self.progressView];
        
        [_products_Status_OngoingView addSubview:self.progressView_BG];
        
        //总需人数
        UILabel *totalNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.progressView_BG.frame.origin.x, self.progressView_BG.frame.origin.y+  self.progressView_BG.frame.size.height + 5, self.progressView_BG.frame.size.width * 3 / 5, 20)];
        totalNumberLabel.text = [NSString stringWithFormat:@"总需人次：%ld",self.totalNumber];
        totalNumberLabel.font = [UIFont systemFontOfSize:12.0];
        totalNumberLabel.textColor = DAV_COLOR_16(323232);
        totalNumberLabel.textAlignment = NSTextAlignmentLeft;
        [_products_Status_OngoingView addSubview:totalNumberLabel];
        
        //剩余人数
        UILabel *leftNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(totalNumberLabel.frame.origin.x + totalNumberLabel.frame.size.width, totalNumberLabel.frame.origin.y, self.progressView_BG.frame.size.width * 2 / 5, totalNumberLabel.frame.size.height)];
        NSString *leftString = [NSString stringWithFormat:@"剩余%ld",self.leftNumber];
        NSMutableAttributedString *attributedLeftString = [[NSMutableAttributedString alloc]initWithString:leftString];
        [attributedLeftString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(909090) range:NSMakeRange(0, 2)];
        [attributedLeftString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(FF1F1F) range:NSMakeRange(2, attributedLeftString.length - 2)];
        leftNumberLabel.attributedText = attributedLeftString;
        leftNumberLabel.font = [UIFont systemFontOfSize:12.0];
        leftNumberLabel.textAlignment = NSTextAlignmentRight;
        [_products_Status_OngoingView addSubview:leftNumberLabel];

        [_products_Status_OngoingView setFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, DAV_SCREEN_WIDTH - 20, leftNumberLabel.frame.origin.y+  leftNumberLabel.frame.size.height)];
        
    }
    return _products_Status_OngoingView;
}

//揭晓中View
-(UIView *)products_Status_AnnouncingView{
    if (!_products_Status_AnnouncingView) {
        [self initStatusTitleViewWithStatusString:@"揭晓中"];
        _products_Status_AnnouncingView = [[UIView alloc]initWithFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, DAV_SCREEN_WIDTH - 20, 0)];
        _products_Status_AnnouncingView.backgroundColor = DAV_COLOR_16(FF5400);
        
        //期号
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 , _products_Status_AnnouncingView.frame.size.width  - 10 - 120, 20)];
        numberLabel.text = @"期号：100002311";
        numberLabel.font = [UIFont systemFontOfSize:12.0];
        numberLabel.textColor = DAV_COLOR_16(FFFFFF);
        numberLabel.textAlignment = NSTextAlignmentLeft;
        [_products_Status_AnnouncingView addSubview:numberLabel];
    
        //揭晓倒计时的字
        UILabel *countdownLabel = [[UILabel alloc]initWithFrame:CGRectMake(numberLabel.frame.origin.x, numberLabel.frame.origin.y + numberLabel.frame.size.height + 5 , 75, 30)];
        countdownLabel.text = @"揭晓倒计时：";
        countdownLabel.font = [UIFont systemFontOfSize:12.0];
        countdownLabel.textColor = DAV_COLOR_16(FFFFFF);
        countdownLabel.textAlignment = NSTextAlignmentLeft;
        [_products_Status_AnnouncingView addSubview:countdownLabel];
        
        //揭晓倒计时的时间
        UILabel *countdownTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(countdownLabel.frame.origin.x + countdownLabel.frame.size.width, countdownLabel.frame.origin.y , numberLabel.frame.size.width - countdownLabel.frame.size.width, countdownLabel.frame.size.height)];
        countdownTimeLabel.text = @"00:00:30";
        countdownTimeLabel.font = [UIFont systemFontOfSize:22.0];
        countdownTimeLabel.textColor = DAV_COLOR_16(FFFFFF);
        countdownTimeLabel.textAlignment = NSTextAlignmentLeft;
        [_products_Status_AnnouncingView addSubview:countdownTimeLabel];
        

        
        //查看计算详情button
        
        UIButton *calculateButton = [[UIButton alloc]initWithFrame:CGRectMake( _products_Status_AnnouncingView.frame.size.width - 110, 15, 100, 30)];
        
        [calculateButton setTitle:@"查看计算详情" forState:UIControlStateNormal];
        [calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        calculateButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [calculateButton setBackgroundImage:[UIImage imageNamed:@"productDetail_calculateButton.png"] forState:UIControlStateNormal];
        calculateButton.layer.masksToBounds = YES;
        calculateButton.layer.cornerRadius = 5.0;
        [calculateButton addTarget:self action:@selector(calculateAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [_products_Status_AnnouncingView addSubview:calculateButton];
        
        [_products_Status_AnnouncingView setFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, DAV_SCREEN_WIDTH - 20, countdownTimeLabel.frame.origin.y+  countdownTimeLabel.frame.size.height)];
        
    }
    return _products_Status_AnnouncingView;
}

//已经揭晓View
-(UIView *)products_Status_AnnouncedView{
    if (!_products_Status_AnnouncedView) {
        [self initStatusTitleViewWithStatusString:@"已揭晓"];
        _products_Status_AnnouncedView = [[UIView alloc]initWithFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, DAV_SCREEN_WIDTH - 20, 0)];
        
        //获奖者信息
        UIView *prizeWinnerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _products_Status_AnnouncedView.frame.size.width, 115)];
        prizeWinnerView.backgroundColor = [UIColor whiteColor];
        
        //头像
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25,10 , 40, 40)];
        iconImageView.aliCornerRadius = 20;
        iconImageView.image = [UIImage imageNamed:@"3.png"];
        [prizeWinnerView addSubview:iconImageView];
        
        //"获奖者：
        UILabel *prizeWinnerLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width + 10, iconImageView.frame.origin.y , 80, 20)];
        prizeWinnerLabel.text = @"获奖者：";
        prizeWinnerLabel.font = [UIFont systemFontOfSize:12.0];
        prizeWinnerLabel.textColor = DAV_COLOR_16(909090);
        prizeWinnerLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:prizeWinnerLabel];
        
        //用户昵称七个字(IP所在地址)
        UILabel *prizeWinnerNeckLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerLabel.frame.origin.x + prizeWinnerLabel.frame.size.width, prizeWinnerLabel.frame.origin.y , prizeWinnerView.frame.size.width - prizeWinnerLabel.frame.size.width - prizeWinnerLabel.frame.origin.x, prizeWinnerLabel.frame.size.height)];
        NSString *neckString = @"用户昵称七个字";
        NSString *userLocationIP = @"IP所在地址";
        NSString *neckIPString = [NSString stringWithFormat:@"%@（%@）",neckString,userLocationIP];
        NSMutableAttributedString *attributedneckIPString = [[NSMutableAttributedString alloc]initWithString:neckIPString];
        [attributedneckIPString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(0036FF) range:NSMakeRange(0,7)];
        [attributedneckIPString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(909090) range:NSMakeRange(7, attributedneckIPString.length - 7)];
        prizeWinnerNeckLabel.attributedText = attributedneckIPString;
        prizeWinnerNeckLabel.font = [UIFont systemFontOfSize:12.0];
        prizeWinnerNeckLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:prizeWinnerNeckLabel];
        
        //用户ID：
        UILabel *prizeWinnerUserIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerLabel.frame.origin.x, prizeWinnerLabel.frame.origin.y + 20, prizeWinnerLabel.frame.size.width, 20)];
        prizeWinnerUserIDLabel.text = @"用户ID：";
        prizeWinnerUserIDLabel.font = [UIFont systemFontOfSize:12.0];
        prizeWinnerUserIDLabel.textColor = DAV_COLOR_16(909090);
        prizeWinnerUserIDLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:prizeWinnerUserIDLabel];
        
        //1008612（唯一不变标识）
        UILabel *userIDNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerNeckLabel.frame.origin.x , prizeWinnerUserIDLabel.frame.origin.y , prizeWinnerNeckLabel.frame.size.width, prizeWinnerUserIDLabel.frame.size.height)];
        userIDNumberLabel.text = @"1008612（唯一不变标识）";
        userIDNumberLabel.font = [UIFont systemFontOfSize:12.0];
        userIDNumberLabel.textColor = DAV_COLOR_16(909090);
        userIDNumberLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:userIDNumberLabel];
        
        
        //期号：
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerUserIDLabel.frame.origin.x, prizeWinnerUserIDLabel.frame.origin.y + 20, prizeWinnerUserIDLabel.frame.size.width, 20)];
        numberLabel.text = @"期号：";
        numberLabel.font = [UIFont systemFontOfSize:12.0];
        numberLabel.textColor = DAV_COLOR_16(909090);
        numberLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:numberLabel];
        
        //123456789
        UILabel *numberDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerNeckLabel.frame.origin.x , numberLabel.frame.origin.y , prizeWinnerNeckLabel.frame.size.width, numberLabel.frame.size.height)];
        numberDetailLabel.text = @"123456789";
        numberDetailLabel.font = [UIFont systemFontOfSize:12.0];
        numberDetailLabel.textColor = DAV_COLOR_16(909090);
        numberDetailLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:numberDetailLabel];
        
        
        //本期参与：
        UILabel *joinLabel = [[UILabel alloc]initWithFrame:CGRectMake(numberLabel.frame.origin.x, numberLabel.frame.origin.y + 20, numberLabel.frame.size.width, 20)];
        joinLabel.text = @"本期参与：";
        joinLabel.font = [UIFont systemFontOfSize:12.0];
        joinLabel.textColor = DAV_COLOR_16(909090);
        joinLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:joinLabel];
        
        //9人次
        UILabel *joinNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerNeckLabel.frame.origin.x , joinLabel.frame.origin.y , prizeWinnerNeckLabel.frame.size.width, joinLabel.frame.size.height)];
        NSString *numberString = @"9";
        NSString *timesString = @"人次";
        NSString *numberTimesString = [NSString stringWithFormat:@"%@%@",numberString,timesString];
        NSMutableAttributedString *attributedNumberTimesString = [[NSMutableAttributedString alloc]initWithString:numberTimesString];
        [attributedNumberTimesString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(FF3939) range:NSMakeRange(0,attributedNumberTimesString.length - 2)];
        [attributedNumberTimesString addAttribute:NSForegroundColorAttributeName value:DAV_COLOR_16(909090) range:NSMakeRange(attributedNumberTimesString.length - 2, 2)];
        joinNumberLabel.attributedText = attributedNumberTimesString;
        joinNumberLabel.font = [UIFont systemFontOfSize:12.0];
        joinNumberLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:joinNumberLabel];
        
        //揭晓时间：
        UILabel *announceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(joinLabel.frame.origin.x, joinLabel.frame.origin.y + 20, joinLabel.frame.size.width, 20)];
        announceTimeLabel.text = @"揭晓时间：";
        announceTimeLabel.font = [UIFont systemFontOfSize:12.0];
        announceTimeLabel.textColor = DAV_COLOR_16(909090);
        announceTimeLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:announceTimeLabel];
        
        //2015-12-11 11:03:00
        UILabel *announceTimeNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(prizeWinnerNeckLabel.frame.origin.x , announceTimeLabel.frame.origin.y , prizeWinnerNeckLabel.frame.size.width, announceTimeLabel.frame.size.height)];
        announceTimeNumberLabel.text = @"2015-12-11 11:03:00";
        announceTimeNumberLabel.font = [UIFont systemFontOfSize:12.0];
        announceTimeNumberLabel.textColor = DAV_COLOR_16(909090);
        announceTimeNumberLabel.textAlignment = NSTextAlignmentLeft;
        [prizeWinnerView addSubview:announceTimeNumberLabel];
        
        [prizeWinnerView setFrame:CGRectMake(0, 0, _products_Status_AnnouncedView.frame.size.width, announceTimeNumberLabel.frame.origin.y + announceTimeNumberLabel.frame.size.height + 10)];
        [_products_Status_AnnouncedView addSubview:prizeWinnerView];
        
        //获奖幸运号码
        UIView *luckyNumberView = [[UIView alloc]initWithFrame:CGRectMake(0, prizeWinnerView.frame.size.height + prizeWinnerView.frame.origin.y, _products_Status_AnnouncedView.frame.size.width, 50)];
        luckyNumberView.backgroundColor = DAV_COLOR_16(FF5400);
        
        //揭晓倒计时的时间
        UILabel *luckyNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 10 , _products_Status_AnnouncedView.frame.size.width - 110 - 10, 30)];
        luckyNumberLabel.text = @"获奖幸运码：100000003";
        luckyNumberLabel.font = [UIFont systemFontOfSize:14.0];
        luckyNumberLabel.textColor = DAV_COLOR_16(FFFFFF);
        luckyNumberLabel.textAlignment = NSTextAlignmentLeft;
        [luckyNumberView addSubview:luckyNumberLabel];
        
        //查看计算详情button
        UIButton *calculateButton = [[UIButton alloc]initWithFrame:CGRectMake( _products_Status_AnnouncedView.frame.size.width - 110, luckyNumberLabel.frame.origin.y, 100, 30)];
        [calculateButton setTitle:@"查看计算详情" forState:UIControlStateNormal];
        [calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        calculateButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [calculateButton setBackgroundImage:[UIImage imageNamed:@"productDetail_calculateButton.png"] forState:UIControlStateNormal];
        calculateButton.layer.masksToBounds = YES;
        calculateButton.layer.cornerRadius = 5.0;
        [calculateButton addTarget:self action:@selector(calculateAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [luckyNumberView addSubview:calculateButton];
        
        [luckyNumberView setFrame:CGRectMake(0, prizeWinnerView.frame.size.height + prizeWinnerView.frame.origin.y, _products_Status_AnnouncedView.frame.size.width, calculateButton.frame.origin.y + calculateButton.frame.size.height + 10)];
        [_products_Status_AnnouncedView addSubview:luckyNumberView];
        
        [_products_Status_AnnouncedView setFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, DAV_SCREEN_WIDTH - 20, luckyNumberView.frame.origin.y + luckyNumberView.frame.size.height)];
    }
    return _products_Status_AnnouncedView;
}

//正在进行中，加入这一期
-(UIView *)joinThisView{
    if (!_joinThisView) {
        _joinThisView = [[UIView alloc]initWithFrame:CGRectMake(0, DAV_SCREEN_HEIGHT -60, DAV_SCREEN_WIDTH, 60)];
        _joinThisView.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *joinInButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 15,(DAV_SCREEN_WIDTH - 75)/2 , 30)];
        [joinInButton setTitle:@"立即参与" forState:UIControlStateNormal];
        [joinInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        joinInButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [joinInButton setBackgroundImage:[UIImage imageNamed:@"productDetail_joinInButton.png"] forState:UIControlStateNormal];
        joinInButton.layer.masksToBounds = YES;
        joinInButton.layer.cornerRadius = 5.0;
        [joinInButton addTarget:self action:@selector(joinInAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [_joinThisView addSubview:joinInButton];
        
        UIButton *addToCartButton = [[UIButton alloc]initWithFrame:CGRectMake(joinInButton.frame.origin.x + joinInButton.frame.size.width + 5, joinInButton.frame.origin.y,joinInButton.frame.size.width , joinInButton.frame.size.height)];
        [addToCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addToCartButton setTitleColor:DAV_COLOR_16(FF4800) forState:UIControlStateNormal];
        addToCartButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [addToCartButton setBackgroundImage:[UIImage imageNamed:@"productDetail_addToCartButton.png"] forState:UIControlStateNormal];
        addToCartButton.layer.masksToBounds = YES;
        addToCartButton.layer.cornerRadius = 5.0;
        [addToCartButton addTarget:self action:@selector(addToCartAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [_joinThisView addSubview:addToCartButton];
        
        UIButton *cartButton = [[UIButton alloc]initWithFrame:CGRectMake(DAV_SCREEN_WIDTH - 50, 10, 40, 40)];
        [cartButton setImage:[UIImage imageNamed:@"home_cartButton.png"] forState:UIControlStateNormal];
        [cartButton addTarget:self action:@selector(cartButtonAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [_joinThisView addSubview:cartButton];
    }
    return _joinThisView;
}

//正在揭晓中（已揭晓），加入下一期
-(UIView *)joinNextView{
    if (!_joinNextView) {
        _joinNextView = [[UIView alloc]initWithFrame:CGRectMake(0, DAV_SCREEN_HEIGHT -60, DAV_SCREEN_WIDTH, 60)];
        _joinNextView.backgroundColor = [UIColor lightGrayColor];
        
        
        //这一期正在火热进行···
        UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 , 15 , DAV_SCREEN_WIDTH - 110 - 10, 30)];
        noticeLabel.text = @"这一期正在火热进行···";
        noticeLabel.font = [UIFont systemFontOfSize:14.0];
        noticeLabel.textColor = DAV_COLOR_16(333333);
        noticeLabel.textAlignment = NSTextAlignmentLeft;
        [_joinNextView addSubview:noticeLabel];
        
        
        UIButton *joinInButton = [[UIButton alloc]initWithFrame:CGRectMake(DAV_SCREEN_WIDTH - 110, 15,100 , 30)];
        [joinInButton setTitle:@"立即参与" forState:UIControlStateNormal];
        [joinInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        joinInButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [joinInButton setBackgroundImage:[UIImage imageNamed:@"productDetail_joinInButton.png"] forState:UIControlStateNormal];
        joinInButton.layer.masksToBounds = YES;
        joinInButton.layer.cornerRadius = 5.0;
        [joinInButton addTarget:self action:@selector(joinInAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [_joinNextView addSubview:joinInButton];
        
    }
    return _joinNextView;
}

//-(UIView *)bottomButtonView{
//    if (!_bottomButtonView) {
//        _bottomButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, DAV_SCREEN_HEIGHT -60, DAV_SCREEN_WIDTH, 60)];
//        _bottomButtonView.backgroundColor = [UIColor lightGrayColor];
//        
//        UIButton *joinInButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 15,(DAV_SCREEN_WIDTH - 75)/2 , 30)];
//        [joinInButton setTitle:@"立即参与" forState:UIControlStateNormal];
//        [joinInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        joinInButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
//        [joinInButton setBackgroundImage:[UIImage imageNamed:@"productDetail_joinInButton.png"] forState:UIControlStateNormal];
//        joinInButton.layer.masksToBounds = YES;
//        joinInButton.layer.cornerRadius = 5.0;
//        [joinInButton addTarget:self action:@selector(joinInAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomButtonView addSubview:joinInButton];
//        
//        UIButton *addToCartButton = [[UIButton alloc]initWithFrame:CGRectMake(joinInButton.frame.origin.x + joinInButton.frame.size.width + 5, joinInButton.frame.origin.y,joinInButton.frame.size.width , joinInButton.frame.size.height)];
//        [addToCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
//        [addToCartButton setTitleColor:DAV_COLOR_16(FF4800) forState:UIControlStateNormal];
//        addToCartButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
//        [addToCartButton setBackgroundImage:[UIImage imageNamed:@"productDetail_addToCartButton.png"] forState:UIControlStateNormal];
//        addToCartButton.layer.masksToBounds = YES;
//        addToCartButton.layer.cornerRadius = 5.0;
//        [addToCartButton addTarget:self action:@selector(addToCartAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomButtonView addSubview:addToCartButton];
//        
//        UIButton *cartButton = [[UIButton alloc]initWithFrame:CGRectMake(DAV_SCREEN_WIDTH - 50, 10, 40, 40)];
//        [cartButton setImage:[UIImage imageNamed:@"home_cartButton.png"] forState:UIControlStateNormal];
//        [cartButton addTarget:self action:@selector(cartButtonAction_ProductDetailVC) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomButtonView addSubview:cartButton];
//
//    }
//    return _bottomButtonView;
//}
//recordTableView的分区头数据数组
-(NSMutableArray *)sectionHeaderArray_recordTableView{
    if (!_sectionHeaderArray_recordTableView) {
        _sectionHeaderArray_recordTableView = [NSMutableArray arrayWithArray:@[@"2015-12-09",@"2015-12-10",@"2015-12-11"]];
    }
    return _sectionHeaderArray_recordTableView;
}

-(NSInteger)totalNumber{
    if (!_totalNumber) {
        _totalNumber = 9999;
    }
    return _totalNumber;
}

-(NSInteger)leftNumber{
    if (!_leftNumber) {
        _leftNumber = arc4random_uniform((unsigned)self.totalNumber);
    }
    return _leftNumber;
}
#pragma mark - 点击事件

//立即参加
-(void)joinInAction_ProductDetailVC{
//    DAVPaymentOrderViewController *paymentOrderViewController  =[[DAVPaymentOrderViewController alloc]init];
//    [self.navigationController pushViewController:paymentOrderViewController animated:YES];
}

//将商品加入购物车
-(void)addToCartAction_ProductDetailVC{
}

//去购物车页面
-(void)cartButtonAction_ProductDetailVC{
//    DAVShoppingCartViewController *shoppingCartVC= [[DAVShoppingCartViewController alloc]init];
//    shoppingCartVC.isFromOtherVC = YES;
//    [self.navigationController pushViewController:shoppingCartVC animated:YES];
}

//显示记录菜单
-(void)showRecordView{
    self.productDetailTableView.tableFooterView = self.recordTableView;
    self.recordTableView.alpha = 0.1;
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.productDetailTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.recordTableView.alpha = 1.0;
    }];
    
    //变换frame，使显示完全
    CGRect frame = self.recordTableView.frame;
    float recordHeight = self.recordTableView.contentSize.height;
    self.recordTableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, recordHeight );
    self.productDetailTableView.contentSize = CGSizeMake(0, recordHeight + DAV_SCREEN_HEIGHT - 64 - 49 + 10);
}


-(void)closeRecordView{
    //替换掉recordTableView
    [self performSelector:@selector(replaceFooterView) withObject:nil afterDelay:0.5f];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.productDetailTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
        self.recordTableView.alpha = 0.1;
    } completion:^(BOOL finished) {
        self.recordTableView.alpha = 1.0;
    }];
}
//替换掉recordTableView
-(void)replaceFooterView{
    self.productDetailTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DAV_SCREEN_WIDTH, 60)];;
}

//查看计算详情
-(void)calculateAction_ProductDetailVC{
   
}

@end
