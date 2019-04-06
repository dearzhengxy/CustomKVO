//
//  NSObject+XYSKVO.m
//  KVODemo
//
//  Created by MAC005 on 2019/4/6.
//  Copyright © 2019年 MAC005. All rights reserved.
//

#import "NSObject+XYSKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef void (^deallocBlock)(void);

@interface KVOController:NSObject
@property(nonatomic,strong) NSMutableArray<deallocBlock>*blockArr;
@end

@implementation KVOController

-(NSMutableArray*)blockArr{
    if (!_blockArr) {
        _blockArr=[NSMutableArray array];
    }
    return _blockArr;
}


-(void)dealloc{
    
    //remove observer
    
    NSLog(@"kvoController dealloc");
    [_blockArr enumerateObjectsUsingBlock:^(deallocBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block();
        }
    }];
}


@end


@interface NSObject()

//这个是保存在contrller里面的
@property(nonatomic,strong)NSMutableDictionary <NSString*,kvoBlock>*dic;

@property(nonatomic,strong)KVOController *kvoController;

@end

@implementation NSObject (XYSKVO)

- (void)xyobservedObj:(NSObject *)object forKeyPath:(NSString *)keyPath kvoBlock:(kvoBlock)block{
    
    
    if (!self.dic[keyPath]) {
        self.dic[keyPath]=block;
    }
    
    __unsafe_unretained typeof(self) weakSelf=self;
    [self.kvoController.blockArr addObject:^{
        [object removeObserver:weakSelf forKeyPath:keyPath];
    }];
    
    //监听
    [object addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    
}

///在controller中的回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    kvoBlock block=self.dic[keyPath];
    if (block) {
        block();
    }
}


//通过关联对象来设置getter和setter方法
-(NSMutableDictionary<NSString *,kvoBlock> *)dic{
    
    NSMutableDictionary*tempDic =objc_getAssociatedObject(self, @selector(dic));
    
    if (!tempDic) {
        tempDic=[NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(dic), tempDic, OBJC_ASSOCIATION_RETAIN);
    }
    
    return tempDic;
}


-(KVOController*)kvoController{
    
    KVOController*tempVC =objc_getAssociatedObject(self, @selector(kvoController));
    
    if (!tempVC) {
        tempVC=[[KVOController alloc]init];
        objc_setAssociatedObject(self, @selector(kvoController), tempVC, OBJC_ASSOCIATION_RETAIN);
    }
    
    return tempVC;
}

@end
