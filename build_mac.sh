#!/bin/sh

SCRATCH="scratch"
DEST=`pwd`/"bin"

ARCHS="i386 x86_64"
MIN_OSX_VERSION="10.6"
COMPILER="darwin-i386-cc"
OSX_SDK=10.11

if [ "$*" ]
then
	ARCHS="$*"
fi

CWD=`pwd`

for ARCH in $ARCHS
do
	SPHINXBASE_DIR=`pwd`/../sphinxbase/bin/$ARCH
	echo "building $ARCH..."
	mkdir -p "$SCRATCH/$ARCH"
	cd "$SCRATCH/$ARCH"

	
	if [ "$ARCH" == "i386" ]; then
		COMPILER="darwin-i386-cc"
	else
		COMPILER="darwin64-x86_64-cc"
	fi
	

	PLATFORM="MacOSX"
	OSX_CFLAGS="-arch $ARCH -mmacosx-version-min=$MIN_OSX_VERSION"
	

	HOST_TYPE="${ARCH}-apple-darwin"
	if [ "${ARCH}" == "arm64" ]; then
        # Fix unknown type for arm64 cpu (which is aarch64)
	    HOST_TYPE="aarch64-apple-darwin"
	fi

	export DEVELOPER=`xcode-select --print-path`
	export DEVROOT="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer"
	export SDKROOT="${DEVROOT}/SDKs/${PLATFORM}${OSX_SDK}.sdk"
	export CC=`xcrun -find clang`
	export LD=`xcrun -find ld`
	export CFLAGS="-O3 ${OSX_CFLAGS} -isysroot ${SDKROOT}"
	export LDFLAGS="${OSX_CFLAGS} -isysroot ${SDKROOT}"
	export CPPFLAGS="${CFLAGS}"

	$CWD/configure \
	    --host="${HOST_TYPE}" \
	    --prefix="$DEST/$ARCH" \
	    --without-lapack \
	    --without-python \
	    --with-sphinxbase="$SPHINXBASE_DIR" \
	|| exit 1

	make -j3 install || exit 1
	cd $CWD
done

echo Done
