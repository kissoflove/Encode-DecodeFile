//
//  AppDelegate.m
//  EncodeFile
//
//  Created by Weiding on 2016/11/24.
//  Copyright © 2016年 Luxshare-ICT. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (IBAction)choseFile:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    //[panel setDirectory:NSHomeDirectory()];     //默认路径
    [panel setAllowsMultipleSelection:NO];        //多选
    [panel setCanChooseDirectories:NO];           //选择文件夹
    [panel setCanChooseFiles:YES];                //选择文件
    
    //[panel setAllowedFileTypes:@[@"plist"]];    //文件类型
    //[panel setAllowsOtherFileTypes:YES];
    
    if ([panel runModal] == NSModalResponseOK) {
        //NSString *path = [panel.URLs.firstObject path]; //选中的路径
        _txfFile.stringValue = [[panel URL] path];
    }
}

- (IBAction)encode:(id)sender {
    [self encodeFile];
}

- (IBAction)decode:(id)sender {
    [self decodeFile];
}


//加密文件
- (NSArray *)encodeFile
{
    NSString *filePath = _txfFile.stringValue;
    NSString *encodeFilePath = [filePath stringByDeletingLastPathComponent];
    
    if (filePath)
    {
        NSString *str = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:filePath]
                                                 encoding:NSUTF8StringEncoding
                                                    error:NULL];
        if (str)
        {
            NSString *desStr = [DES encryptString:str];
            
            if(desStr)
            {
                
                NSMutableString *exestr = [[NSMutableString alloc] initWithString:[filePath lastPathComponent]];
                [exestr deleteCharactersInRange:[exestr rangeOfString:@".plist"]];
                _txfEncodeFile.stringValue = [NSString stringWithFormat:@"%@/%@",encodeFilePath,exestr];
                
                //[desStr writeToFile:[MHFileTool getLocalFilePath:exestr]
                 [desStr writeToFile:[NSString stringWithFormat:@"%@/%@",encodeFilePath,exestr]
                         atomically:YES
                           encoding:NSUTF8StringEncoding
                              error:NULL];
                
                //NSLog(@"---dest path:%@",[MHFileTool getLocalFilePath:exestr]);
                
            }
        }
    }
    return nil;
}


//解密文件
- (NSArray *)decodeFile
{
    NSString *filePath = _txfFile.stringValue;
    NSString *saveFilePath = [filePath stringByDeletingLastPathComponent];
    if (filePath)
    {
        NSString *str = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:filePath]
                                                 encoding:NSUTF8StringEncoding
                                                    error:NULL];
        if (str)
        {
            NSString *desStr = [DES decryptString:str];
            
            if(desStr)
            {
                NSData *desData = [desStr dataUsingEncoding:NSUTF8StringEncoding];
                NSString *error;
                NSPropertyListFormat format;
                NSArray* plist = [NSPropertyListSerialization propertyListWithData:desData
                                                                           options:NSPropertyListImmutable
                                                                            format:&format
                                                                             error:&error];
                
                //转化为.plist文件
                [MHFileTool createDir:@"test.plist"];
                
                NSLog( @"plist is %@", plist );
                if(!plist){
                    NSLog(@"Error: %@",error);
                }
                return plist;
            }
        }
    }
    return nil;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
