#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "gicanvas.h"
#import "mgaction.h"
#import "mgcmd.h"
#import "mgcoreview.h"
#import "mglocal.h"
#import "mgselect.h"
#import "mgsnap.h"
#import "mgview.h"
#import "mgcmddraw.h"
#import "mgdrawarc.h"
#import "mgdrawline.h"
#import "mgdrawrect.h"
#import "cmdbasic.h"
#import "mgdrawcircle.h"
#import "mgdrawdiamond.h"
#import "mgdrawellipse.h"
#import "mgdrawfreelines.h"
#import "mgdrawgrid.h"
#import "mgdrawlines.h"
#import "mgdrawparallel.h"
#import "mgdrawpolygon.h"
#import "mgdrawquadrangle.h"
#import "mgdrawsplines.h"
#import "mgdrawsquare.h"
#import "mgdrawtriang.h"
#import "mgcmdmgr.h"
#import "mgcmdmgrfactory.h"
#import "cmdobserver.h"
#import "cmdsubject.h"
#import "girecordcanvas.h"
#import "girecordshape.h"
#import "svgcanvas.h"
#import "mgbase.h"
#import "mgbox.h"
#import "mgcurv.h"
#import "mgdef.h"
#import "mglnrel.h"
#import "mgmat.h"
#import "mgnear.h"
#import "mgpath.h"
#import "mgpnt.h"
#import "mgtol.h"
#import "mgvec.h"
#import "gicolor.h"
#import "gicontxt.h"
#import "gigraph.h"
#import "gilock.h"
#import "gixform.h"
#import "mgarc.h"
#import "mgbasesp.h"
#import "mgcshapes.h"
#import "mgdiamond.h"
#import "mgdot.h"
#import "mgellipse.h"
#import "mggrid.h"
#import "mgline.h"
#import "mglines.h"
#import "mgobject.h"
#import "mgparallel.h"
#import "mgpathsp.h"
#import "mgrdrect.h"
#import "mgrect.h"
#import "mgshapetype.h"
#import "mgshape_.h"
#import "mgsplines.h"
#import "mgjsonstorage.h"
#import "mglog.h"
#import "mgstrcallback.h"
#import "mgvector.h"
#import "recordshapes.h"
#import "mgbasicspreg.h"
#import "mgbasicsps.h"
#import "mgcomposite.h"
#import "mgimagesp.h"
#import "mgshape.h"
#import "mgshapes.h"
#import "mgshapet.h"
#import "mgspfactory.h"
#import "mglayer.h"
#import "mgshapedoc.h"
#import "spfactoryimpl.h"
#import "mgstorage.h"
#import "RandomShape.h"
#import "testcanvas.h"
#import "gicoreview.h"
#import "gigesture.h"
#import "gimousehelper.h"
#import "giplaying.h"
#import "giview.h"

FOUNDATION_EXPORT double TouchVGCoreVersionNumber;
FOUNDATION_EXPORT const unsigned char TouchVGCoreVersionString[];

