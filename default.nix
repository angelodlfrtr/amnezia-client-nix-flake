{
  stdenv,
  fetchFromGitHub,
  qtbase,
  cmake,
  gcc,
  qt6,
  gnumake,
  pkg-config,
  libsecret,
  wrapQtAppsHook,
}:
stdenv.mkDerivation {
  pname = "amnezia-client";
  version = "4.7.0.0";
  src = fetchFromGitHub {
    owner = "amnezia-vpn";
    repo = "amnezia-client";
    rev = "4.7.0.0";
    sha256 = "NJ5qPci02PwNqLmZpfhCkiWR68Kllp+luVPFGwecAsE=";
    fetchSubmodules = true;
  };

  buildInputs = [
    qtbase
    qt6.full
    cmake
    gnumake
    pkg-config
    gcc
    libsecret
  ];

  nativeBuildInputs = [
    wrapQtAppsHook
  ];

  dontConfigure = true;
  # dontInstall = true;

  # echo "Run qt-cmake -S ."
  # qt-cmake -S .
  buildPhase = ''
    cmake -DCMAKE_TOOLCHAIN_FILE="${qtbase}/lib/cmake/Qt6/qt.toolchain.cmake" -S .
    cmake --build . --config release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./client/AmneziaVPN $out/bin/AmneziaVPN
  '';
}
