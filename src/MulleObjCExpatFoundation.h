//
//  MulleObjCExpatFoundation.h
//  MulleObjCExpatFoundation
//
//  Created by Nat! on 04.05.16.
//  Copyright © 2016 Mulle kybernetiK. All rights reserved.
//
#import "import.h"

#define MULLE_OBJC_EXPAT_FOUNDATION_VERSION  ((0 << 20) | (17 << 8) | 0)

#import "MulleObjCLoader+MulleObjCExpatFoundation.h"

#import "MulleObjCExpatParser.h"

// export nothing with _MulleObjC
#if MULLE_OBJC_STANDARD_FOUNDATION_VERSION < ((0 << 20) | (14 << 8) | 0)
# error "MulleObjCStandardFoundation is too old"
#endif

