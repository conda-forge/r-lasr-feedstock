#!/bin/bash
export DISABLE_AUTOBREW=1

if [ "$(uname)" == "Darwin" ]; then
  sed -i.bak 's/-mmacosx-version-min=10.13//g' "${PREFIX}/lib/R/etc/Makeconf"
  export PKG_CPPFLAGS="${PKG_CPPFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY -mmacosx-version-min=10.15"
fi

sed -i.bak 's/${PROJ_LIBS}/${PROJ_LIBS} ${LDFLAGS}/g' configure
sed -i.bak 's/${LIBS}/${LIBS} ${LDFLAGS}/g' configure

${R} CMD INSTALL --build . ${R_ARGS}
