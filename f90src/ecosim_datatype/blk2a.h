
      real(r8) :: TMPX(366),TMPN(366),SRAD(366),RAIN(366),WIND(366) &
      ,DWPT(2,366),TMPH(24,366),SRADH(24,366),RAINH(24,366) &
      ,WINDH(24,366),DWPTH(24,366),TCA(JY,JX),TKA(JY,JX),UA(JY,JX) &
      ,VPA(JY,JX),VPK(JY,JX),DYLN(JY,JX),DYLX(JY,JX),ALTZ(JY,JX) &
      ,PRECU(JY,JX),PRECR(JY,JX),PRECW(JY,JX),PRECI(JY,JX) &
      ,PRECQ(JY,JX),PRECA(JY,JX),GSIN(JY,JX),GCOS(JY,JX),GAZI(JY,JX) &
      ,OMEGAG(4,JY,JX),SL(JY,JX),ASP(JY,JX),ZS(JY,JX),ZD(JY,JX) &
      ,ZR(JY,JX),ZM(JY,JX),Z0(JY,JX),ALT(JY,JX),DTBLY(JY,JX) &
      ,RAB(JY,JX),RIB(JY,JX),THS(JY,JX),DTBLI(JY,JX),TRAD(JY,JX) &
      ,TAMX(JY,JX),TAMN(JY,JX),HUDX(JY,JX),HUDN(JY,JX),TWIND(JY,JX) &
      ,TRAI(JY,JX),THSX(JY,JX),OFFSET(JY,JX),DH(JY,JX),WDPTHD(366,JY,JX) &
      ,DV(JY,JX),DTBLDI(JY,JX),PRECD(JY,JX),PRECB(JY,JX) &
      ,FERT(20,366,JY,JX),FDPTH(366,JY,JX),RRIG(24,366,JY,JX) &
      ,WDPTH(366,JY,JX),DCORP(366,JY,JX),CO2EI(JY,JX),CCO2EI(JY,JX) &
      ,OXYE(JY,JX),COXYE(JY,JX),Z2OE(JY,JX),CZ2OE(JY,JX),Z2GE(JY,JX) &
      ,CZ2GE(JY,JX),ZNH3E(JY,JX),CNH3E(JY,JX),CH4E(JY,JX),CCH4E(JY,JX) &
      ,H2GE(JY,JX),CH2GE(JY,JX),DPTHT(JY,JX),ALTIG,ALTI(JY,JX) &
      ,ZNOON(JY,JX),VAP,VAPS,DTBLX(JY,JX),CO2E(JY,JX),CCO2E(JY,JX) &
      ,RADS(JY,JX),RADY(JY,JX),RAPS(JY,JX),RAPY(JY,JX),SSIN(JY,JX) &
      ,SSINN(JY,JX),SCOS,SAZI,TYSIN,RCHGNU(JY,JX),RCHGEU(JY,JX) &
      ,RCHGSU(JY,JX),RCHGWU(JY,JX),RCHGNT(JY,JX),RCHGET(JY,JX) &
      ,RCHGST(JY,JX),RCHGWT(JY,JX),RCHQN(JY,JX),RCHQE(JY,JX) &
      ,RCHQS(JY,JX),RCHQW(JY,JX),RCHGD(JY,JX),DTBLG(JY,JX) &
      ,DPTHA(JY,JX),ROWN(JY,JX),ROWO(JY,JX),ROWP(JY,JX),ROWI(366,JY,JX) &
      ,FIRRA(JY,JX),CIRRA(JY,JX),DIRRA(2,JY,JX),XRADH(24,366) &
      ,DTBLZ(JY,JX),TLEX(JY,JX),TSHX(JY,JX),TLEC(JY,JX) &
      ,TSHC(JY,JX),DPTHSK(JY,JX),TKSD(JY,JX),TCNDG &
      ,DTBLD(JY,JX),ATCAI(JY,JX),RAD(JY,JX),RAP(JY,JX) &
      ,ATCA(JY,JX),ATCS(JY,JX),ATKA(JY,JX),ATKS(JY,JX),ENGYP(JY,JX)
      integer :: IDTBL(JY,JX),ITILL(366,JY,JX),IIRRA(4,JY,JX) &
      ,IRCHG(2,2,JY,JX),IFLBH(2,2,JY,JX)


      COMMON/BLK2A/TMPX,TMPN,SRAD,RAIN,WIND &
      ,DWPT,TMPH,SRADH,RAINH &
      ,WINDH,DWPTH,TCA,TKA,UA &
      ,VPA,VPK,DYLN,DYLX,ALTZ &
      ,PRECU,PRECR,PRECW,PRECI &
      ,PRECQ,PRECA,GSIN,GCOS,GAZI &
      ,OMEGAG,SL,ASP,ZS,ZD &
      ,ZR,ZM,Z0,ALT,DTBLY &
      ,RAB,RIB,THS,DTBLI,TRAD &
      ,TAMX,TAMN,HUDX,HUDN,TWIND &
      ,TRAI,THSX,OFFSET,DH,WDPTHD &
      ,DV,DTBLDI,PRECD,PRECB &
      ,FERT,FDPTH,RRIG &
      ,WDPTH,DCORP,CO2EI,CCO2EI &
      ,OXYE,COXYE,Z2OE,CZ2OE,Z2GE &
      ,CZ2GE,ZNH3E,CNH3E,CH4E,CCH4E &
      ,H2GE,CH2GE,DPTHT,ALTIG,ALTI &
      ,ZNOON,VAP,VAPS,DTBLX,CO2E,CCO2E &
      ,RADS,RADY,RAPS,RAPY,SSIN &
      ,SSINN,SCOS,SAZI,TYSIN,RCHGNU,RCHGEU &
      ,RCHGSU,RCHGWU,RCHGNT,RCHGET &
      ,RCHGST,RCHGWT,RCHQN,RCHQE &
      ,RCHQS,RCHQW,RCHGD,DTBLG &
      ,DPTHA,ROWN,ROWO,ROWP,ROWI &
      ,FIRRA,CIRRA,DIRRA,XRADH &
      ,DTBLZ,TLEX,TSHX,TLEC &
      ,TSHC,DPTHSK,TKSD,TCNDG &
      ,DTBLD,ATCAI,RAD,RAP &
      ,ATCA,ATCS,ATKA,ATKS,ENGYP &
      ,IDTBL,ITILL,IIRRA,IRCHG &
      ,IFLBH