//
//  NSString+SCLStringUtils.h
//  StringByRemovingCharactersInSet
//
//  Created by Scott Lessans on 12/25/13.
//  Copyright (c) 2013 Scott Lessans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SCLStringUtils)

- (NSString *) scl_stringByRemovingCharactersInSet:(NSCharacterSet *)characterSet;

@end
