//
//  GYLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYLoginVC.h"
#import "MXConstant.h"
#import "GYRegistVC.h"
@interface GYLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *regiestBtn;

@end

@implementation GYLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"登录注册";
    self.loginBtn.layer.cornerRadius = 5;
    self.regiestBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)registBtnClick:(id)sender {
    GYRegistVC *registVC = [[GYRegistVC alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}



@end
