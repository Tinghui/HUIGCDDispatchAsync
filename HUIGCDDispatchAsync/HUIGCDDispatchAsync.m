//
//  HUIGCDDispatchAsync.m
//  HUIGCDDispatchAsync
//
//  Created by ZhangTingHui on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "HUIGCDDispatchAsync.h"

@implementation HUIBlockFlag
@synthesize cancel = _cancel;

+ (id)flag
{
    return [[self alloc] init];
}

@end

HUIBlockFlag* dispatch_async_HUI(dispatch_queue_t queue, HUIBlock_t block)
{
    HUIBlockFlag *flag = [HUIBlockFlag flag];
    dispatch_async(queue, ^(void){
        if (block == nil) 
            return;
        
        block(flag);
    });
    
    return flag;
}
