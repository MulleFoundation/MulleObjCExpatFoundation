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
#import "MulleObjCExpatParser.h"

#import "import-private.h"

// other files in this library

// other libraries of MulleObjCStandardFoundation

// std-c and dependencies
#include <ctype.h>

#ifndef DEBUG
# define XML_DEBUG     0
# define STACK_DEBUG   0
#else
# define XML_DEBUG     0
# define STACK_DEBUG   0
#endif


/*
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
   <key>New item</key>
   <array>
      <string>VfL Bochum</string>
      <integer>1848</integer>
      <real>18.48</real>
      <date>2011-10-14T11:40:15Z</date>
      <real>1.4e+184</real>
      <data>AQgECA==</data>
      <true/>
      <false/>
   </array>
</dict>
</plist>
*/


@implementation MulleObjCExpatParser

//
// why no autorelease here ?
// reasoning:
//    there are no "callbacks" to outside code
//    all objects are maintained in the inside until _parseXMLData finishes
//    code is wrapped in exception try/catch
//
// keys are all static anyway
//
static void   pushKeyObj( MulleObjCExpatParser *self,
                          NSString *key,
                          id value)
{
   struct mulle_pointerpair   pair;

   pair.key   = key;
   pair.value = value;
   _mulle_pointerpairarray_add( &self->_stack, pair);
#if STACK_DEBUG
   fprintf( stderr, "+key : %s %s\n", [key UTF8String], [[value description] UTF8String]);
#endif
}

#if 0 // UNUSED
static NSString  *peekKey( MulleObjCExpatParser *self)
{
   struct mulle_pointerpair   pair;

   pair = mulle_pointerpairarray_get_last( &self->_stack);
   return( pair.value);
}
#endif

static void   *popKeyObj( MulleObjCExpatParser *self, id *value)
{
   struct mulle_pointerpair   pair;

   pair = mulle_pointerpairarray_pop( &self->_stack);
   if( value)
      *value = pair.value;

#if STACK_DEBUG
   fprintf( stderr, "-key : %s %s\n", [(id) pair.key UTF8String], [[(id) pair.value description] UTF8String]);
#endif
   return( pair.key == mulle_not_a_pointer ? NULL : pair.key);
}


static void   emptyObjects( MulleObjCExpatParser *self)
{
   id   value;

   while( popKeyObj( self, &value))
      [value autorelease];
}


static NSString  *_ArrayKey      = @"array";
static NSString  *_DataKey       = @"data";
static NSString  *_DateKey       = @"date";
static NSString  *_DictionaryKey = @"dict";
static NSString  *_FalseKey      = @"false";
static NSString  *_IntegerKey    = @"integer";
static NSString  *_KeyKey        = @"key";
static NSString  *_PlistKey      = @"plist";
static NSString  *_RealKey       = @"real";
static NSString  *_StringKey     = @"string";
static NSString  *_TrueKey       = @"true";


static NSString  *_keyForUTF8String( char *s)
{
   switch( *s++)
   {
   case 'a' :
      if( ! strcmp( s, "rray"))
         return( _ArrayKey);
      break;

   case 'd' :
      if( ! strcmp( s, "ict"))
         return( _DictionaryKey);
      if( ! strcmp( s, "ate"))
         return( _DateKey);
      if( ! strcmp( s, "ata"))
         return( _DataKey);
      break;

   case 'f' :
      if( ! strcmp( s, "alse"))
         return( _FalseKey);
      break;

   case 'i' :
      if( ! strcmp( s, "nteger"))
         return( _IntegerKey);
      break;

   case 'k' :
      if( ! strcmp( s, "ey"))
         return( _KeyKey);
      break;

   case 'p' :
      if( ! strcmp( s, "list"))
         return( _PlistKey);
      break;

   case 'r' :
      if( ! strcmp( s, "eal"))
         return( _RealKey);
      break;

   case 's' :
      if( ! strcmp( s, "tring"))
         return( _StringKey);
      break;

   case 't' :
      if( ! strcmp( s, "rue"))
         return( _TrueKey);
      break;
   }

   MulleObjCThrowInvalidArgumentException( @"unknown key");
}


//
// expat call backs, we iz lucky, coz the actual text is only in the leafs
//
static void   start_elem_handler( void *_self, XML_Char *name, XML_Char **attributes)
{
   MulleObjCExpatParser   *self;
   NSString                                  *key;

#if XML_DEBUG
   fprintf( stderr, "<%s>\n", name);
#endif
   self = (MulleObjCExpatParser *) _self;

   key = _keyForUTF8String( name);
   pushKeyObj( self, key, nil);

   [self->_textStorage setString:nil]; // jettison trash
}


