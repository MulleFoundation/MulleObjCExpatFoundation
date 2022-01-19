/*
 *  MulleFoundation - A tiny Foundation replacement
 *
 *  NSPropertyListSerialization+ExpatPropertyList.m is a part of MulleFoundation
 *
 *  Copyright (C) 2011 Nat!, Mulle kybernetiK
 *  All rights reserved.
 *
 *  Coded by Nat!
 *
 *  $Id$
 *
 */
#import "import-private.h"

// other files in this library
#import "MulleObjCExpatParser.h"

// other libraries of MulleObjCStandardFoundation

// std-c and dependencies

@implementation NSPropertyListSerialization( MulleObjCExpatParser)

MULLE_OBJC_DEPENDS_ON_CLASS( MulleObjCExpatParser);

+ (void) load
{
   [self mulleAddParserClass:[MulleObjCExpatParser class]
                      method:@selector( parseXMLData:)
       forPropertyListFormat:NSPropertyListXMLFormat_v1_0];

   [self mulleAddPrintMethod:@selector( mullePrintXMLToStream:)
         forPropertyListFormat:NSPropertyListXMLFormat_v1_0];
}

@end

