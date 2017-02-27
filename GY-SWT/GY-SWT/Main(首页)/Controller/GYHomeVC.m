//
//  GYHomeVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYHomeVC.h"
#import "CZZCarouselView.h"
#import "MXConstant.h"
#import "CustomerScrollView.h"
#import "UIView+WJExtension.h"
#import "GYHomeCell.h"
#import "GYLoginVC.h"
#import "GYNoticePublicVC.h"
#import "GYCourtDetailMainVC.h"
#import "GYSearchCaseLoginVC.h"
#import "GYPeopleContactVC.h"
#import "GYPTMainVC.h"
#import "GYCourtListModel.h"
#import "GYHttpTool.h"
#import "GYTop2NewsModel.h"
#import "TopMenuSelectViewController.h"
#import "GYNewsNoDetailVC.h"
#import "GYNewsRealDetailVC.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define ViewH 210

#define carouselViewHeight (kScreenIphone5 == 0)? 150: 180
#define labelTopConstraintHeight (kScreenIphone5 == 0)? 220: 250
#define ViewH (kScreenIphone5 == 0)? 185: 210



static NSString *ID=@"homeCell";


@interface GYHomeVC ()<CZZCarouselViewDelegate,UIScrollViewDelegate,scrollViewButtonDelegate>
@property (nonatomic,strong)CZZCarouselView *carouselView;
@property (nonatomic,strong) CustomerScrollView * btnScrollView;
@property (nonatomic,strong) NSArray * dataArr;

@property (strong, nonatomic) IBOutlet UIView *myFunKeboardView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIView *homeDetailView;
@property (strong, nonatomic) IBOutlet UIView *courtView;
@property (strong, nonatomic) IBOutlet UIButton *courtViewBackBtn;

@property (nonatomic, strong) NSMutableArray *courtListArr;
@property (nonatomic, strong) NSMutableArray *courtNameArr;

@property (nonatomic, strong) NSMutableArray *top2NewsArr;
@property (nonatomic, copy) NSString *imageFileUrl;

@property (nonatomic, strong) NSMutableArray *lunboNewsArr;
@property (nonatomic, copy) NSString *lunboImageFileUrl;
@property (nonatomic, strong) NSMutableArray *lunboTitleArr;
@property (nonatomic, strong) NSMutableArray *lunboImageArr;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *funKeyBoardConstraint;


@end

@implementation GYHomeVC

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    if (courtDm) {
        self.mxNavigationBar.hidden = NO;
        self.courtView.hidden = YES;
        self.homeDetailView.hidden = NO;
        self.courtViewBackBtn.hidden = NO;
    } else {
        self.courtView.hidden = NO;
        self.homeDetailView.hidden = YES;
        self.mxNavigationBar.hidden = YES;
        self.courtViewBackBtn.hidden = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCourtData];

    self.labelTopConstraint.constant = labelTopConstraintHeight;
    self.funKeyBoardConstraint.constant = ViewH;
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"%@",homeDir);
    
    self.mxNavigationItem.title = @"贵阳中院法院自助服务";
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYHomeCell" bundle:nil] forCellReuseIdentifier:ID];
    self.myTableView.bounces = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *titleImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [titleImage setContentMode:UIViewContentModeScaleToFill];
    titleImage.frame = CGRectMake(70, 32, 20, 20);
    self.mxNavigationItem.titleView = titleImage;
    
    [self loadLunBoNewsInfo];
    [self.myFunKeboardView addSubview:self.btnScrollView];
    [self loadTop2NewsInfo];
}


