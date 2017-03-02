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
    GYWssdListVC *wssdDetail = [[GYWssdListVC alloc]init];
    [self.navigationController pushViewController:wssdDetail animated:YES];
    
}



@end
