//
//  GYNRDetailSecondVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailSecondVC.h"
#import "GYNRSegmentView.h"

@interface GYNRDetailSecondVC ()<GYNRSegmentViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYNRDetailSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    GYNRSegmentView *segView=[[GYNRSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    segView.delegate = self;
    segView.titles = @[@"原告信息",@"被告信息"];
    segView.titleFont = Font(15);
    [self.view addSubview:segView];

    
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)segmentView:(GYNRSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}


@end
