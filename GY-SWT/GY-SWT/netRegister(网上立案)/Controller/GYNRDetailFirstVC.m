//
//  GYNRDetailFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailFirstVC.h"
#import "MXConstant.h"
#import "GYNetRegistModel.h"
@interface GYNRDetailFirstVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITextField *courtName;
@property (strong, nonatomic) IBOutlet UITextField *ajlbName;
@property (strong, nonatomic) IBOutlet UITextField *spcxName;
@property (strong, nonatomic) IBOutlet UITextField *personName;
@property (strong, nonatomic) IBOutlet UITextField *number;
@property (strong, nonatomic) IBOutlet UITextField *telephone;

@end

@implementation GYNRDetailFirstVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView.layer.cornerRadius = 5;
    
    
    [self loadWslaAjxxDetailInfo];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadWslaAjxxDetailInfo{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"wsla_ajxx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_detailInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYNetRegistModel *nrModel = [GYNetRegistModel mj_objectWithKeyValues:json[@"parameters"][@"jbxx"]];
        self.courtName.text = nrModel.fymc;
        self.ajlbName.text = nrModel.ajlbmc;
        self.spcxName.text = nrModel.spcxmc;
        self.personName.text = nrModel.sqrmc;
        self.number.text = nrModel.sqryddh;
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
