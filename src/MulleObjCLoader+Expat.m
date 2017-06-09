//
//  MulleObjCLoader+ExpatFoundation.m
//  MulleObjCExpatFoundation
//
//  Created by Nat! on 12.05.17.
//  Copyright © 2017 Mulle kybernetiK. All rights reserved.
//

#import <MulleObjCFoundation/MulleObjCFoundation.h>


@implementation MulleObjCLoader( Expat)

+ (struct _mulle_objc_dependency *) dependencies
{
   static struct _mulle_objc_dependency   dependencies[] =
   {
      { @selector( NSPropertyListSerialization), @selector( Expat) },
      { MULLE_OBJC_NO_CLASSID, MULLE_OBJC_NO_CATEGORYID }
   };
   
   return( dependencies);
}

@end