static void    char_data_handler( void *_self, XML_Char *s, int len)
{
   MulleObjCExpatParser   *self;
   NSString                                  *text;

   self = (MulleObjCExpatParser *) _self;

   assert( self->_textStorage);

   if( len == 1 && *s == '\n')
   {
      [self->_textStorage appendString:@"\n"];
      return;
   }

#if XML_DEBUG
   fprintf( stderr, "%.*s\n", len, s);
#endif
   text = [[NSString alloc] mulleInitWithUTF8Characters:(void *) s
                                                 length:len];

   [self->_textStorage appendString:text];
   [text release];
}


- (NSDateFormatter *) _XMLDateFormatter
{
   // ephemeral, only valid during one run
   if( ! _dateFormatter)
      _dateFormatter = [[[NSDateFormatter alloc] initWithDateFormat:@"%Y-%m-%dT%H:%M:%SZ"
                                               allowNaturalLanguage:NO] autorelease];  // proper handling later
   return( _dateFormatter);
}


static void    end_elem_handler( void *_self, const XML_Char *name)
{
   MulleObjCExpatParser   *self;
   NSString               *key;
   NSString               *match;
   NSString               *text;
   id                     obj;
   id                     child;
   NSData                 *data;

#if XML_DEBUG
   fprintf( stderr, "</%s>\n", name);
#endif
   self = (MulleObjCExpatParser *) _self;
   key  = _keyForUTF8String( (char *) name);
   text = [self->_textStorage copy];
   [self->_textStorage setString:nil];

   match = popKeyObj( self, &child);

   do
   {
      if( key == _KeyKey)
      {
         NSCParameterAssert( match == _KeyKey);
         obj = text;
         break;
      }

      if( key == _StringKey)
      {
         NSCParameterAssert( match == _StringKey);
         obj = text;
         break;
      }

      if( key == _IntegerKey)
      {
         NSCParameterAssert( match == _IntegerKey);
         obj = [[NSNumber alloc] initWithInteger:[text integerValue]];
         break;
      }

      if( key == _RealKey)
      {
         NSCParameterAssert( match == _RealKey);
         obj = [[NSNumber alloc] initWithDouble:[text doubleValue]];
         break;
      }

      if( key == _DateKey)
      {
         NSCParameterAssert( match == _DateKey);
         obj = [[[self _XMLDateFormatter] dateFromString:text] retain];
         break;
      }

      if( key == _DataKey)
      {
         NSCParameterAssert( match == _DataKey);

         data = [text dataUsingEncoding:NSUTF8StringEncoding];
         obj  = [data base64DecodedData];
//         obj  = [NSPropertyListSerialization propertyListFromData:data
//                                                 mutabilityOption:NSPropertyListImmutable
//                                                           format:NULL
//                                                 errorDescription:NULL];
         [obj retain];
         break;
      }

      if( key == _TrueKey)
      {
         NSCParameterAssert( match == _TrueKey);
         obj = [[NSNumber alloc] initWithBool:YES];
         break;
      }

      if( key == _FalseKey)
      {
         NSCParameterAssert( match == _FalseKey);
         obj = [[NSNumber alloc] initWithBool:NO];
         break;
      }

      if( key == _ArrayKey)
      {
         obj = [NSMutableArray new];
         for(;;)
         {
            if( match == _ArrayKey && ! child)
               break;

            [obj insertObject:child
                      atIndex:0];
            [child release];

            match = popKeyObj( self, &child);
         }
         break;
      }

      if( key == _DictionaryKey)
      {
         obj = [NSMutableDictionary new];
         for(;;)
         {
            if( match == _DictionaryKey && ! child)
               break;

            match = popKeyObj( self, &key);
            if( match != _KeyKey)
               MulleObjCThrowInvalidArgumentException( @"invalid %@", match);

            [obj setObject:child
                    forKey:key];
            [child release];
            [key release];

            match = popKeyObj( self, &child);
         }
         break;
      }

      if( key == _PlistKey)
      {
         match = popKeyObj( self, NULL); // pop off plist
         NSCParameterAssert( match == _PlistKey);

         obj = child;
         break;
      }

#if DEBUG
      abort();
#endif
   }
   while( 0);

   if( ! obj)
      MulleObjCThrowInvalidArgumentException( @"Plist unparsable at <%s %@>", name, text);

   // if obj != text, it can be discarded
   if( obj != text)
      [text release];
   pushKeyObj( self, match, obj);
}


// buf size must be column + 1 + 3 + 1
static void   paint_arrow( char *buf, int column)
{
   int   i;

   if( column < 3)
   {
      for( i = 0; i < column; i++)
         *buf++ = ' ';
      *buf++ = '^';
      for( i = 0; i < 3; i++)
         *buf++ = '_';
   }
   else
   {
      for( i = 0; i < column; i++)
         *buf++ = '_';
      *buf++ = '^';
   }
   *buf++ = 0;
}


