//
//  GYAddNewCaseFifthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewCaseFifthVC.h"
#import "MXConstant.h"
#import "GYAddNewCaseSixthVC.h"
@interface GYAddNewCaseFifthVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@end

@implementation GYAddNewCaseFifthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI {
    self.mxNavigationItem.title = @"核对起诉书";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.stepView.layer.cornerRadius = 2.5f;
    self.stepView.layer.masksToBounds = YES;
    self.blackLineView.layer.cornerRadius = 5;
    self.blackLineView.layer.masksToBounds = YES;
    
    self.nextBtn.layer.cornerRadius = 15;
    self.nextBtn.layer.masksToBounds = YES;
    
}

- (IBAction)nexBtnClick:(id)sender {
    GYAddNewCaseSixthVC *addNCSixVC = [[GYAddNewCaseSixthVC alloc]init];
    [self.navigationController pushViewController: addNCSixVC animated:YES];
}

@end
