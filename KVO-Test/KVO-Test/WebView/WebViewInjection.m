//
//  UIWebView+HookSetDelegate.m
//  AOPKit
//
//  Created by karisli(李雪) on 2018/4/9.
//
#import "WebViewInjection.h"
#import "MRLogicInjection.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation WebViewInjection



- (void) removeFromSuperview
{
    SEL curSEL = @selector(removeFromSuperview);
    if (__MRSuperImplatationCurrentCMD__(curSEL)) {
        MRPrepareSendSuper(void);
        
        MRSendSuperSelector(curSEL);
    }
    NSLog(@" stopWebView");
}

- (void) didMoveToSuperview
{
    SEL curSEL = @selector(didMoveToSuperview);

    if (__MRSuperImplatationCurrentCMD__(curSEL)) {
        MRPrepareSendSuper(void);
        MRSendSuperSelector(curSEL);
    }
    NSLog(@"MTAHybrid restartWebView");

}

-(void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    
    if (hidden) {
        NSLog(@"MTAHybrid stopWebView");
    }
    else{
        NSLog(@"MTAHybrid restartWebView");
    }

   
}
@end

