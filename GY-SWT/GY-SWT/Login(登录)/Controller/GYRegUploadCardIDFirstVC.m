//
//  GYRegUploadCardIDFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYRegUploadCardIDFirstVC.h"
#import "MXConstant.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"
@interface GYRegUploadCardIDFirstVC ()<LDActionSheetDelegate,LDImagePickerDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation GYRegUploadCardIDFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}


- (void)setUI {
    self.mxNavigationItem.title = @"上传身份证正面";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 20;
    self.nextBtn.layer.masksToBounds = YES;
    
    self.myImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage)];
    [self.myImageView addGestureRecognizer:tapGesturRecognizer];
}

- (void)chooseImage{
    NSLog(@"chooseImage");
    LDActionSheet *actionSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选择", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    self.myImageView.contentMode = UIViewContentModeScaleToFill;
    self.myImageView.image = editedImage;
}


@end