- (void)loadTop2NewsInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [GYHttpTool post:news_top2InfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"news==%@",json);
        NSArray *arr = [GYTop2NewsModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYTop2NewsModel *top2NewsModel in arr) {
            [self.top2NewsArr addObject:top2NewsModel];
        }
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.imageFileUrl = loginModel.imageServiceUrl;
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadLunBoNewsInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [GYHttpTool post:news_tjInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"newstj==%@",json);
        NSArray *arr = [GYTop2NewsModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.lunboImageFileUrl = loginModel.imageServiceUrl;
        for (GYTop2NewsModel *top2NewsModel in arr) {
            [self.lunboNewsArr addObject:top2NewsModel];
            [self.lunboTitleArr addObject:top2NewsModel.title];
            [self.lunboImageArr addObject:[NSString stringWithFormat:@"%@%@",self.lunboImageFileUrl,top2NewsModel.imageurl]];
        }
        [self loadLunboViewWithTitleArr:self.lunboTitleArr AndImageArr:self.lunboImageArr];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadLunboViewWithTitleArr:(NSArray *)titleArr AndImageArr:(NSArray *)imageArr {
    //  混合图片
    NSArray *maxImageArray = imageArr;
    //  图片描述数组
    NSArray *describleArray = titleArr;
    self.carouselView = [CZZCarouselView carouselViewWithImageArray:maxImageArray describeArray:describleArray];
    //  设置frame
    self.carouselView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, carouselViewHeight);
    //  用block处理图片点击
    __weak GYHomeVC *weakSelf = self;
    self.carouselView.imageClickBlock = ^(NSInteger index){
        NSLog(@"点击了第%ld张图片",index);
        
        GYTop2NewsModel *top2NewsModel = weakSelf.lunboNewsArr[index];
        if (top2NewsModel.newstype == 1) {
            GYNewsRealDetailVC *newsRealDetailVC = [[GYNewsRealDetailVC alloc]init];
            newsRealDetailVC.newsDetail = top2NewsModel;
            newsRealDetailVC.myTitle = @"法院新闻";
            [weakSelf.navigationController pushViewController:newsRealDetailVC animated:YES];
        }
        if (top2NewsModel.newstype == 3) {
            GYNewsNoDetailVC *noDetailVC = [[GYNewsNoDetailVC alloc]init];
            noDetailVC.newsDetail = top2NewsModel;
            noDetailVC.myTitle = @"法院新闻";
            [weakSelf.navigationController pushViewController:noDetailVC animated:YES];
            
        }
    };
    //  用代理处理点击图片事件，如果两个方法都实现，block优先级高于代理
    //    self.carouselView.delegate = self;
    //  设置每张图片的停留时间
    _carouselView.time = 2;
    //  设置分页控件的图片，不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    //  设置分页控制的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    /**
     *  设置图片描述控件
     */
    //  设置背景颜色，默认为黑色半透明
    _carouselView.desLabelBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //  设置字体，默认为13号字
    _carouselView.desLabelFont = [UIFont systemFontOfSize:14];
    //  设置文字颜色，默认为白色
    _carouselView.desLabelColor = [UIColor whiteColor];
    _carouselView.backgroundColor = [UIColor whiteColor];
    [self.homeDetailView addSubview:_carouselView];
}


#pragma mark - CZZCarouseViewDelagate  方法
-(void)carouselView:(CZZCarouselView *)carouselView didClickImage:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片",index);
    
}

