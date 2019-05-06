//
//  ViewController.m
//  RACStudy
//
//  Created by songzhou on 2019/5/6.
//  Copyright © 2019 songzhou. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <KVOController/KVOController.h>

@interface NSObject (SZKVO)

- (void)sz_observeKeyPath:(NSString *)keyPath block:(NS_NOESCAPE void(^)(id value))block;

@end

@implementation NSObject (SZKVO)

- (void)sz_observeKeyPath:(NSString *)keyPath block:(NS_NOESCAPE void(^)(id value))block {
    NSParameterAssert(block);
    
    __weak __typeof__(block) weak_block = block;
    [self.KVOControllerNonRetaining observe:self keyPath:keyPath options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        __strong __typeof__(weak_block) block = weak_block;

        id newValue = change[NSKeyValueChangeNewKey];

        block([newValue isEqual:[NSNull null]] ? nil : newValue);
    }];
}

@end

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"observe" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
}

- (void)next {
//    [RACObserve(self, name) subscribeNext:^(NSString  * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    
    [self sz_observeKeyPath:@"name" block:^(id value) {
        NSLog(@"kvo-controller: %@", value);
    }];
    
//    [self.KVOControllerNonRetaining observe:self keyPath:@"name" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        NSLog(@"kvo-controller: %@", change[NSKeyValueChangeNewKey]);
//    }];
//    
    self.name = @"songzhou";
}

@end
