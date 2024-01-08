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
#import "import.h"

// other files in this library

// other libraries of MulleObjCStandardFoundation

// std-c and dependencies


// TODO: rename to MulleObjCExpatPlistParser
@interface MulleObjCExpatParser : NSObject
{
   // these are all ephemeral currently
@private
   struct mulle_pointerpairarray   _stack;          // useful for XML
   id                              _textStorage;    // useful for XML
   id                              _dateFormatter;  // ephemeral usage in XML
}
@end


