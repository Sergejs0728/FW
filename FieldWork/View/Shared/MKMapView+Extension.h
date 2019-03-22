//
//  MKMapView+Extension.h
//  FieldWork
//
//  Created by alex on 31.05.17.
//
//

#import <MapKit/MapKit.h>

@interface MKMapView (Extension)

- (CGFloat)zoomLevel;
- (MKZoomScale)zoomScale;
- (MKMapRect)MKMapRectForCoordinateRegion:(MKCoordinateRegion)region;
- (MKMapRect)mapRect;

@end
