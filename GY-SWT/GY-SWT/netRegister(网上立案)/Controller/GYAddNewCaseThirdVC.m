//
//  GYAddNewCaseThirdVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewCaseThirdVC.h"
#import "MXConstant.h"
#import "GYAddNCPushVC.h"
#import "UIViewController+KNSemiModal.h"
#import "GYNRDsrXxCell.h"
#import "GYAddNewCaseFourthVC.h"
static NSString *ID=@"GYNRDsrXxCell";


@interface GYAddNewCaseThirdVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *addNewInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) GYAddNCPushVC *pushView;

@end

@implementation GYAddNewCaseThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.mxNavigationItem.title = @"核对被告信息";
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRDsrXxCell" bundle:nil] forCellReuseIdentifier:ID];
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 5;
    
}


- (GYNRDsrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRDsrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRDsrXxCell alloc]init];
        
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 110;
    
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
    GYAddNewCaseFourthVC *addNCFourthVC = [[GYAddNewCaseFourthVC alloc]init];
    [self.navigationController pushViewController:addNCFourthVC animated:YES];
}
- (GYAddNCPushVC *)pushView
{
    if (!_pushView) {
        _pushView = [[GYAddNCPushVC alloc] initWithNibName:@"GYAddNCPushVC" bundle:nil];
    }
    return _pushView;
}


@end
