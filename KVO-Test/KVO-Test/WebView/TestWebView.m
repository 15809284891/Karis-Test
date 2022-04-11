//
//  TestWebView.m
//  TACSamples
//
//  Created by karisli(李雪) on 2022/4/7.
//  Copyright © 2022 Tencent. All rights reserved.
//

#import "TestWebView.h"

@implementation TestWebView
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"TestWebView init");
    }
    return self;
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    NSLog(@"TestWebView removeFromSuperview");
}

-(void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    if(hidden){
        NSLog(@"hidden = yes");
    }else{
        NSLog(@"hidden = no");
    }
}
@end
