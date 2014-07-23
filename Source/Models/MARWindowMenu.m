//
//  MARWindowMenu.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 16/07/14.
//
//

#import "MARWindowMenu.h"

@implementation MARWindowMenu

+ (NSArray *)items
{
    NSMutableArray *items = [NSMutableArray array];
    
    MARMenuItem *newWindow = [[MARMenuItem alloc] initWithTitle:@"Open in New Window"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@"@N"
                                                         command:^(MarvinManager *manager){
                                                             [manager openInNewWindow];
                                                         }];
    [items addObject:newWindow];
    
    MARMenuItem *moveToNewWindow = [[MARMenuItem alloc] initWithTitle:@"Move to New Window"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@"~@N"
                                                         command:^(MarvinManager *manager){
                                                             [manager moveToNewWindow];
                                                         }];
    [items addObject:moveToNewWindow];
    
    
    MARMenuItem *splitViewVertically = [[MARMenuItem alloc] initWithTitle:@"Split Vertically"
                                                                    submenu:[self.class menuTitle]
                                                              keyEquivalent:@"^v"
                                                                    command:^(MarvinManager *manager){
                                                                        [manager splitViewVertically];
                                                                    }];
    [items addObject:splitViewVertically];
    
    MARMenuItem *splitViewHorizontally = [[MARMenuItem alloc] initWithTitle:@"Split Horizontally"
                                                        submenu:[self.class menuTitle]
                                                  keyEquivalent:@"@S"
                                                        command:^(MarvinManager *manager){
                                                            [manager splitViewHorizontally];
                                                        }];
    [items addObject:splitViewHorizontally];
    
    
    
    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Window";
}

@end
