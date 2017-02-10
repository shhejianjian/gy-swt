//
//  GYCDThirdCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCDThirdCell.h"

@interface GYCDThirdCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYCDThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
