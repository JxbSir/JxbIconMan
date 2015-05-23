//
//  NSObject_Extension.m
//  JxbIconMan
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/5/23.
//  Copyright (c) 2015年 Peter Jin  Mail:i@Jxb.name. All rights reserved.
//


#import "NSObject_Extension.h"
#import "JxbIconMan.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[JxbIconMan alloc] initWithBundle:plugin];
        });
    }
}
@end
