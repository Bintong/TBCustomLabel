//
//  ViewController.m
//  TBCustomLab
//
//  Created by Bin  Tong on 15/1/29.
//  Copyright (c) 2015年 TongBin. All rights reserved.
//

#import "ViewController.h"
#import "TBCustomLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TBCustomLabel * lable = [[TBCustomLabel alloc]initWithFrame:CGRectZero];
    lable.linesSpacing = 4;
    lable.characterSpacing = 9.0f;
    lable.textCustomColor = [UIColor redColor];//UIColorFromHEX(0x767676);;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:12 ];
    lable.text = @"hahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahahhahah56";
    lable.frame = CGRectMake(40, 100, 200, [lable getAttributedStringHeightWidthValue:200]);
            [self.view addSubview:lable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
