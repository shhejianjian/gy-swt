//
//  GYNetRegistVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNetRegistVC.h"
#import "GYNRHomeCell.h"
#import "MXConstant.h"
#import "CustomTabbarController.h"
#import "GYNetRegistModel.h"
#import "GYAddNewsCaseVC.h"
#import "GYAddNewCaseSecondVC.h"
extern NSString *checkSucessWsla;

static NSString *ID=@"GYNRHomeCell";

@interface GYNetRegistVC ()
@property (strong, nonatomic) IBOutlet UIButton *addNewRegistBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@property (nonatomic, strong) NSMutableArray *wslaListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;


@end

@implementation GYNetRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"网上立案";

    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRHomeCell" bundle:nil] forCellReuseIdentifier:ID];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.addNewRegistBtn.layer.cornerRadius = 15;
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    
    [self.myTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNewData
{
    [self.wslaListArr removeAllObjects];
    self.currentPage = 1;
    [self loadWslaAjxxListInfo];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadWslaAjxxListInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([checkSucessWsla isEqualToString:@"success"]) {
        [self.myTableView.mj_header beginRefreshing];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    checkSucessWsla = nil;
}

- (void)loadWslaAjxxListInfo{
    
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @"8";
    params[@"page"] = @(self.currentPage);
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_listInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"json:%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        NSArray *arr = [GYNetRegistModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNetRegistModel *nrModel in arr) {
            [self.wslaListArr addObject:nrModel];
        }
        self.totalCount = [loginModel.count integerValue];
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.wslaListArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.wslaListArr.count;
    
}


- (GYNRHomeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRHomeCell alloc]init];
        
    }
    
    GYNetRegistModel *cellNrModel = self.wslaListArr[indexPath.row];
    if ([cellNrModel.clztmc isEqualToString:@"收案"]) {
        cell.typeLabel.backgroundColor = wslaGrayColor;
    }
    if ([cellNrModel.clztmc isEqualToString:@"审核通过"]) {
        cell.typeLabel.backgroundColor = wslapurpleColor;
    }
    if ([cellNrModel.clztmc isEqualToString:@"待审核"]) {
        cell.typeLabel.backgroundColor = wslagreenColor;
    }
    if ([cellNrModel.clztmc isEqualToString:@"申请"]) {
        cell.typeLabel.backgroundColor = wslaredColor;
    }
    
    cell.nrModel = self.wslaListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 90;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYNetRegistModel *nrModel = self.wslaListArr[indexPath.row];
    
    NSLog(@"ajbs==%@",nrModel.ajbs);
    
    [[NSUserDefaults standardUserDefaults] setObject:nrModel.ajbs forKey:@"wsla_ajxx_ajbs"];
    
    if ([nrModel.clztmc isEqualToString:@"申请"]) {
        GYAddNewCaseSecondVC *ncSecondVC = [[GYAddNewCaseSecondVC alloc]init];
        ncSecondVC.ajbsStr = nrModel.ajbs;
        [self.navigationController pushViewController:ncSecondVC animated:YES];
    } else {
        CustomTabbarController *custom = [[CustomTabbarController alloc]init];
        [self.navigationController pushViewController:custom animated:YES];
    }
}

- (IBAction)addNewCase:(id)sender {
    
    GYAddNewsCaseVC *addNewsCaseVC = [[GYAddNewsCaseVC alloc]init];
    [self.navigationController pushViewController:addNewsCaseVC animated:YES];
    
}







- (NSMutableArray *)wslaListArr {
    if(_wslaListArr == nil) {
        _wslaListArr = [[NSMutableArray alloc] init];
    }
    return _wslaListArr;
}


@end
