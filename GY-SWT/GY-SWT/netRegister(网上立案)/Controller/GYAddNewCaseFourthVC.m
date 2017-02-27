//
//  GYAddNewCaseFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewCaseFourthVC.h"
#import "MXConstant.h"
#import "GYAddNCPushSecondVC.h"
#import "UIViewController+KNSemiModal.h"
#import "GYNRDlrXxCell.h"
#import "GYAddNewCaseFifthVC.h"

static NSString *ID=@"GYNRDlrXxCell";

@interface GYAddNewCaseFourthVC ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *addNewInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) GYAddNCPushSecondVC *pushView;

@end

@implementation GYAddNewCaseFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUI {
    self.mxNavigationItem.title = @"核对代理人信息";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.stepView.layer.cornerRadius = 2.5f;
    self.stepView.layer.masksToBounds = YES;
    self.blackLineView.layer.cornerRadius = 5;
    self.blackLineView.layer.masksToBounds = YES;
    self.addNewInfoBtn.layer.cornerRadius = 15;
    self.addNewInfoBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 15;
    self.nextBtn.layer.masksToBounds = YES;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRDlrXxCell" bundle:nil] forCellReuseIdentifier:ID];
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 5;
    
}


- (GYNRDlrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRDlrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRDlrXxCell alloc]init];
        
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 120;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (IBAction)addNewInfoBtnClick:(id)sender {
    [self presentSemiViewController:self.pushView withOptions:@{
                                                                KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                                KNSemiModalOptionKeys.shadowOpacity     : @(0.3)
                                                                }];
}

- (IBAction)nextBtnClick:(id)sender {
    GYAddNewCaseFifthVC *addNCFifthVC = [[GYAddNewCaseFifthVC alloc]init];
    [self.navigationController pushViewController:addNCFifthVC animated:YES];
}

- (GYAddNCPushSecondVC *)pushView
{
    if (!_pushView) {
        _pushView = [[GYAddNCPushSecondVC alloc] initWithNibName:@"GYAddNCPushSecondVC" bundle:nil];
    }
    return _pushView;
}
@end
