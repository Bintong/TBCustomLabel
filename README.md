# TBCustomLabel
iOS customLabel subClass UILabel 
##Requirements
ios5+
##Usage
```
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
            
```
###Not
The method of  getAttributedStringHeightWidthValue: is get height base word length and label width . I am Chinese ,so some word note in code in chinese .if you have not understand  send email to yaxun_123@163.com or commit your code .
