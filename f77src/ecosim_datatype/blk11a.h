      real(r8) :: BARE(JY,JX),CVRD(JY,JX),TCS(0:JZ,JY,JX)
     2,TKS(0:JZ,JY,JX),TCW(JS,JY,JX),TKW(JS,JY,JX),RAC(JY,JX)
     3,TSMX(0:JZ,JY,JX),TSMN(0:JZ,JY,JX),VHCP(0:JZ,JY,JX)
     4,VHCPW(JS,JY,JX),VOLW(0:JZ,JY,JX),VOLI(0:JZ,JY,JX)
     5,VOLP(0:JZ,JY,JX),VOLWH(JZ,JY,JX),VOLT(0:JZ,JY,JX)
     6,VOLTI(0:JZ,JY,JX),VOLR(JY,JX),VOLWG(JY,JX),TVOLWC(JY,JX)
     7,VOLSSL(JS,JY,JX),VOLWSL(JS,JY,JX),VOLISL(JS,JY,JX)
     8,VOLSL(JS,JY,JX),VOLSS(JY,JX),VOLWS(JY,JX),VOLIS(JY,JX)
     9,VOLS(JY,JX),THETW(0:JZ,JY,JX),THETI(0:JZ,JY,JX)
     1,THETP(0:JZ,JY,JX),PSISM(0:JZ,JY,JX),PSIST(0:JZ,JY,JX)
     2,RSCS(JZ,JY,JX),VOLA(0:JZ,JY,JX),VOLAH(JZ,JY,JX)
     3,CNDH(JZ,JY,JX),CNDU(JZ,JY,JX),VOLWD(JY,JX)
     4,VHCM(0:JZ,JY,JX),VOLWX(0:JZ,JY,JX),STC(JZ,JY,JX)
     5,DTC(JZ,JY,JX),HCND(3,100,0:JZ,JY,JX),FINH(JZ,JY,JX)
     6,THAW(JZ,JY,JX),HTHAW(JZ,JY,JX)
     7,THAWH(JZ,JY,JX),VOLIH(JZ,JY,JX),DENSS(JS,JY,JX)
     8,DPTHS(JY,JX),DLYRS(JS,JY,JX),XFLWW(JS,JY,JX),XFLWS(JS,JY,JX)
     9,XFLWI(JS,JY,JX),XHFLWW(JS,JY,JX),XWFLXS(JS,JY,JX)
     1,XWFLXI(JS,JY,JX),XTHAWW(JS,JY,JX),FLWR(JY,JX),XW
     2,HFLWR(JY,JX),TFLWCI(JY,JX),TFLWC(JY,JX),THRMG(JY,JX)
     3,HEATI(JY,JX),HEATE(JY,JX),HEATS(JY,JX),HEATV(JY,JX)
     4,HEATH(JY,JX),TEVAPG(JY,JX),VHCPWX(JY,JX),VHCPRX(JY,JX)
     5,VHCPNX(JY,JX),VOLWRX(JY,JX),CDPTHS(0:JS,JY,JX)
     7,CGSGL(JZ,JY,JX),CLSGL(0:JZ,JY,JX),OGSGL(JZ,JY,JX)
     8,OLSGL(0:JZ,JY,JX),ZGSGL(JZ,JY,JX),CHSGL(JZ,JY,JX)
     9,CQSGL(0:JZ,JY,JX),VOLSI(JS,JY,JX),FSNW(JY,JX),FSNX(JY,JX)
     1,THETWZ(0:JZ,JY,JX),THETIZ(0:JZ,JY,JX)

      COMMON/BLK11A/BARE,CVRD,TCS
     2,TKS,TCW,TKW,RAC
     3,TSMX,TSMN,VHCP
     4,VHCPW,VOLW,VOLI
     5,VOLP,VOLWH,VOLT
     6,VOLTI,VOLR,VOLWG,TVOLWC
     7,VOLSSL,VOLWSL,VOLISL
     8,VOLSL,VOLSS,VOLWS,VOLIS
     9,VOLS,THETW,THETI
     1,THETP,PSISM,PSIST
     2,RSCS,VOLA,VOLAH
     3,CNDH,CNDU,VOLWD
     4,VHCM,VOLWX,STC
     5,DTC,HCND,FINH
     6,THAW,HTHAW
     7,THAWH,VOLIH,DENSS
     8,DPTHS,DLYRS,XFLWW,XFLWS
     9,XFLWI,XHFLWW,XWFLXS
     1,XWFLXI,XTHAWW,FLWR,XW
     2,HFLWR,TFLWCI,TFLWC,THRMG
     3,HEATI,HEATE,HEATS,HEATV
     4,HEATH,TEVAPG,VHCPWX,VHCPRX
     5,VHCPNX,VOLWRX,CDPTHS
     7,CGSGL,CLSGL,OGSGL
     8,OLSGL,ZGSGL,CHSGL
     9,CQSGL,VOLSI,FSNW,FSNX
     1,THETWZ,THETIZ