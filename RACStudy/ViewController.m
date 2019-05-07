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

typedef void(^SZKVOChangeBlock)(id _Nullable value);

@interface NSObject (SZKVO)

- (void)sz_observeKeyPath:(NSString *)keyPath block:(NS_NOESCAPE SZKVOChangeBlock)block;

@end

@implementation NSObject (SZKVO)

- (void)sz_observeKeyPath:(NSString *)keyPath block:(NS_NOESCAPE SZKVOChangeBlock)block {
    NSParameterAssert(block);
    
    [self.KVOControllerNonRetaining observe:self keyPath:keyPath options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        id newValue = change[NSKeyValueChangeNewKey];

        block([newValue isEqual:[NSNull null]] ? nil : newValue);
    }];
}

@end

@interface FBKVOController (SZKVO)

- (void)observe:(nullable id)object keyPath:(NSString *)keyPath onChange:(NS_NOESCAPE SZKVOChangeBlock)block;

@end

@implementation FBKVOController (SZKVO)

- (void)observe:(nullable id)object keyPath:(NSString *)keyPath onChange:(NS_NOESCAPE SZKVOChangeBlock)block {
    NSParameterAssert(block);
    
    [self observe:object
          keyPath:keyPath
          options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
            block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
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
    
    
//    [self sz_observeKeyPath:FBKVOKeyPath(self.name) block:^(id  _Nullable value) {
//        NSLog(@"kvo-controller: %@", value);
//    }];
    
    
    [self.KVOControllerNonRetaining observe:self keyPath:FBKVOKeyPath(self.name) onChange:^(id  _Nullable value) {
         NSLog(@"kvo-controller: %@", value);
    }];
    
//    [self.KVOControllerNonRetaining observe:self keyPath:FBKVOKeyPath(self.name) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        NSLog(@"kvo-controller: %@", change[NSKeyValueChangeNewKey]);
//    }];
    
    self.name = @"songzhou";
}

@end
