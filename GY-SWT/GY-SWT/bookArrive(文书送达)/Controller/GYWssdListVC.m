//
//  GYWssdListVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/3/2.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYWssdListVC.h"
#import "MXConstant.h"
#import "GYNRSegmentView.h"
@interface GYWssdListVC () <GYNRSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYWssdListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"文书送达";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    GYNRSegmentView *segView=[[GYNRSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    segView.delegate = self;
    segView.titles = @[@"待办文书",@"已办文书"];
    segView.titleFont = Font(15);
    [self.view addSubview:segView];
    // Do any additional setup after loading the view from its nib.
}

-(void)segmentView:(GYNRSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
            
            
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

@end
