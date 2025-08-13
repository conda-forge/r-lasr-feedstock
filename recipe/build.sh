#!/bin/bash
export DISABLE_AUTOBREW=1

# Set compiler flags for macOS compatibility
if [[ "${target_platform}" == "osx-"* ]]; then
  export PKG_CPPFLAGS="-D_LIBCPP_DISABLE_AVAILABILITY ${PKG_CPPFLAGS}"
  # Ensure OpenMP is properly linked on macOS
  export PKG_LIBS="${PKG_LIBS} -lomp"
fi

# Set GDAL and PROJ environment variables for proper detection
export GDAL_CONFIG="${PREFIX}/bin/gdal-config"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Ensure configure script can find dependencies
if [[ -f configure ]]; then
  sed -i.bak 's/${PROJ_LIBS}/${PROJ_LIBS} ${LDFLAGS}/g' configure
  sed -i.bak 's/${LIBS}/${LIBS} ${LDFLAGS}/g' configure
fi

${R} CMD INSTALL --build . ${R_ARGS}
