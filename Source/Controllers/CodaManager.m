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
    return [[self.textView string] length];
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
    NSRange selectedRange = self.textView.selectedRange;

    char character;
    if (selectedRange.length > 0) {
        character = [self.textView.string characterAtIndex:selectedRange.location+selectedRange.length];
    } else {
        character = [self.textView.string characterAtIndex:selectedRange.location];
    }

    if (![validSet characterIsMember:character]) {
        selectedRange = (NSRange) { .location = selectedRange.location + selectedRange.length };
    }


    NSScanner *scanner = [NSScanner scannerWithString:self.textView.string];
    [scanner setScanLocation:selectedRange.location];

    NSUInteger length = selectedRange.location;

    while (!scanner.isAtEnd) {
        if ([scanner scanCharactersFromSet:validSet intoString:nil]) {
            length = [scanner scanLocation];
            break;
        }
        [scanner setScanLocation:[scanner scanLocation] + 1];
    }

    NSUInteger location = ([self.textView.string rangeOfCharacterFromSet:spaceSet options:NSBackwardsSearch range:NSMakeRange(0,length)].location +1);

    return NSMakeRange(location,length-location);
}

- (NSRange)previousWordRange
{
    NSRange selectedRange = self.textView.selectedRange;

    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_"];

    NSUInteger location = ([self.textView.string rangeOfCharacterFromSet:validSet options:NSBackwardsSearch range:NSMakeRange(0,selectedRange.location)].location);

    return NSMakeRange(location,0);
}

- (void)setSelectedRange:(NSRange)range
{
    [self.textView setSelectedRange:range];
}

- (NSRange)lineContentsRange
{
    NSRange range;
    NSRange selectedRange = self.textView.selectedRange;
    NSCharacterSet *newlineSet = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
    NSUInteger startOfLine = ([self.textView.string rangeOfCharacterFromSet:newlineSet options:NSBackwardsSearch range:NSMakeRange(0,selectedRange.location)].location);

    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_!\"#€%&/()=?`<>@£$∞§|[]≈±´¡”¥¢‰¶\{}≠¿`~^*+-;"];

    NSUInteger location = ([self.textView.string rangeOfCharacterFromSet:validSet options:NSCaseInsensitiveSearch range:NSMakeRange(startOfLine,self.textView.string.length-startOfLine)].location);

    NSUInteger length = ([self.textView.string rangeOfCharacterFromSet:newlineSet options:NSCaseInsensitiveSearch range:NSMakeRange(selectedRange.location+selectedRange.length,self.textView.string.length-(selectedRange.location+selectedRange.length))].location);

    if (length-location < [self documentLength]) {
        range = NSMakeRange(location, length-location);
    } else {
        range = NSMakeRange(selectedRange.location, 0);
    }

    return range;
}

- (NSRange)lineRange
{
    NSRange selectedRange = self.textView.selectedRange;
    NSCharacterSet *newlineSet = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
    NSUInteger location = ([self.textView.string rangeOfCharacterFromSet:newlineSet options:NSBackwardsSearch range:NSMakeRange(0,selectedRange.location)].location);

    NSUInteger length = ([self.textView.string rangeOfCharacterFromSet:newlineSet options:NSCaseInsensitiveSearch range:NSMakeRange(selectedRange.location+selectedRange.length,self.textView.string.length-(selectedRange.location+selectedRange.length))].location);

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
    return [self.textView.string substringWithRange:range];
}

- (NSRange)joinRange
{
    NSRange lineRange = [self lineRange];
    NSRange joinRange = (NSRange) { .location = lineRange.location + lineRange.length - 1 };

    NSCharacterSet *validSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKOLMNOPQRSTUVWXYZÅÄÆÖØabcdefghijkolmnopqrstuvwxyzåäæöø_!\"#€%&/()=?`<>@£$∞§|[]≈±´¡”¥¢‰¶\{}≠¿`~^*+-;"];

    NSUInteger length = ([self.textView.string rangeOfCharacterFromSet:validSet options:NSCaseInsensitiveSearch range:NSMakeRange(joinRange.location,self.textView.string.length-joinRange.location)].location);

    NSRange range = NSMakeRange(joinRange.location, length - joinRange.location);

    return range;
}

- (void)uppercase
{

	if (self.textView) {
		[self.textView beginUndoGrouping];
		NSRange selectedRange = [self.textView selectedRange];
		NSString *uppercaseString = [[self.textView selectedText] uppercaseString];
		[self.textView replaceCharactersInRange:selectedRange withString:uppercaseString];
		[self.textView setSelectedRange:selectedRange];
		[self.textView endUndoGrouping];
	}
}

- (void)lowercase
{

	if (self.textView) {
		[self.textView beginUndoGrouping];
		NSRange selectedRange = [self.textView selectedRange];
		NSString *lowercaseString = [[self.textView selectedText] lowercaseString];
		[self.textView replaceCharactersInRange:selectedRange withString:lowercaseString];
		[self.textView setSelectedRange:selectedRange];
		[self.textView endUndoGrouping];
	}
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
