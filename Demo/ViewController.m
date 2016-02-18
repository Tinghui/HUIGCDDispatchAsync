//
//  ViewController.m
//  Demo
//
//  Created by ZhangTingHui on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "HUIGCDDispatchAsync.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
/*
 *  Dispatch an async block with 'dispatch_async_HUI' function
 *  Keep the returned 'HUIBlockFlag' object if you need cancel the block later, Otherwise, just leave it away.
 */
HUIBlockFlag *blockFlag = dispatch_async_HUI(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(HUIBlockFlag *flag){
    
    
    /*
     *  Use while(YES) to simulate an endless async operation.
     */
    while (YES)
    {
        
        
        /*
         *  Inside your actual block code, use the 'flag' parameter to check whether need to cancel current block operation.
         *  If need cancel, you should clean up and return.
         */
        if (flag.isCancelled)
        {
            goto CancelBlock;
        }
        
        
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"%@ Simulator: Job step costs 1 second ", [NSDate date]);
        
        
        /*
         *  You can increase frequency of the checking operation, to make current block stops ASAP.
         */
        if (flag.isCancelled)
        {
            goto CancelBlock;
        }
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"%@ Simulator: Job step costs 3 seconds ", [NSDate date]);
        
        if (flag.isCancelled)
        {
            goto CancelBlock;
        }
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"%@ Simulator: Job step costs 0.5 seconds ", [NSDate date]);
        
    }
    
    /* 
     *  If you keep a high frequency of the cancel checking operation. A GOTO label is helpful.
     */
CancelBlock:
    NSLog(@"Clean up and return, Block is cancelled");
    return;
    
});



/*  When you want to cancel the async block. Just set the returned 'HUIBlockFlag' object's cancel to YES 
 *  The following codes simulate 'cancel the block after 20 seconds'
 */
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    [NSThread sleepForTimeInterval:20.00];
    blockFlag.cancel = YES;
    NSLog(@"BlockFlag is set to cancelled");
});
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
