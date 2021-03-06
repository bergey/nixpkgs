{ stdenv, fetchurl, alsaLib, libX11, makeWrapper, tcl, tk }:

stdenv.mkDerivation  rec {
  pname = "vkeybd";
  version = "0.1.18d";

  src = fetchurl {
    url = "ftp://ftp.suse.com/pub/people/tiwai/vkeybd/${pname}-${version}.tar.bz2";
    sha256 = "0107b5j1gf7dwp7qb4w2snj4bqiyps53d66qzl2rwj4jfpakws5a";
  };

  buildInputs = [ alsaLib libX11 makeWrapper tcl tk ];

  configurePhase = ''
    mkdir -p $out/bin
    sed -e "s@/usr/local@$out@" -i Makefile
  '';

  makeFlags = [ "TKLIB=-l${tk.libPrefix}" "TCLLIB=-l${tcl.libPrefix}" ];

  postInstall = ''
    wrapProgram $out/bin/vkeybd --set TK_LIBRARY "${tk}/lib/${tk.libPrefix}"
  '';

  meta = with stdenv.lib; {
    description = "Virtual MIDI keyboard";
    homepage = http://www.alsa-project.org/~tiwai/alsa.html;
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.goibhniu ];
  };
}
