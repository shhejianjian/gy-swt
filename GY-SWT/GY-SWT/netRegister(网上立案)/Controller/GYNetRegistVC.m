//
//  GYNetRegistVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNetRegistVC.h"
#import "GYNRHomeCell.h"
#import "MXConstant.h"
#import "CustomTabbarController.h"


static NSString *ID=@"GYNRHomeCell";

@interface GYNetRegistVC ()
@property (strong, nonatomic) IBOutlet UIButton *addNewRegistBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYNetRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"网上立案";

    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRHomeCell" bundle:nil] forCellReuseIdentifier:ID];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.addNewRegistBtn.layer.cornerRadius = 15;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 5;
    
}


- (GYNRHomeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRHomeCell alloc]init];
        
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 90;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTabbarController *custom = [[CustomTabbarController alloc]init];
    [self.navigationController pushViewController:custom animated:YES];
    
}



@end
