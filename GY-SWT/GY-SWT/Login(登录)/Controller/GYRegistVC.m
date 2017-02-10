//
//  GYRegistVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYRegistVC.h"
#import "MXConstant.h"

@interface GYRegistVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation GYRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"新用户注册";
    self.detailView.layer.cornerRadius = 5;
    self.nextBtn.layer.cornerRadius = 20;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextBtnClick:(id)sender {
    
}


@end
