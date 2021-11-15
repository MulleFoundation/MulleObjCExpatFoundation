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

   if( argc == 2)
     return( 1);

   error = nil;
   data  = [NSData dataWithContentsOfFile:@"xml.plist"];
   plist = [NSPropertyListSerialization propertyListWithData:data
                                                     options:NSPropertyListImmutable
                                                      format:NULL
                                                       error:&error];
   if( ! plist)
   {
      fprintf( stderr, "Error (parse): %s\n", [[error description] UTF8String]);
      return( 1);
   }

   outData = [NSPropertyListSerialization dataWithPropertyList:plist
                                                        format:NSPropertyListXMLFormat_v1_0
                                                       options:0
                                                         error:&error];
   if( ! outData)
   {
      fprintf( stderr, "Error (print): %s\n", [[error description] UTF8String]);
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
      fprintf( stderr, "Error (check): %s\n", [[error description] UTF8String]);
      return( 1);
   }

   // output will not be same because of different dictionary order of
   // keys and it's not necessarily sorted
   if( ! [check isEqual:plist])
   {
      fprintf( stderr, "property lists differ\n");
      return( 1);
   }
   return( 0);
}
