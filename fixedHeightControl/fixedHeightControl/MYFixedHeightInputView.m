//
//  MYFixedHeightInputView.m
//  fixedHeightControl
//
//  Created by Gguomingyue on 2019/11/21.
//  Copyright © 2019 Gmingyue. All rights reserved.
//  1、上下间距，左右间距 2、行间距 3、高度自适应 4、最大高度

#import "MYFixedHeightInputView.h"

@interface MYFixedHeightInputView ()
{
    CGFloat _initHeight;
    NSInteger lines;
}
@property (nonatomic,strong) UITextView *textView;
/** placeholder的label */
@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic, strong) NSDictionary *textAttributes;

@end

@implementation MYFixedHeightInputView

/** 重写初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 记录初始高度
        _initHeight = frame.size.height;
        self.clipsToBounds = NO;
        lines = 1;
        
        // 添加textView
        self.textView = [[UITextView alloc]initWithFrame:self.bounds];
        [self addSubview:self.textView];
        self.textView.delegate = (id)self;
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.typingAttributes = self.textAttributes;
        self.textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        
        // 添加placeholderLabel
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, frame.size.width - 3, frame.size.height)];
        [self addSubview:self.placeholderLabel];
        self.placeholderLabel.backgroundColor = [UIColor clearColor];
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

// 赋值placeholder
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.center = self.textView.center;
}

// 赋值font
- (void)setFont:(UIFont *)font{
    self.textView.font = self.placeholderLabel.font = font;
    // 重新调整placeholderLabel的大小
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.center = self.textView.center;
}

/** textView文本内容改变时回调 */
- (void)textViewDidChange:(UITextView *)textView{
    // 计算高度
    CGSize size = CGSizeMake(self.textView.frame.size.width - 45, CGFLOAT_MAX);
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.textView.font,NSFontAttributeName, nil];
//    CGFloat curheight = [textView.text boundingRectWithSize:size
//                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                 attributes:dic
//                                                    context:nil].size.height;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:textView.text
    attributes:self.textAttributes];
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(self.textView.frame.size.width - 45, CGFLOAT_MAX)
    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
    context:nil];
    CGFloat curheight = rect.size.height;
    NSInteger currentLines = textView.text.length/(160/17);
    NSInteger mod = (textView.text.length)%(310/17);
    if (mod != 0) {
        currentLines++;
    }
    /*
    if (currentLines == lines) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, self.frame.size.height);
    } else {
        // 重新给frame赋值(改变高度)
        NSInteger distanceLines = currentLines - lines;
        CGFloat height = curheight + 40;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, height);
        lines = currentLines;
    }
     */
    // 重新给frame赋值(改变高度)
    NSInteger distanceLines = currentLines - lines;
    CGFloat height = curheight + 40;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, height);
    //self.textView.typingAttributes = self.textAttributes;
    //self.textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
    /*
    // 如果高度小于初始化时的高度，则不赋值(仍采用最初的高度)
    if (curheight < _initHeight) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _initHeight);
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, _initHeight);
    }else{
        // 重新给frame赋值(改变高度)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, curheight+20);
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, curheight+20);
    }
     */
    
    // 如果文本为空，显示placeholder
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
        self.placeholderLabel.center = self.textView.center;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

-(NSDictionary *)textAttributes
{
    if (!_textAttributes) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8.0f];
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
        _textAttributes = attributes;
    }
    return _textAttributes;
}


@end
