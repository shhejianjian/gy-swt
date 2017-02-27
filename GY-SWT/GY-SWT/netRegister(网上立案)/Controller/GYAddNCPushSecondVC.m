//
//  GYAddNCPushSecondVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNCPushSecondVC.h"
#import "UIViewController+KNSemiModal.h"

@interface GYAddNCPushSecondVC ()
@property (strong, nonatomic) IBOutlet UIButton *sdBtn;
@property (strong, nonatomic) IBOutlet UIButton *saveInfoBtn;

@end

@implementation GYAddNCPushSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.saveInfoBtn.layer.cornerRadius = 15;
    self.saveInfoBtn.layer.masksToBounds = YES;
    self.sdBtn.layer.borderWidth = 2;
    self.sdBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.sdBtn.layer.cornerRadius = 5;
}

- (IBAction)saveInfoBtnClick:(id)sender {
    [self dismissSemiModalView];
}


@end
