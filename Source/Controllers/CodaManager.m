//
//  CodaManager.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 15/07/14.
//
//

#import "CodaManager.h"
#import "NSString+Reverse.h"

@interface CodaManager ()
@property (nonatomic, weak) CodaTextView *textView;
@end

@implementation CodaManager

- (CodaTextView *)textView
{
    if (self.pluginController) {
        return [self.pluginController focusedTextView];
    }
    return nil;
}

- (NSString *)contents
{
    return [self.textView string];
}

- (NSUInteger)documentLength
{
    return [[self contents] length];
}

- (NSUInteger)currentLineNumber
{
    return [self.textView currentLineNumber];
}

- (NSRange)selectedRange
{
    return self.textView.selectedRange;
}

- (NSRange)currentWordRange
{
    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_"];
    NSCharacterSet *spaceSet = [NSCharacterSet characterSetWithCharactersInString:@"#-<>/(){}[],;:. \n`*\"'"];
    NSRange selectedRange = [self selectedRange];

    char character;
    if ([self hasSelection]) {
        character = [[self contents] characterAtIndex:selectedRange.location+selectedRange.length];
    } else {
        character = [[self contents] characterAtIndex:selectedRange.location];
    }

    if (![validSet characterIsMember:character]) {
        selectedRange = (NSRange) { .location = selectedRange.location + selectedRange.length };
    }

    NSScanner *scanner = [NSScanner scannerWithString:[self contents]];
    [scanner setScanLocation:selectedRange.location];

    NSUInteger length = selectedRange.location;

    while (!scanner.isAtEnd) {
        if ([scanner scanCharactersFromSet:validSet intoString:nil]) {
            length = [scanner scanLocation];
            break;
        }
        [scanner setScanLocation:[scanner scanLocation] + 1];
    }

    NSUInteger location = ([[self contents] rangeOfCharacterFromSet:spaceSet options:NSBackwardsSearch range:NSMakeRange(0,length)].location +1);

    return NSMakeRange(location,length-location);
}

- (NSRange)previousWordRange
{
    NSRange selectedRange = [self selectedRange];

    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_"];

    NSUInteger location = ([[self contents] rangeOfCharacterFromSet:validSet options:NSBackwardsSearch range:NSMakeRange(0,selectedRange.location)].location);

    return NSMakeRange(location,0);
}

- (void)setSelectedRange:(NSRange)range
{
    [self.textView setSelectedRange:range];
}

- (NSRange)lineContentsRange
{
    NSRange selectedRange = [self selectedRange];
    NSCharacterSet *newlineSet = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
    NSUInteger startOfLine = ([[self contents] rangeOfCharacterFromSet:newlineSet options:NSBackwardsSearch range:NSMakeRange(0,selectedRange.location)].location);

    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_!\"#€%&/()=?`<>@£$∞§|[]≈±´¡”¥¢‰¶\{}≠¿`~^*+-;"];

    NSUInteger location = ([[self contents] rangeOfCharacterFromSet:validSet options:NSCaseInsensitiveSearch range:NSMakeRange(startOfLine,[self documentLength]-startOfLine)].location);

    NSUInteger length = ([[self contents] rangeOfCharacterFromSet:newlineSet options:NSCaseInsensitiveSearch range:NSMakeRange(selectedRange.location+selectedRange.length,[self contents].length-(selectedRange.location+selectedRange.length))].location);

    if (length-location < [self documentLength]) {
        return NSMakeRange(location, length-location);
    } else {
        return NSMakeRange(selectedRange.location, 0);
    }
}

- (NSRange)lineRange
{
    NSRange selectedRange = [self selectedRange];
    NSCharacterSet *newlineSet = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
    NSUInteger location = ([[self contents] rangeOfCharacterFromSet:newlineSet options:NSBackwardsSearch range:NSMakeRange(0,selectedRange.location)].location);

    NSUInteger length = ([[self contents] rangeOfCharacterFromSet:newlineSet options:NSCaseInsensitiveSearch range:NSMakeRange(selectedRange.location+selectedRange.length,[self contents].length-(selectedRange.location+selectedRange.length))].location);

    return NSMakeRange(location+1, length-location);
}

- (void)beginUndoGrouping
{
    [self.textView beginUndoGrouping];
}

