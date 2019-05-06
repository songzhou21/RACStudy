//
//  ViewController.m
//  RACStudy
//
//  Created by songzhou on 2019/5/6.
//  Copyright © 2019 songzhou. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [RACObserve(self, name) subscribeNext:^(NSString  * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    self.name = @"songzhou";
}


@end
