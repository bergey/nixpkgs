{stdenv, fetchurl}:

stdenv.mkDerivation rec {
  name = "popt-1.16";

  src = fetchurl {
    url = "http://rpm5.org/files/popt/${name}.tar.gz";
    sha256 = "1j2c61nn2n351nhj4d25mnf3vpiddcykq005w2h6kw79dwlysa77";
  };

  patches = stdenv.lib.optionals stdenv.isCygwin [
    ./1.16-cygwin.patch
    ./1.16-vpath.patch
  ];

  doCheck = false; # fails

  meta = with stdenv.lib; {
    description = "Command line option parsing library";
    platforms = platforms.unix;
    license = licenses.mit;
  };
}
