HUIGCDDispatchAsync
===================

A simple wrapper around GCD dispatch_async() function to make easily cancellation.


<p><strong>How to use:<strong></p>
<ul><li>0.  Just Drag and Add HUIGCDDispatchAsync.h/m files into your project, and import "HUIGCDDispatchAsync.h"</li></ul>
<ul><li>1.  Dispatch an async block with 'dispatch_async_HUI' function.</li></ul>
<ul><li>2.  Obtain the returned 'HUIBlockFlag' object.</li></ul>
<ul><li>3.  Set the 'HUIBlockFlag' object's cancel property to YES if you want cancel the previous dispatched block.</li></ul>
<ul><li>4.  Within your actual block code, it's your responsibility to check and cancel the block.</li></ul>
    
    
    See the demo for example:
    
    /*
     *  Dispatch an async block with 'dispatch_async_HUI' function
     *  Obtain the returned 'HUIBlockFlag' object if you need cancel the block later, Otherwise, just leave it away.
     */
    HUIBlockFlag *blockFlag = dispatch_async_HUI(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(HUIBlockFlag *flag){
        
        
        /*
         *  while(YES) is just used to simulate an endless async operation.
         */
        while (YES)
        {
            
            
            /*
             *  Within your actual block code, use the 'flag' parameter to check whether need cancel this block
             *  If need cancel, you should clean up and cancel it.
             */
            if (flag.isCancelled)
            {
                goto CancelBlock;
            }
            
            
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"%@ Simulator: Job step costs 1 second ", [NSDate date]);
            
            
            /*
             *  You can increase frequency of the checking operation, to make this block stops ASAP.
             */
            if (flag.isCancelled)
            {
                goto CancelBlock;
            }
            [NSThread sleepForTimeInterval:3.0];
            NSLog(@"%@ Simulator: Job step costs 3 second ", [NSDate date]);
            
            if (flag.isCancelled)
            {
                goto CancelBlock;
            }
            [NSThread sleepForTimeInterval:0.5];
            NSLog(@"%@ Simulator: Job step costs 0.5 second ", [NSDate date]);
            
        }
        
        /* 
         *  If you keep a high frequency of the cancel checking operation. A GOTO label is helpful.
         */
    CancelBlock:
        //Do some clean up operations here
        NSLog(@"Block is cancelled");
        return;
        
    });
    
    
    
    /*  When you want to cancel the async block. Just set the returned 'HUIBlockFlag' object's cancel to YES 
     *  The following code simulates 'cancel the block after 20 seconds'
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [NSThread sleepForTimeInterval:20.00];
        blockFlag.cancel = YES;
        NSLog(@"BlockFlag is set to cancelled");
    });