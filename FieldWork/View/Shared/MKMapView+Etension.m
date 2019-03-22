//
//  MKMapView+Etension.m
//  FieldWork
//
//  Created by alex on 31.05.17.
//
//

#import "MKMapView+Extension.h"

@implementation MKMapView (Extension)

- (CGFloat)zoomLevel {
    // function returns current zoom of the map
    CLLocationDirection angleCamera = self.camera.heading;
    if (angleCamera > 270) {
        angleCamera = 360 - angleCamera;
    } else if (angleCamera > 90) {
        angleCamera = fabs(angleCamera - 180);
    }
    CGFloat angleRad = M_PI * angleCamera / 180; // camera heading in radians
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat heightOffset = 20; // the offset (status bar height) which is taken by MapKit into consideration to calculate visible area height
    // calculating Longitude span corresponding to normal (non-rotated) width
    CGFloat spanStraight = width * self.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad));
    return log2(360 * ((width / 256) / spanStraight)) + 1;
}

- (MKZoomScale)zoomScale {
    MKZoomScale currentZoomScale = self.bounds.size.width / self.visibleMapRect.size.width;
    return currentZoomScale;
}

- (MKMapRect)MKMapRectForCoordinateRegion:(MKCoordinateRegion)region
{
    MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(
                                                                      region.center.latitude + region.span.latitudeDelta / 2,
                                                                      region.center.longitude - region.span.longitudeDelta / 2));
    MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(
                                                                      region.center.latitude - region.span.latitudeDelta / 2,
                                                                      region.center.longitude + region.span.longitudeDelta / 2));
    return MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y));
}

- (MKMapRect)mapRect {
    return [self MKMapRectForCoordinateRegion:self.region];
}

@end