#pragma mark - scrollViewButtonDelegate  方法
- (void)btnClickWithBtnTag:(NSInteger)btnTag{
    
    
    switch (btnTag) {
        case 0:{
            self.courtView.hidden = NO;
            self.homeDetailView.hidden = YES;
            self.mxNavigationBar.hidden = YES;
        }
            break;
        case 1:{
            GYLoginVC *loginVC = [[GYLoginVC alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            
            break;
        case 2:{
            GYSearchCaseLoginVC *searchLoginVC = [[GYSearchCaseLoginVC alloc]init];
            [self.navigationController pushViewController:searchLoginVC animated:YES];
        }
            
            break;
        case 3:{
            GYCourtDetailMainVC *CustomTabBar = [[GYCourtDetailMainVC alloc] init];
            [self.navigationController pushViewController:CustomTabBar animated:YES];
        }
            
            break;
        case 4:{
            GYPTMainVC *ptMainVC = [[GYPTMainVC alloc]init];
            [self.navigationController pushViewController:ptMainVC animated:YES];
        }
            
            break;
        case 5:{
            GYPeopleContactVC *peopleContactVC = [[GYPeopleContactVC alloc]init];
            [self.navigationController pushViewController:peopleContactVC animated:YES];
        }
            
            break;
        case 6:{
            GYNoticePublicVC *noticePVC = [[GYNoticePublicVC alloc]init];
            [self.navigationController pushViewController:noticePVC animated:YES];
        }
            
            break;
        case 7:{
            
        }
            
            break;
        case 8:{
            TopMenuSelectViewController *newsVC = [[TopMenuSelectViewController alloc]init];
            [self.navigationController pushViewController:newsVC animated:YES];
        }
            
            break;
        
            
        default:
            break;
    }
}


-(NSArray *)dataArr{
    
    if (!_dataArr) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"funKeyboardData.plist" ofType:nil];
        _dataArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArr;
}

-(CustomerScrollView *)btnScrollView{
    
    if (!_btnScrollView) {
        _btnScrollView = [[CustomerScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewH)];
        _btnScrollView.delegate = self;
    }
    return _btnScrollView;
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.top2NewsArr.count;
    
}


- (GYHomeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    if (!cell) {
        
        cell=[[GYHomeCell alloc]init];
        
    }
    cell.imageFileUrl = self.imageFileUrl;
    cell.newsModel = self.top2NewsArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 88;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYTop2NewsModel *top2NewsModel = self.top2NewsArr[indexPath.row];
    if (top2NewsModel.newstype == 1) {
        GYNewsRealDetailVC *newsRealDetailVC = [[GYNewsRealDetailVC alloc]init];
        newsRealDetailVC.newsDetail = top2NewsModel;
        newsRealDetailVC.myTitle = @"法院新闻";
        [self.navigationController pushViewController:newsRealDetailVC animated:YES];
    }
    if (top2NewsModel.newstype == 3) {
        GYNewsNoDetailVC *noDetailVC = [[GYNewsNoDetailVC alloc]init];
        noDetailVC.newsDetail = top2NewsModel;
        noDetailVC.myTitle = @"法院新闻";
        [self.navigationController pushViewController:noDetailVC animated:YES];
        
    }
    
}

- (void)loadCourtData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [GYHttpTool post:courtUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYCourtListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYCourtListModel *courtModel in arr) {
            if ([courtModel.dm hasPrefix:@"O1"]) {
                [self.courtNameArr addObject:courtModel.fyjc];
                [self.courtListArr addObject:courtModel];
            }
        }
        [self loadButtonWithArray:self.courtNameArr];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)loadButtonWithArray:(NSArray *)arr{
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 20;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        button.backgroundColor = bottonBackgroundBlueColor;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(15 + w, h, KScreenW/3-20, 30);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(10 + w + (KScreenW/3-20) > KScreenW-20){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(15 + w, h, KScreenW/3-20, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self.courtView addSubview:button];
    }
}

- (void)handleClick:(UIButton *)btn{
    GYCourtListModel *courtListModel = self.courtListArr[btn.tag];
    NSLog(@"%@",courtListModel.dm);
    [[NSUserDefaults standardUserDefaults] setObject:courtListModel.dm forKey:@"chooseCourt_dm"];
    self.courtView.hidden = YES;
    self.homeDetailView.hidden = NO;
    self.mxNavigationBar.hidden = NO;
    self.courtViewBackBtn.hidden = NO;
}
- (IBAction)courtViewBack:(id)sender {
    self.courtView.hidden = YES;
    self.homeDetailView.hidden = NO;
    self.mxNavigationBar.hidden = NO;
}


- (NSMutableArray *)courtListArr {
	if(_courtListArr == nil) {
		_courtListArr = [[NSMutableArray alloc] init];
	}
	return _courtListArr;
}

- (NSMutableArray *)courtNameArr {
	if(_courtNameArr == nil) {
		_courtNameArr = [[NSMutableArray alloc] init];
	}
	return _courtNameArr;
}

- (NSMutableArray *)top2NewsArr {
	if(_top2NewsArr == nil) {
		_top2NewsArr = [[NSMutableArray alloc] init];
	}
	return _top2NewsArr;
}

- (NSMutableArray *)lunboNewsArr {
	if(_lunboNewsArr == nil) {
		_lunboNewsArr = [[NSMutableArray alloc] init];
	}
	return _lunboNewsArr;
}

- (NSMutableArray *)lunboTitleArr {
	if(_lunboTitleArr == nil) {
		_lunboTitleArr = [[NSMutableArray alloc] init];
	}
	return _lunboTitleArr;
}

- (NSMutableArray *)lunboImageArr {
	if(_lunboImageArr == nil) {
		_lunboImageArr = [[NSMutableArray alloc] init];
	}
	return _lunboImageArr;
}

@end
