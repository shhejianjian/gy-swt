//
//  GYSCDetailFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCDetailFirstVC.h"
#import "MXConstant.h"
@interface GYSCDetailFirstVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYSCDetailFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    [self loaddetailData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loaddetailData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool postImage:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        [MBProgressHUD hideHUDForView:self.view];
//        NSArray *arr = [GYSCListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
//        for (GYSCListModel *sclistModel in arr) {
//            [self.scListArr addObject:sclistModel];
//        }
//        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
