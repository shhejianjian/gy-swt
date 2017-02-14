//
//  GYNRDetailFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailFourthVC.h"
#import "XFSegmentView.h"

@interface GYNRDetailFourthVC ()<XFSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYNRDetailFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"起诉书",@"证件材料",@"委托材料"];
    segView.titleFont = Font(15);
    
    
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}
@end
