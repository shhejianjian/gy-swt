//
//  GYSearchCaseLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/10.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSearchCaseLoginVC.h"
#import "MXConstant.h"
#import "GYSearchCaseListVC.h"

@interface GYSearchCaseLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *SPSearchBtn;
@property (strong, nonatomic) IBOutlet UIButton *ZXSearchBtn;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end

@implementation GYSearchCaseLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"案件信息查询";
    self.SPSearchBtn.layer.cornerRadius = 5;
    self.ZXSearchBtn.layer.cornerRadius = 5;
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)spSearchClick:(id)sender {
    [self loginHttpWithAjType:@"2"];
}


- (IBAction)zxSearchClick:(id)sender {
    [self loginHttpWithAjType:@"1"];
}


- (void)loginHttpWithAjType:(NSString *)ajType {
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = self.userName.text;
    params[@"password"] = self.password.text;
    params[@"type"] = @"1";
    params[@"ajType"] = ajType;
    [GYHttpTool post:ajxcLoginUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        [MBProgressHUD hideHUDForView:self.view];
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        
        if ([loginModel.success isEqualToString:@"true"]) {
            [MBProgressHUD showSuccess:loginModel.msg];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"ajcx_loginTicket"];
            GYSearchCaseListVC *scLiftVC = [[GYSearchCaseListVC alloc]init];
            scLiftVC.ajTypeStr = ajType;
            [self.navigationController pushViewController:scLiftVC animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

@end
