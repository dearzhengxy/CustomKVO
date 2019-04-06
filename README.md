# CustomKVO
通过分类以block回调的方式封装KVO，监听对象的controller销毁后会自动remove observer，简单易用。
封装的时候发现不太好监控监听对象的controller的释放，所以通过监听这个controller的成员对象的dealloc方法，在成员对象的dealloc方法里面去remove observer

使用方式：

以监听Person对象的属性name为例：
  Person*person=[[Person alloc]init];
  person.name=@"小王";

 [self xyobservedObj:person forKeyPath:@"name" kvoBlock:^{
        NSLog(@"哈哈哈哈");
    }];
