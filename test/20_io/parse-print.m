//
//  main.m
//  archiver-test
//
//  Created by Nat! on 19.04.16.
//  Copyright © 2016 Mulle kybernetiK. All rights reserved.
//


#import <MulleObjCExpatFoundation/MulleObjCExpatFoundation.h>
#import <MulleObjCOSFoundation/MulleObjCOSFoundation.h>
//#import "MulleStandaloneObjCFoundation.h"



int   main( int argc, const char * argv[])
{
   NSData    *data;
   NSData    *outData;
   NSError   *error;
   id        plist;
   id        check;
   NSString  *filename;

   if( argc == 2)
     return( 1);

   error    = nil;
   filename = @"xml.plist";
   data     = [NSData dataWithContentsOfFile:filename];
   if( ! data)
   {
      mulle_fprintf( stderr, "Failed to load \"%@\"\n", filename);
      return( 1);
   }

   plist = [NSPropertyListSerialization propertyListWithData:data
                                                     options:NSPropertyListImmutable
                                                      format:NULL
                                                       error:&error];
   if( ! plist)
   {
      mulle_fprintf( stderr, "Error (parse): %@\n", error);
      return( 1);
   }

   outData = [NSPropertyListSerialization dataWithPropertyList:plist
                                                        format:NSPropertyListXMLFormat_v1_0
                                                       options:0
                                                         error:&error];
   if( ! outData)
   {
      mulle_fprintf( stderr, "Error (print): %@\n", error);
      return( 1);
   }
   [outData writeToFile:@"xml.plist.output"
             atomically:NO];

   check = [NSPropertyListSerialization propertyListWithData:outData
                                                     options:NSPropertyListImmutable
                                                      format:NULL
                                                       error:&error];
   if( ! check)
   {
      mulle_fprintf( stderr, "Error (check): %@\n", error);
      return( 1);
   }

   // output will not be same because of different dictionary order of
   // keys and it's not necessarily sorted
   if( ! [check isEqual:plist])
   {
      mulle_fprintf( stderr, "property lists differ\n");
      return( 1);
   }
   return( 0);
}
