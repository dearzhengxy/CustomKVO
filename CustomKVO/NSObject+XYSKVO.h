//
//  NSObject+XYSKVO.h
//  KVODemo
//
//  Created by MAC005 on 2019/4/6.
//  Copyright © 2019年 MAC005. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void (^kvoBlock)(void);

@interface NSObject (XYSKVO)

- (void)xyobservedObj:(NSObject *)object forKeyPath:(NSString *)keyPath kvoBlock:(kvoBlock)block;

@end
