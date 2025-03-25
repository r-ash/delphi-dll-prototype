set -e

current="$(pwd)"
echo $current
trap "cd $current" EXIT

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $here

cmake --build build

echo "Copying DLL into place"
mkdir -p ../TextEditor/Win32/Debug
cp build/Debug/CppWrapper.dll ../TextEditor/Win32/Debug/
