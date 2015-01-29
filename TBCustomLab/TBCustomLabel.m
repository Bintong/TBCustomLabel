//
//  WCCustomLable.m
//  AstonMartin
//
//  Created by Bin  Tong on 14/12/4.
//  Copyright (c) 2014年 zingwin. All rights reserved.
//

#import "TBCustomLabel.h"
#import <CoreText/CoreText.h>
#define UIColorFromHEX(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TBCustomLabel () {
    @private
    NSMutableAttributedString * attributedString;
}

- (void)initAttributedString;
@end

@implementation TBCustomLabel


@synthesize characterSpacing = characterSpacing_;

@synthesize linesSpacing = linesSpacing_;

-(id) initWithFrame:(CGRect)frame
{
    //初始化字间距、行间距
    if(self =[super initWithFrame:frame])
        
    {
        self.characterSpacing = 1.5f;
        self.linesSpacing = 4.0f;
    }
    
    return self;
}

//外部调用设置字间距
-(void)setCharacterSpacing:(CGFloat)characterSpacing
{
    characterSpacing_ = characterSpacing;
    [self setNeedsDisplay];
}

//外部调用设置行间距
-(void)setLinesSpacing:(long)linesSpacing
{
    linesSpacing_ = linesSpacing;
    [self setNeedsDisplay];
}

-(void)setTextCustomColor:(UIColor *)textCustomColor {
     _textCustomColor = textCustomColor;
    [self setNeedsDisplay];
}

/*
 *初始化AttributedString并进行相应设置
 */
- (void) initAttributedString
{
    
    if(attributedString==nil){
        //去掉空行
        NSString *labelString = self.text;
        NSString *myString = [labelString stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
        
        //创建AttributeString
        attributedString =[[NSMutableAttributedString alloc]initWithString:myString];
        
        //设置字体及大小
        CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
        [attributedString addAttribute:(id)kCTFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,[attributedString length])];
        
//        //设置字间距
        
         if(self.characterSpacing)
         {
             long number = self.characterSpacing;
             CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
             [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
             CFRelease(num);
         }else {
             long number = 1.5f;
             CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
             [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
             CFRelease(num);

         }
         
        
//        设置字体颜色//set custom Color UIColorFromHEX(0x767676)
        if (self.textCustomColor) {
            [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(_textCustomColor.CGColor) range:NSMakeRange(0,[attributedString length])];
        }else {
            [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(UIColorFromHEX(0x767676).CGColor) range:NSMakeRange(0,[attributedString length])];
            
        }
        
        //创建文本对齐方式
        CTTextAlignment alignment = kCTLeftTextAlignment;
        if(self.textAlignment == NSTextAlignmentCenter)
        {
            alignment = kCTCenterTextAlignment;
        }
        if(self.textAlignment == NSTextAlignmentRight)
        {
            alignment = kCTRightTextAlignment;
        }
        
        CTParagraphStyleSetting alignmentStyle;
        
        alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
        
        alignmentStyle.valueSize = sizeof(alignment);
        
        alignmentStyle.value = &alignment;
        
        //设置文本行间距
        
         CGFloat lineSpace = self.linesSpacing;
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
        lineSpaceStyle.valueSize = sizeof(lineSpace);
        lineSpaceStyle.value =&lineSpace;
        
        //设置文本段间距
//        self.paragraphSpacing == 0 ? 4.0 :self.paragraphSpacing;
        CGFloat paragraphSpacing = 4.0;
        CTParagraphStyleSetting paragraphSpaceStyle;
        paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
        paragraphSpaceStyle.valueSize = sizeof(CGFloat);
        paragraphSpaceStyle.value = &_paragraphSpacing;
        
        //创建设置数组
        CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
        CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,3);
        
        //给文本添加设置//arc
        [attributedString addAttribute:(__bridge NSString *)kCTParagraphStyleAttributeName value:CFBridgingRelease(style) range:NSMakeRange(0 , [attributedString length])];
        CFRelease(helveticaBold);
    }

}

/*
 *覆写setText方法
 */
- (void) setText:(NSString *)text
{
    [super setText:text];
    [self initAttributedString];
}
 

/*
 *开始绘制
 */
-(void) drawTextInRect:(CGRect)requestedRect
{
    [self initAttributedString];
 
    //排版
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //画出文本
    
    CTFrameDraw(leftFrame,context);
    
    //释放
    
    CGPathRelease(leftColumnPath);
    
    CFRelease(framesetter);
    
    UIGraphicsPushContext(context);
}

/*
 *绘制前获取label高度
 */
- (int)getAttributedStringHeightWidthValue:(int)width
{
    if (attributedString == nil) {
        return 0;
    }
    [self initAttributedString];
    
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;//+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
    
}

@end