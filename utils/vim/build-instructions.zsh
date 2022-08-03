CLANG64=/clang64
export PATH=$CLANG64/bin:/usr/bin
export CC=clang
export CXX=clang++
# 
# build
# 
cd src
make -f Make_ming.mak clean
make -f Make_ming.mak \
    PYTHON3=$CLANG64 \
    PYTHON3_VER=310 \
    PYTHON3_HOME=$CLANG64 \
    PYTHON3INC=-I$CLANG64/include/python3.10 \
    DYNAMIC_PYTHON3=yes \
    DYNAMIC_PYTHON3_DLL=libpython3.10.dll
# 
# package
# 
mkdir dist
rm -rf dist
cp -rf runtime dist
cp src/gvim.exe dist/
cp src/tee/tee.exe dist/
cp src/xxd/xxd.exe dist/
cp vimtutor.bat dist/
cp vimtutor.exe dist/
cp /$CLANG64/bin/libc++.dll
cp /$CLANG64/bin/libunwind.dll