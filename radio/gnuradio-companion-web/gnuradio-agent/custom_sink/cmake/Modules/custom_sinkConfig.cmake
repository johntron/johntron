INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_CUSTOM_SINK custom_sink)

FIND_PATH(
    CUSTOM_SINK_INCLUDE_DIRS
    NAMES custom_sink/api.h
    HINTS $ENV{CUSTOM_SINK_DIR}/include
        ${PC_CUSTOM_SINK_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    CUSTOM_SINK_LIBRARIES
    NAMES gnuradio-custom_sink
    HINTS $ENV{CUSTOM_SINK_DIR}/lib
        ${PC_CUSTOM_SINK_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(CUSTOM_SINK DEFAULT_MSG CUSTOM_SINK_LIBRARIES CUSTOM_SINK_INCLUDE_DIRS)
MARK_AS_ADVANCED(CUSTOM_SINK_LIBRARIES CUSTOM_SINK_INCLUDE_DIRS)

