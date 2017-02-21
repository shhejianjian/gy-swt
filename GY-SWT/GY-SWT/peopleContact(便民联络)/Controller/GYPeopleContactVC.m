//
//  GYPeopleContactVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/14.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYPeopleContactVC.h"
#import "MXConstant.h"

@interface GYPeopleContactVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYPeopleContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.mxNavigationItem.title = @"便民联络";
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