- (void)endUndoGrouping
{
    [self.textView endUndoGrouping];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string
{
    [self.textView replaceCharactersInRange:range withString:string];
}

- (NSString *)contentsOfRange:(NSRange)range
{
    return [[self contents] substringWithRange:range];
}

- (NSRange)joinRange
{
    NSRange lineRange = [self lineRange];
    NSRange joinRange = (NSRange) { .location = lineRange.location + lineRange.length - 1 };

    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_!\"#€%&/()=?`<>@£$∞§|[]≈±´¡”¥¢‰¶\{}≠¿`~^*+-;"];

    NSUInteger length = ([[self contents] rangeOfCharacterFromSet:validSet options:NSCaseInsensitiveSearch range:NSMakeRange(joinRange.location,[self contents].length-joinRange.location)].location);



    return NSMakeRange(joinRange.location, length - joinRange.location);
}

- (NSString*)currentLine
{
    return [self.textView currentLine];
}

- (void)insertText:(NSString *)string
{
    [self.textView insertText:string];
}

- (void)save
{
    [self.textView save];
}

- (NSString *)selectedText
{
    return [self.textView selectedText];
}

- (BOOL)hasSelection
{
    return (self.textView.selectedText.length) ? YES : NO;
}

- (BOOL)emptySelection
{
    return (self.textView.selectedText.length) ? NO : YES;
}

- (void)getLine:(NSInteger*)line column:(NSInteger*)column
{
    [self.textView getLine:line column:column];
}

- (void)goToLine:(NSInteger)line column:(NSInteger)column
{
    [self.textView goToLine:line column:column];
}

- (NSString *)filename
{
    return [self.textView filename];
}

- (NSString *)path
{
    return [self.textView path];
}

- (NSInteger)tabWidth
{
    return [self.textView tabWidth];
}

- (NSRange)selectScope:(NSString *)delimiter
{

    if ([self hasSelection]) return [self selectedRange];

    NSCharacterSet *startDelimiter = [NSCharacterSet characterSetWithCharactersInString:[delimiter substringToIndex:1]];
    NSCharacterSet *endDelimiter = [NSCharacterSet characterSetWithCharactersInString:[delimiter substringFromIndex:1]];
    NSCharacterSet *abortSet = [NSCharacterSet characterSetWithCharactersInString:@";=/#,"];
    NSRange currentRange = [self selectedRange];
    NSUInteger length = currentRange.location;
    NSScanner *scanner = [NSScanner scannerWithString:[self contents]];
    [scanner setScanLocation:length];
    unichar character = [[self contents] characterAtIndex:[scanner scanLocation]];
    NSUInteger location = currentRange.location;

    if ([endDelimiter characterIsMember:[[self contents] characterAtIndex:location-1]]) {
        --location;
        character = [[self contents] characterAtIndex:location];
        [scanner setScanLocation:location];
    }

    if ([endDelimiter characterIsMember:character]) {
        [scanner setScanLocation:[scanner scanLocation]];
        --location;
    }

    character = [[self contents] characterAtIndex:location];
    int matches = 1;

    while (location > 0) {
        character = [[self contents] characterAtIndex:location];

        if ([abortSet characterIsMember:character]) return [self selectedRange];
        if ([startDelimiter characterIsMember:character]) matches -= 1;
        if (matches == 0) break;
        if ([endDelimiter characterIsMember:character])   matches += 1;

        --location;
    }

    while (!scanner.isAtEnd) {
        character = [[self contents] characterAtIndex:[scanner scanLocation]];

        if ([scanner scanCharactersFromSet:abortSet intoString:nil])
            return [self selectedRange];
        if ([endDelimiter characterIsMember:character]) break;

        [scanner setScanLocation:[scanner scanLocation] + 1];
    }
    length = [scanner scanLocation];

    return NSMakeRange(location, (length-location)+1);
}

- (NSString*)currentLine
{
    return [self.textView currentLine];
}

- (void)insertText:(NSString *)string
{
    [self.textView insertText:string];
}

- (void)save
{
    [self.textView save];
}

- (NSString *)selectedText
{
    return [self.textView selectedText];
}

- (void)getLine:(NSInteger*)line column:(NSInteger*)column
{
    [self.textView getLine:line column:column];
}

- (void)goToLine:(NSInteger)line column:(NSInteger)column
{
    [self.textView goToLine:line column:column];
}

- (NSString *)filename
{
    return [self.textView filename];
}

- (NSString *)path
{
    return [self.textView path];
}

@end
