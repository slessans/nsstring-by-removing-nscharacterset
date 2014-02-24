//
//  StringByRemovingCharactersInSetTests.m
//  StringByRemovingCharactersInSetTests
//
//  Created by Scott Lessans on 12/25/13.
//  Copyright (c) 2013 Scott Lessans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+SCLStringUtils.h"

#define TEST_STRS(STRING, CHARACTER_SET) \
    NSString * testResult = [STRING scl_stringByRemovingCharactersInSet:CHARACTER_SET]; \
    NSString * reference = [STRING scl_testing_stringByRemovingCharactersInSetReferenceImpl:CHARACTER_SET]; \
    XCTAssertEqualObjects(testResult, reference, \
                  @"Failure: \n\tinput    : %@\n\tresult   : %@\n\treference: %@\n\n", \
                  STRING, testResult, reference);


@interface StringByRemovingCharactersInSetTests : XCTestCase
@end

@interface NSString (SCL_Tests)

- (NSString *) scl_testing_stringByRemovingCharactersInSetReferenceImpl:(NSCharacterSet *)characterSet;

@end

@implementation StringByRemovingCharactersInSetTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testSimpleWhitespaceNewline
{
    TEST_STRS(@"(545) 764 -3e- fds38 j3kdd", [NSCharacterSet whitespaceAndNewlineCharacterSet]);
}

- (void) testSimpleDigit
{
    TEST_STRS(@"(545) 764 -3e- fds38 j3kdd", [NSCharacterSet decimalDigitCharacterSet]);
}

- (void) testSimpleNonDigit
{
    TEST_STRS(@"(545) 764 -3e- fds38 j3kdd", [[NSCharacterSet decimalDigitCharacterSet] invertedSet]);
}

- (void) testEmptyString
{
    TEST_STRS(@"", [NSCharacterSet decimalDigitCharacterSet]);
}

- (void) testEmptyCharacterSet
{
    TEST_STRS(@"(545) 764 -3e- fds38 j3kdd", [[NSCharacterSet alloc] init]);
}

- (void) testNilString
{
    NSString * test = nil;
    TEST_STRS(test, [NSCharacterSet decimalDigitCharacterSet]);
}

- (void) testNilCharSet
{
    NSCharacterSet * test = nil;
    TEST_STRS(@"(545) 764 -3e- fds38 j3kdd", test);
}

- (void) testNilNil
{
    NSString * a = nil;
    NSCharacterSet * b = nil;
    TEST_STRS(a,b);
}

- (void) testAllCharacters
{
    NSString * str = @"Hello there World";
    TEST_STRS(str, [NSCharacterSet characterSetWithCharactersInString:str]);
}

@end


@implementation NSString (SCL_Tests)

- (NSString *) scl_testing_stringByRemovingCharactersInSetReferenceImpl:(NSCharacterSet *)characterSet
{
    if (!characterSet) characterSet = [[NSCharacterSet alloc] init];
    return [[self componentsSeparatedByCharactersInSet:characterSet]
            componentsJoinedByString:@""];
}

@end
