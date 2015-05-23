//
//  JxbIconMan.m
//  JxbIconMan
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/5/23.
//  Copyright (c) 2015年 Peter Jin  Mail:i@Jxb.name. All rights reserved.
//

#import "JxbIconMan.h"
#import "NSImage+Resize.h"
#import "XBMainWC.h"

@interface JxbIconMan()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation JxbIconMan

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    // Create menu items, initialize UI, etc.
    
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Window"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Jxb IconMan" action:@selector(doMenuAction) keyEquivalent:@"I"];
        [actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    XBMainWC* mainWC = [[XBMainWC alloc] initWithWindowNibName:@"XBMainWC"];
    
    [[NSApplication sharedApplication] runModalForWindow:mainWC.window];
    
    
//    NSOpenPanel *panel = [NSOpenPanel openPanel];
//    [panel setTitle:@"选择png文件"];
//    [panel setAllowedFileTypes:@[@"png"]];
//    NSWindow* window = [[NSApplication sharedApplication] mainWindow];
//    [panel beginSheetModalForWindow:window completionHandler:^(NSModalResponse response){
//        if(response == NSModalResponseOK)
//        {
//            NSURL* file = [panel.URLs objectAtIndex:0];
//            NSImage* img = [[NSImage alloc] initWithContentsOfURL:file];
//            NSImage* img2 = [img resize:CGSizeMake(30, 20)];
//            NSString* tofile = @"/Users/Peter/Desktop/222.png";
//            NSData *data = [img2 TIFFRepresentation];
//            [data writeToFile:tofile atomically:YES];
//        }
//    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
