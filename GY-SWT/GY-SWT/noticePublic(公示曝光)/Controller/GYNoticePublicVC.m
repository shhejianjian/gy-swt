//
//  GYNoticePublicVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNoticePublicVC.h"
#import "MXConstant.h"
#import "XFSegmentView.h"
#import "LGLSearchBar.h"
#import "GYNoticePucCell.h"

static NSString *ID=@"GYNoticePucCell";



#define SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GYNoticePublicVC ()<XFSegmentViewDelegate>{
    UIImageView *imgView;
    NSArray *names;
}
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *cellDetailView;
@property (strong, nonatomic) IBOutlet UIButton *backToTableBtn;

@end

@implementation GYNoticePublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"失信人员名单";
    self.detailView.layer.cornerRadius = 5;
    self.cellDetailView.layer.cornerRadius = 5;
    self.myTableView.layer.cornerRadius = 5;
    self.backToTableBtn.layer.cornerRadius = 15;
    
    names = @[@"1",@"2",@"3"];
    self.view.backgroundColor=ContentBackGroundColor;
    
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"限制高消费",@"限制出境",@"失信人员"];
    segView.titleFont = Font(15);
    
    LGLSearchBar * searchBar = [[LGLSearchBar alloc] initWithFrame:CGRectMake(15, 114, SCREENWIDTH - 30, 40) searchBarStyle:LGLSearchBarStyleDefault];
//    searchBar.barBackgroudColor = MainRedColor;
//    searchBar.textBackgroudColor = [UIColor greenColor];
    searchBar.barBackgroudColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
//    searchBar.textBackgroudColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
    searchBar.layer.cornerRadius = 5;
    searchBar.layer.masksToBounds = YES;
    [searchBar searchBarTextSearchTextBlock:^(NSString *searchText) {
        NSLog(@"%@", searchText);
    }];
    [self.view addSubview:searchBar];
    
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"GYNoticePucCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 5;
    
}


- (GYNoticePucCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNoticePucCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNoticePucCell alloc]init];
        
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 70;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.myTableView.hidden = YES;
    self.cellDetailView.hidden = NO;
    
}
- (IBAction)backToTableClick:(id)sender {
    self.cellDetailView.hidden = YES;
    self.myTableView.hidden = NO;
}


-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

@end
