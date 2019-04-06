//
//  KVODemoViewController.m
//  KVODemo
//
//  Created by MAC005 on 2019/4/6.
//  Copyright © 2019年 MAC005. All rights reserved.
//

#import "KVODemoViewController.h"
#import "Person.h"
#import "NSObject+XYSKVO.h"

@interface KVODemoViewController ()

//@property(nonatomic,strong) Person*person;
//@property(nonatomic,strong) Car*car;

@end

@implementation KVODemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person*person=[[Person alloc]init];
    person.name=@"小王";
    [self xyobservedObj:person forKeyPath:@"name" kvoBlock:^{
        NSLog(@"哈哈哈哈");
    }];
    
    person.name=@"小丽";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


///在controller中的回调
@end