static NSString *
   xml_error_description( XML_Parser parser, char *xml_s, size_t xml_len)
{
   char                  *s;
   char                  c_buf[ 6];
   enum XML_Error        code;
   int                   maxlength;
   NSString              *description;
   struct mulle_buffer   buffer;
   XML_Index             index;
   XML_LChar             *error;
   XML_Size              column;
   XML_Size              line;
   struct mulle_data     data;

   line   = XML_GetCurrentLineNumber( parser);
   column = XML_GetCurrentColumnNumber( parser);
   index  = XML_GetCurrentByteIndex( parser);
   code   = XML_GetErrorCode( parser);
   error  = (XML_LChar *) XML_ErrorString( code);

   // output entire line
   s = "???";
   sprintf( c_buf, "???");
   if( index > 0 && index < (long) xml_len)
   {
      s = &xml_s[ index];
      if( isprint( *s))
         sprintf( c_buf, "%.1s", s);
      else
         sprintf( c_buf, "\\0x%x", *s & 0xFF);
      while( s > xml_s && *s != '\n' && s[ -1] != '\n')
         --s;
   }
   maxlength = (int) (&xml_s[ xml_len] - s);
   if( maxlength > 256)
      maxlength = 256;

   mulle_buffer_init_with_capacity( &buffer, 256, &mulle_default_allocator);
   mulle_buffer_sprintf( &buffer, "XML line %ld, at '%s': %s", line, c_buf, error);
   mulle_buffer_sprintf( &buffer, "%.*s", maxlength, s);

   // output marker if line is not too large
   if( column <= 256 - 3)
   {
      char   buf[ column + 5];

      paint_arrow( buf, (int) column);
      mulle_buffer_sprintf( &buffer, "%.*s", maxlength, buf);
   }

   mulle_buffer_add_byte( &buffer, 0);
   data = mulle_buffer_extract_data( &buffer);
   mulle_buffer_done( &buffer);

   description = [[[NSString alloc] mulleInitWithUTF8CharactersNoCopy:data.bytes
                                                               length:data.length
                                                            allocator:&mulle_default_allocator] autorelease];
   return( description);
}


- (id) parseXMLData:(NSData *) data
{
   char                     *xml_s;
   id                       plist;
   int                      inv_rval;
   NSAutoreleasePool        *pool;
   NSException              *exception;
   NSString                 *key;
   NSString                 *reason;
   size_t                   xml_len;
   struct mulle_allocator   *allocator;
   XML_Parser               parser;

   NSParameterAssert( [data length]); // should have been checked already

   pool = [NSAutoreleasePool new];
   {
      NSCParameterAssert( ! self->_textStorage);

      parser    = XML_ParserCreate( NULL);
      allocator = MulleObjCInstanceGetAllocator( self);

      _mulle_pointerpairarray_init( &self->_stack, 128, allocator);
      _textStorage = [NSMutableString string];
      exception    = nil;
      plist        = nil;

   NS_DURING
      XML_SetUserData( parser, self);
      XML_SetStartElementHandler( parser, (void *) start_elem_handler);
      XML_SetEndElementHandler( parser, end_elem_handler);
      XML_SetCharacterDataHandler( parser, (void *) char_data_handler);

      xml_s   = [data bytes];
      xml_len = [data length];

      for(;;)
      {
         if( ! xml_len)
            MulleObjCThrowInvalidArgumentException( @"no XML text");
         if( xml_s[ xml_len - 1])
            break;

         // remove trailing zeroes
         --xml_len;
      }

      inv_rval = XML_Parse( parser, xml_s, (int) xml_len, YES);
      if( inv_rval)
      {
         NSCParameterAssert( mulle_pointerpairarray_get_count( &self->_stack) == 1);
         key = popKeyObj( self, &plist);
         NSParameterAssert( key == _PlistKey);
      }
      else
      {
         reason = xml_error_description( parser, xml_s, xml_len);
         MulleObjCThrowInvalidArgumentException( reason);
      }

   NS_HANDLER
      exception = localException;
   NS_ENDHANDLER
      XML_ParserFree( parser);

      emptyObjects( self);

      _mulle_pointerpairarray_done( &self->_stack);
      _textStorage = 0;
      [exception raise];
   }
   [pool release];

   return( [plist autorelease]);
}


#if 0

- (NSString *) mulleDebugContentsDescription
{
   struct mulle_pointerpairarrayenumerator   pair_rover;
   NSString                                  *separator;
   NSMutableString                           *s;
   struct mulle_pointerpair                  pair;

   s = [NSMutableString string];
   [s appendString:@"<"];

   separator  = @" ";
   pair_rover = mulle_pointerpairarray_enumerate( &self->_stack);
   for(;;)
   {
      pair = mulle_pointerpairarrayenumerator_next( &pair_rover);
      if( ! pair.value)
         break;

      [s appendFormat:@"%@{ %@ = %@ }", separator, pair.key, pair.value];
      separator = @", ";
   }
   mulle_pointerpairarrayenumerator_done( &pair_rover);

   [s appendString:@">"];

   return( s);
}

#endif

@end



