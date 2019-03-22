//
//  FWURLSchema.h
//  FWModel
//
//  Created by SamirMAC on 11/3/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#ifndef FWModel_FWURLSchema_h
#define FWModel_FWURLSchema_h




#define FW_BASE_URL             @"https://api.fieldworkhq.com"
//#define FW_BASE_URL             @"http://api.fieldworkapp.com"

//#define FW_BASE_URL             @"http://api.fieldwork.dev:3000"

#define FW_API_VERSION          @"/v2"

#define API_GET_KEY                     @"/get_key"
#define API_BAIT_CONDITIONS             @"/bait_conditions"

#define API_WORK_ORDERS                 @"/work_orders"

#define API_ESTIMATE                    @"/estimates/%@"
#define API_ESTIMATES                   @"/estimates"

#define API_WORK_ORDER                  @"/work_orders/%@"
#define API_DEVICE_AREA                 @"/device_areas"
#define API_ALL_CUSTOMER                @"/customers"
#define API_ALL_CUSTOMER_THINNED        @"/customers/thinned"
#define API_SAVE_CUSTOMER_DEVICE        @"/customers/%d/service_locations/%d/devices"
#define API_UPDATE_CUSTOMER_DEVICE      @"/customers/%d/service_locations/%d/devices/%d"
#define API_UNITS                       @"/customers/%@/service_locations/%@/flats"
#define API_USER                        @"/user"
#define API_USER_COORDINATES            @"/user/coordinates"
#define API_CUSTOMER                    @"/customers/%@"
#define API_CUSTOMER_PAYMENT_METHODS    @"/customers/%@/payment_methods"                // payment_methods is stored in Customer table as a column payment_methods. The value is Array
#define API_SERVICE_REPORT              @"/work_orders/%@/service_report.pdf"
#define API_PEST_TYPES                  @"/pest_types"
#define API_TAX_RATE                    @"/tax_rates/%@"

#define API_MATERIAL                    @"/materials"
#define API_PAYMENT_METHOD              @"/customers/%d/payment_methods"
#define API_WORK_ORDER_HISTORY          @"/customers/%d/service_locations/%d/history"
#define API_FLOORS                      @"/customers/%d/service_locations/%d/floor_plans"
#define API_PLAN_IMAGE

#define API_PDF_ATTACHMENT_NEW          @"/work_orders/%@/attachments"

#define API_PDF_ATTACHMENT_EDIT         @"/work_orders/%@/attachments/%@"

#define API_LOCATION_AREAS              @"/location_types/%@/location_areas"

#define API_SAVE_UNIT_RECORD            @"/work_orders/%d/unit_records"
#define API_UPDATE_UNIT_RECORD          @"/work_orders/%d/unit_records/%d"
//params
#define API_PARAM_WITHOUT_CREDIT        @"without_credit"

#endif
