//
//  GYNewsRealDetailVC.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNewsInfoListModel.h"
@interface GYNewsRealDetailVC : UIViewController
@property (nonatomic, strong) GYNewsInfoListModel* newsDetail;
@property (nonatomic, copy) NSString *myTitle;
@end
