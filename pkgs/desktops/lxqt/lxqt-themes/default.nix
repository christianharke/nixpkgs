{ stdenv, fetchFromGitHub, cmake, lxqt }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "lxqt-themes";
  version = "0.13.0-1";

  src = fetchFromGitHub {
    owner = "christianharke";
    repo = pname;
    rev = version;
    sha256 = "1xh13sqcwbp405srkm4swxxf9444ba0l4prjgkvnv93f8h8ijvrm";
  };

  nativeBuildInputs = [
    cmake
    lxqt.lxqt-build-tools
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "DESTINATION \"\''${LXQT_GRAPHICS_DIR}" "DESTINATION \"share/lxqt/graphics"
    substituteInPlace themes/CMakeLists.txt \
      --replace "DESTINATION \"\''${LXQT_SHARE_DIR}" "DESTINATION \"share/lxqt"
  '';

  meta = with stdenv.lib; {
    description = "Themes, graphics and icons for LXQt";
    homepage = https://github.com/lxqt/lxqt-themes;
    license = licenses.lgpl21;
    platforms = with platforms; unix;
    maintainers = with maintainers; [ romildo ];
  };
}
