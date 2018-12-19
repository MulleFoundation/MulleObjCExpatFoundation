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

// why no autorelease here ?
// reasoning:
//    there are no "callbacks" to outside code
//    all objects are maintained in the inside until _parseXMLData finishes
//    code is wrapped in exception try/catch
//
@implementation NSPropertyListSerialization( Expat)


//
// keys are all static anyway
//
static void   pushKeyObj( NSPropertyListSerialization *self,
                          NSString *key,
                          id value)
{
   struct mulle_pointerpair   pair;

   pair._key   = key;
   pair._value = value;
   mulle_pointerpairarray_add( &self->_stack, pair);
#if STACK_DEBUG
   fprintf( stderr, "+key : %s %s\n", [key UTF8String], [[value description] UTF8String]);
#endif
}


static NSString  *peekKey( NSPropertyListSerialization *self)
{
   struct mulle_pointerpair   pair;

   pair = mulle_pointerpairarray_find_last( &self->_stack);
   return( pair._value);
}


static void   *popKeyObj( NSPropertyListSerialization *self, id *value)
{
   struct mulle_pointerpair   pair;

   pair = mulle_pointerpairarray_remove_last( &self->_stack);
   if( value)
      *value = pair._value;

#if STACK_DEBUG
   fprintf( stderr, "-key : %s %s\n", [(id) pair._key UTF8String], [[(id) pair._value description] UTF8String]);
#endif
   return( pair._key);
}


static void   emptyObjects( NSPropertyListSerialization *self)
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


static NSString  *_keyForCString( char *s)
{
   if( ! strcmp( s, "key"))
      return( _KeyKey);

   if( ! strcmp( s, "string"))
      return( _StringKey);
   if( ! strcmp( s, "integer"))
      return( _IntegerKey);
   if( ! strcmp( s, "real"))
      return( _RealKey);
   if( ! strcmp( s, "true"))
      return( _TrueKey);
   if( ! strcmp( s, "false"))
      return( _FalseKey);
   if( ! strcmp( s, "date"))
      return( _DateKey);
   if( ! strcmp( s, "data"))
      return( _DataKey);

   if( ! strcmp( s, "array"))
      return( _ArrayKey);
   if( ! strcmp( s, "dict"))
      return( _DictionaryKey);
   if( ! strcmp( s, "plist"))
      return( _PlistKey);

   MulleObjCThrowInvalidArgumentException( @"unknown key");
}


//
// expat call backs, we iz lucky, coz the actual text is only in the leafs
//
static void   start_elem_handler( void *_self, XML_Char *name, XML_Char **attributes)
{
   NSPropertyListSerialization    *self;
   NSString                       *key;

#if XML_DEBUG
   fprintf( stderr, "<%s>\n", name);
#endif
   self = (NSPropertyListSerialization *) _self;

   key = _keyForCString( name);
   pushKeyObj( self, key, nil);

   [self->_textStorage setString:nil]; // jettison trash
}


static void    char_data_handler( void *_self, XML_Char *s, int len)
{
   NSPropertyListSerialization    *self;
   NSString                       *text;

   self = (NSPropertyListSerialization *) _self;

   assert( self->_textStorage);

   if( len == 1 && *s == '\n')
   {
      [self->_textStorage appendString:@"\n"];
      return;
   }

#if XML_DEBUG
   fprintf( stderr, "%.*s\n", len, s);
#endif
   text = [[NSString alloc] _initWithUTF8Characters:(void *) s
                                             length:len];

   [self->_textStorage appendString:text];
   [text release];
}


- (NSDateFormatter *) _dateFormatter
{
   // ephemeral, only valid during one run
   if( ! _dateFormatter)
      _dateFormatter = [[[NSDateFormatter alloc] initWithDateFormat:@"%Y-%m-%dT%H:%M:%SZ" allowNaturalLanguage:NO] autorelease];  // proper handling later
   return( _dateFormatter);
}


static void    end_elem_handler( void *_self, const XML_Char *name)
{
   NSPropertyListSerialization   *self;
   NSString                      *key;
   NSString                      *match;
   NSString                      *text;
   id                            obj;
   id                            child;
   NSData                        *data;

#if XML_DEBUG
   fprintf( stderr, "</%s>\n", name);
#endif
   self = (NSPropertyListSerialization *) _self;
   key  = _keyForCString( (char *) name);
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
         obj = [[[self _dateFormatter] dateFromString:text] retain];
         break;
      }

      if( key == _DataKey)
      {
         NSCParameterAssert( match == _DataKey);

         data = [text dataUsingEncoding:NSUTF8StringEncoding];
         obj  = [NSPropertyListSerialization propertyListFromData:data
                                                 mutabilityOption:NSPropertyListImmutable
                                                           format:NULL
                                                 errorDescription:NULL];
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
static void  paint_arrow( char *buf, int column)
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


//
// TODO: make it an NSError
//
static void   print_xml_error( XML_Parser parser, char *xml_s, size_t xml_len)
{
   XML_Size         line;
   XML_Size         column;
   XML_Index        index;
   enum XML_Error   code;
   XML_LChar        *error;
   char             *s;
   int              maxlength;
   char             c_buf[ 6];

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

   fprintf( stderr, "XML line %ld, at '%s': %s", line, c_buf, error);
   fprintf( stderr, "%.*s", maxlength, s);

   // output marker if line is not too large
   if( column > 256 - 3)
      return;

   {
      char   buf[ column + 5];

      paint_arrow( buf, (int) column);
      fprintf( stderr, "%.*s", maxlength, buf);
   }
}


- (id) _parseXMLData:(NSData *) data
{
   NSAutoreleasePool        *pool;
   NSException              *exception;
   NSString                 *key;
   XML_Parser               parser;
   char                     *xml_s;
   id                       plist;
   int                      inv_rval;
   size_t                   xml_len;
   struct mulle_allocator   *allocator;

   NSParameterAssert( [data length]); // should have been checked already

   pool = [NSAutoreleasePool new];
   {
      NSCParameterAssert( ! self->_textStorage);

      parser    = XML_ParserCreate( NULL);
      allocator = MulleObjCObjectGetAllocator( self);

      mulle_pointerpairarray_init( &self->_stack, 128, NULL, allocator);

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
         print_xml_error( parser, xml_s, xml_len);

   NS_HANDLER
      exception = localException;
   NS_ENDHANDLER
      XML_ParserFree( parser);

      emptyObjects( self);

      mulle_pointerpairarray_done( &self->_stack);
      _textStorage = 0;
      [exception raise];
   }
   [pool release];

   return( [plist autorelease]);
}


- (NSString *) _debugContentsDescription
{
   struct mulle_pointerpairarray_enumerator   pair_rover;
   NSString                                   *separator;
   NSMutableString                            *s;
   struct mulle_pointerpair                   pair;

   s = [NSMutableString string];
   [s appendString:@"<"];

   separator  = @" ";
   pair_rover = mulle_pointerpairarray_enumerate( &self->_stack);
   for(;;)
   {
      pair = mulle_pointerpairarray_enumerator_next( &pair_rover);
      if( ! pair._value)
         break;

      [s appendFormat:@"%@{ %@ = %@ }", separator, pair._key, pair._value];
      separator = @", ";
   }
   mulle_pointerpairarray_enumerator_done( &pair_rover);

   [s appendString:@">"];

   return( s);
}


@end
