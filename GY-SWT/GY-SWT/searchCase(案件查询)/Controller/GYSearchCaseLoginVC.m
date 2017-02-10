//
//  GYSearchCaseLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/10.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSearchCaseLoginVC.h"
#import "MXConstant.h"

@interface GYSearchCaseLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *SPSearchBtn;
@property (strong, nonatomic) IBOutlet UIButton *ZXSearchBtn;

@end

@implementation GYSearchCaseLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"案件信息查询";
    self.SPSearchBtn.layer.cornerRadius = 5;
    self.ZXSearchBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
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
