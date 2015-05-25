//
//  XBMainWC.m
//  JxbIconMan
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/5/23.
//  Copyright (c) 2015年 Peter Jin  Mail:i@Jxb.name. All rights reserved.
//

#import "XBMainWC.h"
#import "NSImage+Resize.h"


@interface XBMainWC ()

@end

@implementation XBMainWC

- (void)windowWillClose:(NSNotification *)notification {
    [NSApp stopModal];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
}

- (IBAction)btnSelectAction:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setTitle:@"选择png图片"];
    [panel setAllowedFileTypes:@[@"png"]];
    NSWindow* window = [[NSApplication sharedApplication] mainWindow];
    [panel beginSheetModalForWindow:window completionHandler:^(NSModalResponse response){
        if(response == NSModalResponseOK)
        {
            NSURL* file = [panel.URLs objectAtIndex:0];
            txtFile.stringValue = file.relativeString;
        }
    }];
}

- (IBAction)btnGenerateAction:(id)sender {
    if (txtFile.stringValue.length == 0)
    {
        [self showAlert:@"Please choose a source image."];
        return;
    }
    if (ckbCustom.state == 1 && (txtWidth.stringValue.length == 0 || txtHeight.stringValue.length == 0))
    {
        [self showAlert:@"Custom size need width size and height size."];
        return;
    }
    if (ckbApp.state == 0 && ckbCustom.state == 0)
    {
        [self showAlert:@"You must choose one, AppIcon or Custom size"];
        return;
    }
    NSString* toDir = [[[txtFile.stringValue stringByReplacingOccurrencesOfString:@"file:" withString:@""] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"JxbIconMan"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:toDir isDirectory:nil])
        [[NSFileManager defaultManager] createDirectoryAtPath:toDir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString* strFile = [[txtFile.stringValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    NSImage* imgSource = [[NSImage alloc] initWithContentsOfFile:strFile];
    if (ckbApp.state == 1)
    {
        //iphone
        NSString* toDirApp = [toDir stringByAppendingPathComponent:@"iPhone"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:toDirApp isDirectory:nil])
            [[NSFileManager defaultManager] createDirectoryAtPath:toDirApp withIntermediateDirectories:YES attributes:nil error:nil];
        NSArray* iconArr_iphone = @[@58,@80,@87,@120,@180];
        for(NSNumber* size in iconArr_iphone)
        {
            NSString* toFile = [toDirApp stringByAppendingPathComponent:[NSString stringWithFormat:@"AppIcon_%d.png",[size intValue]]];
            [self generateIcon:imgSource size:CGSizeMake([size doubleValue] / 2, [size doubleValue] / 2) toFile:toFile];
        }
        
        //ipad
        toDirApp = [toDir stringByAppendingPathComponent:@"iPad"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:toDirApp isDirectory:nil])
            [[NSFileManager defaultManager] createDirectoryAtPath:toDirApp withIntermediateDirectories:YES attributes:nil error:nil];
        NSArray* iconArr_ipad = @[@29,@40,@58,@76,@80,@152];
        for(NSNumber* size in iconArr_ipad)
        {
            NSString* toFile = [toDirApp stringByAppendingPathComponent:[NSString stringWithFormat:@"AppIcon_%d.png",[size intValue]]];
            [self generateIcon:imgSource size:CGSizeMake([size doubleValue] / 2, [size doubleValue] / 2) toFile:toFile];
        }
        
        //iwatch
        toDirApp = [toDir stringByAppendingPathComponent:@"iWatch"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:toDirApp isDirectory:nil])
            [[NSFileManager defaultManager] createDirectoryAtPath:toDirApp withIntermediateDirectories:YES attributes:nil error:nil];
        NSArray* iconArr_iWatch = @[@48,@55,@58,@87,@80,@88,@172,@196];
        for(NSNumber* size in iconArr_iWatch)
        {
            NSString* toFile = [toDirApp stringByAppendingPathComponent:[NSString stringWithFormat:@"AppIcon_%d.png",[size intValue]]];
            [self generateIcon:imgSource size:CGSizeMake([size doubleValue] / 2, [size doubleValue] / 2) toFile:toFile];
        }
        
        [self showAlert:@"Done."];
    }
    if (ckbCustom.state == 1)
    {
        NSString* toFile = [toDir stringByAppendingPathComponent:@"Custom.png"];
        [self generateIcon:imgSource size:CGSizeMake([txtWidth.stringValue doubleValue] / 2, [txtHeight.stringValue doubleValue] / 2) toFile:toFile];
    }
}

- (void)generateIcon:(NSImage*)imgSource size:(CGSize)size toFile:(NSString*)toFile {
    NSImage* img2 = [imgSource resize:size];
    NSData *data = [img2 TIFFRepresentation];
    [data writeToFile:toFile atomically:YES];

}

- (void)showAlert:(NSString*)str {
    NSAlert* alert = [[NSAlert alloc] init];
    alert.messageText = str;
    [alert runModal];
}

@end
