//
//  GYAddNewsCaseVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewsCaseVC.h"
#import "GYAddNewCaseSecondVC.h"
#import "MXConstant.h"
@interface GYAddNewsCaseVC ()
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation GYAddNewsCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void) setUI {
    self.mxNavigationItem.title = @"核对案件信息";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.stepView.layer.cornerRadius = 2.5f;
    self.stepView.layer.masksToBounds = YES;
    self.blackLineView.layer.cornerRadius = 5;
    self.blackLineView.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 15;
    self.sureBtn.layer.masksToBounds = YES;
}
- (IBAction)sureBtnClick:(id)sender {
    
    GYAddNewCaseSecondVC *addNCSecondVC = [[GYAddNewCaseSecondVC alloc]init];
    [self.navigationController pushViewController:addNCSecondVC animated:YES];
}

@end
