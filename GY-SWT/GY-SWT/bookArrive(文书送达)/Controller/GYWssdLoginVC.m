//
//  GYWssdLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/3/2.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYWssdLoginVC.h"
#import "MXConstant.h"
#import "GYWssdListVC.h"
@interface GYWssdLoginVC ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation GYWssdLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"文书送达登录";
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginBtnClick:(id)sender {
    
    if (self.userNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"用户名不能为空"];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = self.userNameTextField.text;
    params[@"password"] = self.passwordTextField.text;
    [GYHttpTool post:wssd_loginUrl ticket:@"" params:params success:^(id json) {
        
        NSLog(@"%@---%@",json,params);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            NSLog(@"ticket:%@",loginModel.ticket);
            [MBProgressHUD showSuccess:loginModel.msg];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"wssd_loginTicket"];
            GYWssdListVC *wssdDetail = [[GYWssdListVC alloc]init];
            [self.navigationController pushViewController:wssdDetail animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
    
    
}



@end
