//
//  MARMenuItem.h
//  Marvin
//
//  Created by Christoffer Winterkvist on 14/07/14.
//
//

#import <Foundation/Foundation.h>
#import "MarvinManager.h"

@interface MARMenuItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *submenu;
@property (nonatomic, strong) NSString *keyEquivalent;
@property (nonatomic, copy) void (^command)();

- (instancetype)initWithTitle:(NSString *)title submenu:(NSString *)submenu keyEquivalent:(NSString *)binding command:(void (^)(MarvinManager *manager))command;
+ (NSArray *)items;

@end
