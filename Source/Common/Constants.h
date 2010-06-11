/*
 *  Constants.h
 *  Dynstr
 *
 *  Created by P. Mark Anderson on 6/10/10.
 *  Copyright 2010 Spot Metrix, Inc. All rights reserved.
 *
 */

#define RELEASE(object) \
{ \
if(object)\
{ \
[object release];\
object=nil; \
} \
}
