//
//  JxbIconMan.h
//  JxbIconMan
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/5/23.
//  Copyright (c) 2015年 Peter Jin  Mail:i@Jxb.name. All rights reserved.
//

#import <AppKit/AppKit.h>

@class JxbIconMan;

static JxbIconMan *sharedPlugin;

@interface JxbIconMan : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end