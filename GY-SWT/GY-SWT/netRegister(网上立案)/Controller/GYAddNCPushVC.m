//
//  GYAddNCPushVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNCPushVC.h"
#import "XFSegmentView.h"
#import "LQXSwitch.h"
#import "UIViewController+KNSemiModal.h"

@interface GYAddNCPushVC ()<XFSegmentViewDelegate>
//firstView
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *switchView;
@property (strong, nonatomic) IBOutlet UIButton *saveInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *messageBtn;
@property (strong, nonatomic) IBOutlet UIButton *frdwBtn;
//secondView
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UIButton *secondMessageBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondFrdwBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondSaveInfoBtn;
//thirdView
@property (strong, nonatomic) IBOutlet UIView *thirdView;
@property (strong, nonatomic) IBOutlet UIButton *thirdMessageBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdFrdwBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdSaveInfoBtn;

@end

@implementation GYAddNCPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUI{
    //firstView
    self.switchView.layer.cornerRadius = 15;
    self.switchView.layer.masksToBounds = YES;
    self.saveInfoBtn.layer.cornerRadius = 15;
    self.saveInfoBtn.layer.masksToBounds = YES;
    self.messageBtn.layer.borderWidth = 2;
    self.messageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.messageBtn.layer.cornerRadius = 5;
    self.frdwBtn.layer.cornerRadius = 5;
    self.frdwBtn.layer.borderWidth = 2;
    self.frdwBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    //secondView
    self.secondSaveInfoBtn.layer.cornerRadius = 15;
    self.secondSaveInfoBtn.layer.masksToBounds = YES;
    self.secondMessageBtn.layer.borderWidth = 2;
    self.secondMessageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.secondMessageBtn.layer.cornerRadius = 5;
    self.secondFrdwBtn.layer.cornerRadius = 5;
    self.secondFrdwBtn.layer.borderWidth = 2;
    self.secondFrdwBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    //thirdView
    self.thirdSaveInfoBtn.layer.cornerRadius = 15;
    self.thirdSaveInfoBtn.layer.masksToBounds = YES;
    self.thirdMessageBtn.layer.borderWidth = 2;
    self.thirdMessageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.thirdMessageBtn.layer.cornerRadius = 5;
    self.thirdFrdwBtn.layer.cornerRadius = 5;
    self.thirdFrdwBtn.layer.borderWidth = 2;
    self.thirdFrdwBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 0, SCREEN_WIDTH, WH(40))];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"自然人",@"法人组织",@"非法人组织"];
    segView.titleFont = Font(15);
    
    LQXSwitch *swit = [[LQXSwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30) onColor:[UIColor colorWithRed:240 / 255.0 green:0 / 255.0 blue:130 / 255.0 alpha:1.0] offColor:[UIColor colorWithRed:0 / 255.0 green:192 / 255.0 blue:246 / 255.0 alpha:1.0] font:[UIFont systemFontOfSize:20] ballSize:30];
    swit.onText = @"女";
    swit.offText = @"男";
    [self.switchView addSubview:swit];
    NSLog(@"%d",swit.on);
    [swit addTarget:self action:@selector(switchSex:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)switchSex:(LQXSwitch *)swit
{
    NSLog(@"%d",swit.on);
}

//firstView
- (IBAction)messageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)frdwBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)saveInfoBtnClick:(id)sender {
    [self dismissSemiModalView];
}
//secondView
- (IBAction)secondMessageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;

}
- (IBAction)secondFrswBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;

}
- (IBAction)secondSaveInfoBtnClick:(id)sender {
    [self dismissSemiModalView];
}
//thirdView
- (IBAction)thirdMessageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)thirdFrdwBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)thirdSaveInfoBtnClick:(id)sender {
    [self dismissSemiModalView];
}




-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    
    switch (index) {
        case 0:
            self.secondView.hidden = YES;
            self.firstView.hidden = NO;
            self.thirdView.hidden = YES;
            break;
        case 1:
            self.firstView.hidden = YES;
            self.thirdView.hidden = YES;
            self.secondView.hidden = NO;
            break;
        case 2:
            self.firstView.hidden = YES;
            self.secondView.hidden = YES;
            self.thirdView.hidden = NO;
        default:
            break;
    }
}
@end
