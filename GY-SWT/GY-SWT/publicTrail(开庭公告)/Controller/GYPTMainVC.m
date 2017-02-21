//
//  GYPTMainVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/20.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYPTMainVC.h"
#import "GYNRSegmentView.h"
#import "MXConstant.h"

@interface GYPTMainVC ()<GYNRSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYPTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"开庭公告";
    GYNRSegmentView *segView=[[GYNRSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    segView.delegate = self;
    segView.titles = @[@"今日开庭",@"明日开庭"];
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
