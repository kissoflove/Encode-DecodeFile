//
//  AppDelegate.h
//  EncodeFile
//
//  Created by Weiding on 2016/11/24.
//  Copyright © 2016年 Luxshare-ICT. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MHFileTool.h"
#import "DES.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSTextField *txfFile;
@property (assign) IBOutlet NSTextField *txfEncodeFile;
@property (assign) IBOutlet NSTextField *txfDecodeFile;

@property (assign) IBOutlet NSButton *btnChoose;
@property (assign) IBOutlet NSButton *btnEncode;
@property (assign) IBOutlet NSButton *btnDecode;

@end

