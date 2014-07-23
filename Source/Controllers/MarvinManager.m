//
//  MarvinManager.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 15/07/14.
//
//

#import <ScriptingBridge/SBApplication.h>
#import "Coda2.h"
#import "SystemEvents.h"
#import "CodaManager.h"

#import "MarvinManager.h"
#import "MARSelectionMenu.h"
#import "MARWindowMenu.h"
#import "MARManipulationMenu.h"

@interface MarvinManager ()
@property (nonatomic, strong) CodaManager *codaManager;
@property (nonatomic, strong) dispatch_queue_t bridgeQueue;
@property (nonatomic, strong) SystemEventsProcess *bridge;
@end

@implementation MarvinManager

- (instancetype)initWithPlugInsController:(CodaPlugInsController *)inController
{
    self = [super init];
    if (!self) return nil;
    
    self.pluginController = inController;

    [self registerMenuItems:[MARManipulationMenu new]];
    [self registerMenuItems:[MARSelectionMenu new]];
    [self registerMenuItems:[MARWindowMenu new]];
    
    return self;
}

- (NSString *)name
{
    return MARPlugInName;
}

- (CodaManager *)codaManager
{
    if (_codaManager) return _codaManager;
    
    _codaManager = [CodaManager new];
    _codaManager.pluginController = self.pluginController;
    
    return _codaManager;
}

- (dispatch_queue_t)bridgeQueue
{
    if (_bridgeQueue) return _bridgeQueue;
    
    _bridgeQueue = dispatch_queue_create("ScriptingBridgeQueue", DISPATCH_QUEUE_SERIAL);
    
    return _bridgeQueue;
}

- (SystemEventsProcess *)bridge
{
    if (_bridge) return _bridge;

    _bridge = [[[SBApplication applicationWithBundleIdentifier:@"com.apple.systemevents"] applicationProcesses] objectWithName:@"Coda 2"];
    
    return _bridge;
}

- (void)registerMenuItems:(id)menu
{
    for (MARMenuItem *menuItem in [[menu class] items]) {
        [self.pluginController registerActionWithTitle:menuItem.title underSubmenuWithTitle:menuItem.submenu target:self selector:@selector(execute:) representedObject:menuItem keyEquivalent:menuItem.keyEquivalent pluginName:MARPlugInName];
    }
}

- (void)execute:(id)sender
{
    MARMenuItem *menuItem = ((NSMenuItem *)sender).representedObject;
    menuItem.command(self);
}

- (void)selectLine
{
    NSRange range = [self.codaManager lineContentsRange];
    [self.codaManager setSelectedRange:range];
}

- (void)selectWord
{
    NSRange range = [self.codaManager currentWordRange];
    [self.codaManager setSelectedRange:range];
}

- (void)selectPreviousWord
{
    NSRange range = [self.codaManager previousWordRange];
    [self.codaManager setSelectedRange:range];
    range = [self.codaManager currentWordRange];
    [self.codaManager setSelectedRange:range];
}

- (void)selectWordAbove
{
    NSRange preRange = [self.codaManager selectedRange];
    
    if (!self.codaManager.selectedRange.length) {
        [self selectWord];
    } else {
        CGEventRef event = CGEventCreateKeyboardEvent(NULL, 126, true);
        CGEventSetFlags(event, 0);
        CGEventPost(kCGHIDEventTap, event);
        CFRelease(event);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSUInteger lineNumber = [self.codaManager currentLineNumber];
            [self selectWord];
            
            NSRange postRange = [self.codaManager selectedRange];
            if ((preRange.location == postRange.location 
            &&  preRange.length == postRange.length) 
            &&  lineNumber != [self.codaManager currentLineNumber]) {
                [self selectPreviousWord];
            }
        });
    }
}

- (void)selectWordBelow
{
    CGEventRef event = CGEventCreateKeyboardEvent(NULL, 125, true);
    CGEventSetFlags(event, 0);
    CGEventPost(kCGHIDEventTap, event);
    CFRelease(event);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self selectWord];
    });
}

- (void)deleteLine
{
    NSRange range = [self.codaManager lineRange];
    [self.codaManager beginUndoGrouping];
    [self.codaManager replaceCharactersInRange:range withString:@""];
    [self.codaManager endUndoGrouping];
}

- (void)duplicateLine
{
    NSRange range = [self.codaManager lineRange];
    [self.codaManager beginUndoGrouping];
    NSString *string = [self.codaManager contentsOfRange:range];
    NSRange duplicateRange = NSMakeRange(range.location+range.length, 0);
    [self.codaManager replaceCharactersInRange:duplicateRange withString:string];
    NSRange selectRange = NSMakeRange(duplicateRange.location + duplicateRange.length + string.length - 1, 0);
    [self.codaManager setSelectedRange:selectRange];
    [self.codaManager endUndoGrouping];
}

- (void)joinLine
{
    NSRange range = [self.codaManager joinRange];
    [self.codaManager replaceCharactersInRange:range withString:@""];
}

- (void)uppercase
{
	[self.codaManager uppercase];
}

- (void)lowercase
{
    [self.codaManager lowercase];
}

- (void)openInNewWindow
{
    dispatch_async(self.bridgeQueue,^{
        [[[[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"File"] menuItems] objectWithName:@"New Window"] clickAt:nil];
        [[[[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"View"] menuItems] objectWithName:@"Editor"] clickAt:nil];
        [[[[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"View"] menuItems] objectWithName:@"Hide Sidebar"] clickAt:nil];
    });
}

- (void)moveToNewWindow
{
    
}

- (void)splitViewHorizontally
{
    dispatch_async(self.bridgeQueue,^{
        NSArray *menuItems = [[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"View"] menuItems];
        if (menuItems) {
            SystemEventsMenuItem *find = [[[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"Edit"] menuItems] objectWithName:@"Find"];
            [[[[[find menus] lastObject] menuItems] objectWithName:@"Hide Find Banner"] clickAt:nil];
            [[menuItems objectAtIndex:22] clickAt:nil];
            [[[[[find menus] lastObject] menuItems] objectWithName:@"Jump to Selection"] clickAt:nil];
        }
    });
}


- (void)splitViewVertically
{
    dispatch_async(self.bridgeQueue,^{
        NSArray *menuItems = [[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"View"] menuItems];
        if (menuItems) {
            SystemEventsMenuItem *find = [[[[[[self.bridge menuBars] lastObject] menus] objectWithName:@"Edit"] menuItems] objectWithName:@"Find"];
            [[[[[find menus] lastObject] menuItems] objectWithName:@"Hide Find Banner"] clickAt:nil];
            [[menuItems objectAtIndex:23] clickAt:nil];
            [[[[[find menus] lastObject] menuItems] objectWithName:@"Jump to Selection"] clickAt:nil];
        }
    });
}

@end
