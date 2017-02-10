//
//  JPullDownMenu.m
//  JPullDownMenuDemo
//
//  Created by 开发者 on 16/5/19.
//  Copyright © 2016年 jinxiansen. All rights reserved.
//

#import "JPullDownMenu.h"
#import <objc/runtime.h>
#import "GYConst.h"
#define Kscreen_width  [UIScreen mainScreen].bounds.size.width
#define Kscreen_height [UIScreen mainScreen].bounds.size.height
#define KTitleButtonHeight 40

// 格式 0xff3737
#define RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define KDefaultColor [UIColor whiteColor]

#define KmaskBackGroundViewColor  [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:.2]
#define kCellBgColor [UIColor whiteColor]

#define KTableViewCellHeight 40

#define KDisplayMaxCellOfNumber  5

#define KTitleButtonTag 1000


#define KOBJCSetObject(object,value)  objc_setAssociatedObject(object,@"title" , value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define KOBJCGetObject(object) objc_getAssociatedObject(object, @"title")

@interface JPullDownMenu () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSArray *titleArray ;

@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSMutableArray *tableDataArray;

@property (nonatomic) CGFloat selfOriginalHeight ;
@property (nonatomic) CGFloat tableViewMaxHeight ;

@property (nonatomic) NSMutableArray *buttonArray;

@property (nonatomic) UIView  *maskBackGroundView;
@property (nonatomic, strong)UIImageView *lineImageView;

@end

@implementation JPullDownMenu


- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableViewMaxHeight = KTableViewCellHeight * KDisplayMaxCellOfNumber;
        self.selfOriginalHeight =frame.size.height;
        self.titleArray =titleArray;
        
        [self addSubview:self.maskBackGroundView];
        [self addSubview:self.tableView];
        
        [self configBaseInfo];
        
    }
    return self;
}

-(void)configBaseInfo
{
    
    //    self.backgroundColor=KmaskBackGroundViewColor;
    
    //用于遮盖self.backgroundColor 。
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Kscreen_width, KTitleButtonHeight)];
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];
    
    CGFloat width = Kscreen_width /self.titleArray.count;
    
    for (int index=0; index<self.titleArray.count; index++) {
        
        UIButton *titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        titleButton.frame= CGRectMake((width+0.5) * index, 0, width-0.5, KTitleButtonHeight);
        titleButton.backgroundColor =KDefaultColor;
        [titleButton setTitle:self.titleArray[index] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        titleButton.tag =KTitleButtonTag + index ;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleButton setTitleColor:HGBlueColor forState:UIControlStateSelected];
        [titleButton setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageNamed:@"箭头-up"] forState:UIControlStateSelected];
        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [self addSubview:titleButton];
        [self.buttonArray addObject:titleButton];
        
    }
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, width*2, 1)];
    self.lineImageView.backgroundColor = [UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:0.7f];
    [self addSubview:self.lineImageView];
    
}

-(UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, Kscreen_width, 0)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.rowHeight= KTableViewCellHeight;
    
    
    return self.tableView;
}


