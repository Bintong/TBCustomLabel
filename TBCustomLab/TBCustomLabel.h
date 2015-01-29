//
//  WCCustomLable.h
//  AstonMartin
//
//  Created by Bin  Tong on 14/12/4.
//  Copyright (c) 2014年 zingwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBCustomLabel : UILabel {
//    @private
//    CGFloat characterSpacing_;
//    long linesSpacing;
}

/**
 *  字间距
 */
@property (nonatomic,assign)CGFloat characterSpacing;
/**
 *  行间距
 */
@property (nonatomic,assign)long linesSpacing;
/**
 *  字体颜色
 */
@property (nonatomic,strong)UIColor * textCustomColor;
@property (nonatomic,assign)CGFloat paragraphSpacing;

- (int)getAttributedStringHeightWidthValue:(int)width;

 
@end
 