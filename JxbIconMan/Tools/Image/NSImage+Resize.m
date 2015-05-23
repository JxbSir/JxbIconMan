//
//  NSImage+Resize.m
//  JxbIconMan
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/5/23.
//  Copyright (c) 2015年 Peter Jin  Mail:i@Jxb.name. All rights reserved.
//

#import "NSImage+Resize.h"


@implementation NSImage (Resize)

- (NSImage*)resize:(CGSize)size {
    CGImageRef imageRef = [self nsImageToCGImageRef];
    return [self imageFromCGImageRef:imageRef size:size];
}

- (CGImageRef)nsImageToCGImageRef
{
    NSData * imageData = [self TIFFRepresentation];
    CGImageRef imageRef;
    if(imageData)
    {
        CGImageSourceRef imageSource =
        CGImageSourceCreateWithData((CFDataRef)imageData,  NULL);
        imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    }
    return imageRef;
}


- (NSImage*)imageFromCGImageRef:(CGImageRef)image size:(CGSize)size

{
    NSRect imageRect = NSMakeRect(0.0, 0.0, size.width, size.height);
    CGContextRef imageContext = nil;
    NSImage* newImage = nil;
    // Create a new image to receive the Quartz image data.
    newImage = [[NSImage alloc] initWithSize:imageRect.size];
    [newImage lockFocus];
    // Get the Quartz context and draw.
    imageContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextDrawImage(imageContext, *(CGRect*)&imageRect, image);
    [newImage unlockFocus];
    return newImage;
}

@end
