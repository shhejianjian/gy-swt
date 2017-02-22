//
//  GYNRDsrXxCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDsrXxCell.h"


@interface GYNRDsrXxCell ()
@property (strong, nonatomic) IBOutlet UILabel *ygbgLabel;
@property (strong, nonatomic) IBOutlet UILabel *ygbgNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *zzdmLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdzLabel;

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *zzdmOrSfzhmLabel;

@end

@implementation GYNRDsrXxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setGynrDsrxxModel:(GYNRDsrXxModel *)gynrDsrxxModel {
    _gynrDsrxxModel = gynrDsrxxModel;
    self.ygbgLabel.text = [NSString stringWithFormat:@"%@:",gynrDsrxxModel.ssdwmc];
    
    if ([gynrDsrxxModel.xbmc isEqualToString:@"其他"]) {
        self.ygbgNameLabel.text = gynrDsrxxModel.zzmc;
        self.zzdmOrSfzhmLabel.text = @"组织代码:";
        self.zzdmLabel.text = gynrDsrxxModel.zzjgdm;
        self.lxdzLabel.text = gynrDsrxxModel.zzdz;
    } else {
        self.ygbgNameLabel.text = [NSString stringWithFormat:@"%@(%@)",gynrDsrxxModel.mc,gynrDsrxxModel.xbmc];
        self.zzdmLabel.text = gynrDsrxxModel.sfzjhm;
        self.lxdzLabel.text = gynrDsrxxModel.jtdz;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
