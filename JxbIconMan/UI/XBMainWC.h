//
//  XBMainWC.h
//  JxbIconMan
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/5/23.
//  Copyright (c) 2015年 Peter Jin  Mail:i@Jxb.name. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XBMainWC : NSWindowController
{
    IBOutlet NSTextField*   txtFile;
    IBOutlet NSTextField*   txtWidth;
    IBOutlet NSTextField*   txtHeight;
    
    IBOutlet NSButton*      ckbApp;
    IBOutlet NSButton*      ckbCustom;
    
}
- (IBAction)btnSelectAction:(id)sender;
- (IBAction)btnGenerateAction:(id)sender;
@end
