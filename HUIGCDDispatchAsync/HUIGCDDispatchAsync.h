//
//  HUIGCDDispatchAsync.h
//  HUIGCDDispatchAsync
//
//  Created by ZhangTingHui on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>


@interface HUIBlockFlag : NSObject
@property (assign, getter = isCancelled) BOOL cancel;

+ (id)flag;
@end

typedef void (^HUIBlock_t)(HUIBlockFlag *blockFlag);

HUIBlockFlag* dispatch_async_HUI(dispatch_queue_t queue, HUIBlock_t block);
