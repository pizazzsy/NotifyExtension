//
//  ViewController.m
//  推送扩展demo
//
//  Created by 承启通 on 2020/8/11.
//  Copyright © 2020 承启通. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:@"12",@"23",@"34",@"45",@"56", nil];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj=%@--idx=%lu",obj,(unsigned long)idx);
        if ([obj isEqualToString:@"34"]) {
            *stop=YES;
            [tempArray replaceObjectAtIndex:idx withObject:@"100"];
        }
        if (*stop) {
            NSLog(@"tempArray is %@",tempArray);
        }
    }];
       
       
    // Do any additional setup after loading the view.
}


@end
