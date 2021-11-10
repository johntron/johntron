export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:/usr/local/opt/tbb@2020_u3
export CPATH=${CPATH}:/usr/local/opt/tbb@2020_u3/include
export LIBRARY_PATH=${LIBRARY_PATH}:/usr/local/opt/tbb@2020_u3/lib
export CMAKE_MODULE_PATH=/usr/local/share/OGRE-2.1/cmake/modules
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/usr/local/Cellar/ogre1.9/1.9-20160714-108ab0bcc69603dba32c0ffd4bbbc39051f421c9_10/lib/pkgconfig/

#rm -rf build
#mkdir -p build
(\
cd build \
&& cmake .. \
&& make\
)