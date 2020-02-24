//
//  ViewController.m
//  fixedHeightControl
//
//  Created by Gguomingyue on 2019/11/21.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "MYFixedHeightInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MYFixedHeightInputView *textView = [[MYFixedHeightInputView alloc]initWithFrame:CGRectMake(0, 90, 350, 55)];
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor redColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"ss";
    
}


@end
