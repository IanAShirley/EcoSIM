
      real(r8) :: XOH1B(0:JZ,JY,JX),XOH2B(0:JZ,JY,JX) &
      ,XH1PB(0:JZ,JY,JX),XH2PB(0:JZ,JY,JX) &
      ,PALOH(JZ,JY,JX),PFEOH(JZ,JY,JX),PCACO(JZ,JY,JX) &
      ,PCASO(JZ,JY,JX),PALPO(0:JZ,JY,JX),PFEPO(0:JZ,JY,JX) &
      ,PCAPD(0:JZ,JY,JX),PCAPH(0:JZ,JY,JX),PCAPM(0:JZ,JY,JX) &
      ,PALPB(0:JZ,JY,JX),PFEPB(0:JZ,JY,JX),PCPDB(0:JZ,JY,JX) &
      ,PCPMB(0:JZ,JY,JX),ECND(JZ,JY,JX),CSTR(JZ,JY,JX) &
      ,CION(JZ,JY,JX),XCEC(JZ,JY,JX),XAEC(JZ,JY,JX),ALSGL(JZ,JY,JX) &
      ,FESGL(JZ,JY,JX),HYSGL(JZ,JY,JX),CASGL(JZ,JY,JX),GMSGL(JZ,JY,JX) &
      ,ANSGL(JZ,JY,JX),AKSGL(JZ,JY,JX),OHSGL(JZ,JY,JX),C3SGL(JZ,JY,JX) &
      ,HCSGL(JZ,JY,JX),SOSGL(JZ,JY,JX),CLSXL(JZ,JY,JX),ZALH(JZ,JY,JX) &
      ,ZFEH(JZ,JY,JX),ZHYH(JZ,JY,JX),ZCCH(JZ,JY,JX),ZMAH(JZ,JY,JX) &
      ,ZNAH(JZ,JY,JX),ZKAH(JZ,JY,JX),ZOHH(JZ,JY,JX),ZSO4H(JZ,JY,JX) &
      ,ZCLH(JZ,JY,JX),ZCO3H(JZ,JY,JX),ZHCO3H(JZ,JY,JX),ZALO1H(JZ,JY,JX) &
      ,ZALO2H(JZ,JY,JX),ZALO3H(JZ,JY,JX),ZALO4H(JZ,JY,JX) &
      ,ZALSH(JZ,JY,JX),ZFEO1H(JZ,JY,JX),ZFEO2H(JZ,JY,JX) &
      ,ZFEO3H(JZ,JY,JX),ZFEO4H(JZ,JY,JX),ZFESH(JZ,JY,JX) &
      ,ZCAOH(JZ,JY,JX),ZCACH(JZ,JY,JX),ZCAHH(JZ,JY,JX),ZCASH(JZ,JY,JX) &
      ,PCPHB(0:JZ,JY,JX)


      COMMON/BLK19B/XOH1B,XOH2B &
      ,XH1PB,XH2PB &
      ,PALOH,PFEOH,PCACO &
      ,PCASO,PALPO,PFEPO &
      ,PCAPD,PCAPH,PCAPM &
      ,PALPB,PFEPB,PCPDB &
      ,PCPMB,ECND,CSTR &
      ,CION,XCEC,XAEC,ALSGL &
      ,FESGL,HYSGL,CASGL,GMSGL &
      ,ANSGL,AKSGL,OHSGL,C3SGL &
      ,HCSGL,SOSGL,CLSXL,ZALH &
      ,ZFEH,ZHYH,ZCCH,ZMAH &
      ,ZNAH,ZKAH,ZOHH,ZSO4H &
      ,ZCLH,ZCO3H,ZHCO3H,ZALO1H &
      ,ZALO2H,ZALO3H,ZALO4H &
      ,ZALSH,ZFEO1H,ZFEO2H &
      ,ZFEO3H,ZFEO4H,ZFESH &
      ,ZCAOH,ZCACH,ZCAHH,ZCASH &
      ,PCPHB