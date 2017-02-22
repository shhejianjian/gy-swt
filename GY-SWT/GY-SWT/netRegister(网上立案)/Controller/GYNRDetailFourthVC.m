//
//  GYNRDetailFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailFourthVC.h"
#import "XFSegmentView.h"
#import "MXConstant.h"
#import "GYClxxModel.h"
#import "ZoomImageView.h"

@interface GYNRDetailFourthVC ()<XFSegmentViewDelegate>{
    UIView *background;
}

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageListArr;
@property (nonatomic, copy) NSString *mlidType;

@property (nonatomic, strong) NSData *imageData;

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
    
    [self loadWslaAjxxDetailInfoWithMlid:@"3"];
    
    [[ZoomImageView getZoomImageView]showZoomImageView:self.myImageView addGRType:0];
    // Do any additional setup after loading the view from its nib.
}


- (void)loadWslaAjxxDetailInfoWithMlid:(NSString *)mlid{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"wsla_ajxx_ajbs"];
    params[@"page"] = @"1";
    params[@"pageSize"] = @"8";
    params[@"mlid"] = mlid;
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    
    [GYHttpTool post:wsla_ajxx_detailClxxInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@--%@",json,params);
        NSArray *arr = [GYClxxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYClxxModel *clxxModel in arr) {
            NSLog(@"++%@",clxxModel.jlid);
            

            NSMutableDictionary *imageParams = [NSMutableDictionary dictionary];
            imageParams[@"jlid"] = clxxModel.jlid;
            [GYHttpTool postImage:wsla_ajxx_detailClxxImageInfoUrl ticket:ticket params:imageParams success:^(id json) {
                NSLog(@"json-image:%@",json);
                UIImage *image = [[UIImage alloc] initWithData:json];
                self.imageData = json;
                self.myImageView.image = image;
                [MBProgressHUD hideHUDForView:self.view];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
            if (![self.mlidType isEqualToString:@"3"]) {
                [self loadWslaAjxxDetailInfoWithMlid:@"3"];
                self.mlidType = @"3";
            }
            break;
        case 1:
            if (![self.mlidType isEqualToString:@"8"]) {
                [self loadWslaAjxxDetailInfoWithMlid:@"8"];
                self.mlidType = @"8";
            }
            break;
        case 2:
            if (![self.mlidType isEqualToString:@"14"]) {
                [self loadWslaAjxxDetailInfoWithMlid:@"14"];
                self.mlidType = @"14";
            }
            break;
        default:
            break;
    }
}

- (NSMutableArray *)imageListArr {
    if(_imageListArr == nil) {
        _imageListArr = [[NSMutableArray alloc] init];
    }
    return _imageListArr;
}


@end
