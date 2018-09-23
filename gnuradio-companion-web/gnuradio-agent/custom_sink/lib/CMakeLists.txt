# Copyright 2011,2012,2016 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Setup library
########################################################################
include(GrPlatform) #define LIB_SUFFIX

include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIRS})

list(APPEND custom_sink_sources
)

set(custom_sink_sources "${custom_sink_sources}" PARENT_SCOPE)
if(NOT custom_sink_sources)
	MESSAGE(STATUS "No C++ sources... skipping lib/")
	return()
endif(NOT custom_sink_sources)

add_library(gnuradio-custom_sink SHARED ${custom_sink_sources})
target_link_libraries(gnuradio-custom_sink ${Boost_LIBRARIES} ${GNURADIO_ALL_LIBRARIES})
set_target_properties(gnuradio-custom_sink PROPERTIES DEFINE_SYMBOL "gnuradio_custom_sink_EXPORTS")

if(APPLE)
    set_target_properties(gnuradio-custom_sink PROPERTIES
        INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}/lib"
    )
endif(APPLE)

########################################################################
# Install built library files
########################################################################
include(GrMiscUtils)
GR_LIBRARY_FOO(gnuradio-custom_sink RUNTIME_COMPONENT "custom_sink_runtime" DEVEL_COMPONENT "custom_sink_devel")

########################################################################
# Build and register unit test
########################################################################
include(GrTest)

include_directories(${CPPUNIT_INCLUDE_DIRS})

list(APPEND test_custom_sink_sources
    ${CMAKE_CURRENT_SOURCE_DIR}/test_custom_sink.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/qa_custom_sink.cc
)

add_executable(test-custom_sink ${test_custom_sink_sources})

target_link_libraries(
  test-custom_sink
  ${GNURADIO_RUNTIME_LIBRARIES}
  ${Boost_LIBRARIES}
  ${CPPUNIT_LIBRARIES}
  gnuradio-custom_sink
)

GR_ADD_TEST(test_custom_sink test-custom_sink)

########################################################################
# Print summary
########################################################################
message(STATUS "Using install prefix: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "Building for version: ${VERSION} / ${LIBVER}")