#pragma mark  --  <代理方法>
#pragma mark  --  <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    downMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell =[[downMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.tableDataArray[indexPath.row];
//    if ([cell.textLabel.text isEqualToString:@"全部"]) {
//        cell.imageView.image = [UIImage imageNamed:@"add"];
//
//    } else if ([cell.textLabel.text isEqualToString:@"同意"]){
//        cell.imageView.image = [UIImage imageNamed:@"首页"];
//    }
    NSString *objcTitle = KOBJCGetObject(self.tempButton);
    
    if ([cell.textLabel.text isEqualToString:objcTitle]) {
        cell.isSelected = YES;
    }
    else
    {
        cell.isSelected=NO;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    downMenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    [self.tempButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    KOBJCSetObject(self.tempButton, cell.textLabel.text);
    
    if (self.handleSelectDataBlock) {
        self.handleSelectDataBlock(cell.textLabel.text,indexPath.row,self.tempButton.tag - KTitleButtonTag);
    }
    
    [self takeBackTableView];
    
}



-(void)setDefauldSelectedCell
{
    
    for (int index=0; index<self.buttonArray.count; index++) {
        
        self.tableDataArray =self.menuDataArray[index];
        
        UIButton *button =self.buttonArray[index];
        
        NSString *title = self.tableDataArray.firstObject;
        
        KOBJCSetObject(button, title);
        
        [button setTitle:title forState:UIControlStateNormal];
        
    }
    
    [self takeBackTableView];
    
}


-(void)titleButtonClick:(UIButton *)titleButton
{
    NSUInteger index =  titleButton.tag - KTitleButtonTag;
    
    for (UIButton *button in self.buttonArray) {
        if (button == titleButton) {
            button.selected=!button.selected;
            self.tempButton =button;
            [self changeButtonObject:button TransformAngle:M_PI];
        }else
        {
            button.selected=NO;
            [self changeButtonObject:button TransformAngle:0];
        }
    }
    
    
    if (titleButton.selected) {
        
       [self changeButtonObject:titleButton TransformAngle:M_PI];
        
        self.tableDataArray = self.menuDataArray[index];
        
        //设置默认选中第一项。
        if ([KOBJCGetObject(self.tempButton) length]<1) {
            
            NSString *title = self.tableDataArray.firstObject;
            KOBJCSetObject(self.tempButton, title);
            
        }
        
        [self.tableView reloadData];
        
        CGFloat tableViewHeight =  self.tableDataArray.count * KTableViewCellHeight < self.tableViewMaxHeight ?
        self.tableDataArray.count * KTableViewCellHeight : self.tableViewMaxHeight;
        [self expandWithTableViewHeight:tableViewHeight];
        
    }else
    {
        [self takeBackTableView];
    }
    
}



//展开。
-(void)expandWithTableViewHeight:(CGFloat )tableViewHeight
{
    
    self.maskBackGroundView.hidden=NO;
    
    CGRect rect = self.frame;
    rect.size.height = Kscreen_height - self.frame.origin.y;
    self.frame= rect;
    
    [self showSpringAnimationWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width, tableViewHeight);
        
        self.maskBackGroundView.alpha =1;
        
    } completion:^{
        
    }];
}

//收起。
-(void)takeBackTableView
{
    for (UIButton *button in self.buttonArray) {
        button.selected=NO;
        [self changeButtonObject:button TransformAngle:0];
    }
    
    CGRect rect = self.frame;
    rect.size.height = self.selfOriginalHeight;
    self.frame = rect;
    
    [self showSpringAnimationWithDuration:.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);;
        self.maskBackGroundView.alpha =0;
        
    } completion:^{
        self.maskBackGroundView.hidden=YES;
    }];
    
}


-(void)changeButtonObject:(UIButton *)button TransformAngle:(CGFloat)angle
{
//    [UIView animateWithDuration:0.5 animations:^{
//        button.imageView.transform =CGAffineTransformMakeRotation(angle);
//    } completion:^(BOOL finished) {
//    }];

}

-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion
{
 
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}



-(void)maskBackGroundViewTapClick
{
    [self takeBackTableView];
}



-(NSMutableArray *)menuDataArray
{
    if (_menuDataArray) {
        return _menuDataArray;
    }
    self.menuDataArray =[[NSMutableArray alloc]init];
    
    return self.menuDataArray;
}


-(NSMutableArray *)tableDataArray
{
    if (_tableDataArray) {
        return _tableDataArray;
    }
    self.tableDataArray = [[NSMutableArray alloc]init];
    
    return self.tableDataArray;
}

-(NSMutableArray *)buttonArray
{
    if (_buttonArray) {
        return _buttonArray;
    }
    self.buttonArray =[[NSMutableArray alloc]init];
    
    return self.buttonArray;
}

-(UIView *)maskBackGroundView
{
    if (_maskBackGroundView) {
        return _maskBackGroundView;
    }
    self.maskBackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, Kscreen_height - self.frame.origin.y)];
    self.maskBackGroundView.backgroundColor=KmaskBackGroundViewColor;
    self.maskBackGroundView.hidden=YES;
    self.maskBackGroundView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskBackGroundViewTapClick)];
    [self.maskBackGroundView addGestureRecognizer:tap];
    
    return self.maskBackGroundView;
}

@end




@implementation downMenuCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configCellView];
    }
    
    return self;
}


-(void)configCellView
{
    self.selectImageView.hidden=YES;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.selectImageView];
}


-(UIImageView *)selectImageView
{
    if (_selectImageView) {
        return _selectImageView;
    }
    
    UIImage *image = [UIImage imageNamed:@"JPullDown.bundle/ok"];
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image=image;
    
    self.selectImageView.frame = CGRectMake(0,0,18,12);
    
    self.selectImageView.center = CGPointMake(Kscreen_width-40, self.frame.size.height/2);
    
    return self.selectImageView;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.textLabel.textColor = HGBlueColor;
        self.backgroundColor =[UIColor whiteColor];
        self.selectImageView.hidden = NO;
    }else
    {
        self.textLabel.textColor = [UIColor blackColor];
        self.selectImageView.hidden = YES;
        self.backgroundColor=[UIColor whiteColor];
    }
}

@end











