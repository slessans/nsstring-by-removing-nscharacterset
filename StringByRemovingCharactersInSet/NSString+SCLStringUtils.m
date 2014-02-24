//
//  NSString+SCLStringUtils.m
//  StringByRemovingCharactersInSet
//
//  Created by Scott Lessans on 12/25/13.
//  Copyright (c) 2013 Scott Lessans. All rights reserved.
//

#import "NSString+SCLStringUtils.h"

@implementation NSString (SCLStringUtils)

- (NSString *) scl_stringByRemovingCharactersInSet:(NSCharacterSet *)characterSet
{
    // create a buffer to hold a copy of the new string. using a lower-level
    // buffer will allow efficient iteration/manipulation
    const NSUInteger length = [self length];
    unichar * characters = malloc(sizeof(unichar) * length);
    
    // copy the contents of self info the buffer
    [self getCharacters:characters range:NSMakeRange(0, length)];
    
    // run through the string, only keeping characters that are valid
    NSUInteger nextEmptyLocation = 0;
    for(NSUInteger currentLocation = 0; currentLocation < length; currentLocation++) {
        if (![characterSet characterIsMember:characters[currentLocation]]) {
            characters[nextEmptyLocation] = characters[currentLocation];
            nextEmptyLocation++;
        }
    }
    
    // create a string without re-copying the bytes, this is key to efficiency
    // and keeping our memory usage down. as a special consideration (as noted
    // in the apple docs) if there is an error in the allocation process, the
    // buffer will not be freed even if freeWhenDone is YES.
    NSString * result = [[NSString alloc] initWithCharactersNoCopy:characters
                                                            length:nextEmptyLocation
                                                      freeWhenDone:YES];

    // free if error on creation
    if (!result) {
        free(characters);
    }
    
    return result;
}

@end

