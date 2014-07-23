//
//  MarvinManager.h
//  Marvin
//
//  Created by Christoffer Winterkvist on 15/07/14.
//
//

#import <Foundation/Foundation.h>
#import "CodaPlugInsController.h"

@interface MarvinManager : NSObject
@property (nonatomic, strong) CodaPlugInsController *pluginController;

- (instancetype)initWithPlugInsController:(CodaPlugInsController *)inController;

- (void)selectLine;
- (void)selectWord;
- (void)selectPreviousWord;
- (void)selectWordAbove;
- (void)selectWordBelow;
- (void)deleteLine;
- (void)duplicateLine;
- (void)joinLine;
- (void)uppercase;
- (void)lowercase;
- (void)openInNewWindow;
- (void)moveToNewWindow;
- (void)splitViewHorizontally;
- (void)splitViewVertically;

@end
