#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "ic_error" asset catalog image resource.
static NSString * const ACImageNameIcError AC_SWIFT_PRIVATE = @"ic_error";

/// The "ic_success" asset catalog image resource.
static NSString * const ACImageNameIcSuccess AC_SWIFT_PRIVATE = @"ic_success";

/// The "ic_warning" asset catalog image resource.
static NSString * const ACImageNameIcWarning AC_SWIFT_PRIVATE = @"ic_warning";

#undef AC_SWIFT_PRIVATE
