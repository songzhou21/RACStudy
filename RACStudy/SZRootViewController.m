//
//  SZRootViewController.m
//  RACStudy
//
//  Created by songzhou on 2019/5/6.
//  Copyright © 2019 songzhou. All rights reserved.
//

#import "SZRootViewController.h"
#import "ViewController.h"

@interface SZRootViewController ()

@end

@implementation SZRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
}

- (void)next {
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}
@end
