//
//  main.m
//  archiver-test
//
//  Created by Nat! on 19.04.16.
//  Copyright © 2016 Mulle kybernetiK. All rights reserved.
//


#import <MulleObjCExpatFoundation/MulleObjCExpatFoundation.h>
//#import "MulleStandaloneObjCFoundation.h"

#include <string.h>

//
// Dates can not be tested, because we need the POSIX Foundation or the
// equivalent, which provides the NSDateFormatter functionality
//

static char   test_xml[] = "\
<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\"\n\
                       \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n\
<plist version=\"1.0\">\n\
<dict>\n\
   <key>Club</key>\n\
   <array>\n\
      <dict>\n\
         <key>name</key>\n\
         <string>VfL Bochum 1848</string>\n\
      </dict>\n\
   </array>\n\
   <key>Liga</key>\n\
   <array>\n\
      <dict>\n\
         <key>clubs</key>\n\
         <array>\n\
            <dict>\n\
               <key>name</key>\n\
               <string>VfL Bochum 1848</string>\n\
            </dict>\n\
         </array>\n\
         <key>name</key>\n\
         <string>2. Liga</string>\n\
      </dict>\n\
      <dict>\n\
         <key>name</key>\n\
         <string>Bundesliga</string>\n\
         <key>clubs</key>\n\
         <array/>\n\
      </dict>\n\
   </array>\n\
</dict>\n\
</plist>";



int   main( int argc, const char * argv[])
{
   NSData    *data;
   NSString  *error;
   id        plist;

   error = nil;
   data  = [NSData dataWithBytes:test_xml
                          length:sizeof( test_xml)];
   plist = [NSPropertyListSerialization propertyListFromData:data
                                            mutabilityOption:NSPropertyListImmutable
                                                      format:NULL
                                            errorDescription:&error];
   if( ! plist)
   {
      fprintf( stderr, "Error: %s\n", [[error description] UTF8String]);
      return( 1);
   }

   // not so pretty yet
   fprintf( stderr, "Plist: %s\n", [[plist description] UTF8String]);
   return( 0);
}
