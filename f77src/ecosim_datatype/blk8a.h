      real(r8) :: PSIFC(JY,JX),PSIWP(JY,JX),FMPR(0:JZ,JY,JX)
     1,ALBS(JY,JX),CDPTH(0:JZ,JY,JX),ROCK(JZ,JY,JX),TSED(JY,JX)
     2,BKDS(0:JZ,JY,JX),FC(0:JZ,JY,JX),WP(0:JZ,JY,JX),SCNV(0:JZ,JY,JX)
     3,SCNH(JZ,JY,JX),CSAND(JZ,JY,JX),CSILT(JZ,JY,JX),CCLAY(JZ,JY,JX)
     4,FHOL(JZ,JY,JX),PHOL(JZ,JY,JX),DHOL(JZ,JY,JX),HRAD(JZ,JY,JX)
     5,BKDSI(JZ,JY,JX),PH(0:JZ,JY,JX),CEC(JZ,JY,JX),AEC(JZ,JY,JX)
     6,CORGC(0:JZ,JY,JX),CORGR(JZ,JY,JX),CORGN(JZ,JY,JX),CORGP(JZ,JY,JX)
     7,CNH4(JZ,JY,JX),CNO3(JZ,JY,JX),CPO4(JZ,JY,JX),CAL(JZ,JY,JX)
     8,CFE(JZ,JY,JX),CCA(JZ,JY,JX),CMG(JZ,JY,JX),CNA(JZ,JY,JX)
     9,CKA(JZ,JY,JX),CSO4(JZ,JY,JX),CCL(JZ,JY,JX),CALOH(JZ,JY,JX)
     1,CFEOH(JZ,JY,JX),CCACO(JZ,JY,JX),CCASO(JZ,JY,JX),CALPO(JZ,JY,JX)
     2,CFEPO(JZ,JY,JX),CCAPD(JZ,JY,JX),CCAPH(JZ,JY,JX),SED(JY,JX)
     3,GKC4(JZ,JY,JX),GKCH(JZ,JY,JX),GKCA(JZ,JY,JX),GKCM(JZ,JY,JX)
     4,GKCN(JZ,JY,JX),GKCK(JZ,JY,JX),THW(JZ,JY,JX),THI(JZ,JY,JX)
     5,RSC(0:2,0:JZ,JY,JX),RSN(0:2,0:JZ,JY,JX),RSP(0:2,0:JZ,JY,JX)
     6,CNOFC(4,0:2),CPOFC(4,0:2),DETS(JY,JX),DETE(JY,JX),CER(JY,JX)
     7,XER(JY,JX),SLOPE(0:3,JY,JX),CDPTHI(JY,JX),CORGCI(JZ,JY,JX)
     8,POROSI(JZ,JY,JX),FHOLI(JZ,JY,JX),PTDSNU(JY,JX),VLS(JY,JX)
      integer :: NU(JY,JX),NUI(JY,JX),NJ(JY,JX),NK(JY,JX)
     1,NLI(JV,JH),NL(JV,JH),ISOILR(JY,JX),NHOL(JZ,JY,JX),NUM(JY,JX)

      COMMON/BLK8A/PSIFC,PSIWP,FMPR
     1,ALBS,CDPTH,ROCK,TSED
     2,BKDS,FC,WP,SCNV
     3,SCNH,CSAND,CSILT,CCLAY
     4,FHOL,PHOL,DHOL,HRAD
     5,BKDSI,PH,CEC,AEC
     6,CORGC,CORGR,CORGN,CORGP
     7,CNH4,CNO3,CPO4,CAL
     8,CFE,CCA,CMG,CNA
     9,CKA,CSO4,CCL,CALOH
     1,CFEOH,CCACO,CCASO,CALPO
     2,CFEPO,CCAPD,CCAPH,SED
     3,GKC4,GKCH,GKCA,GKCM
     4,GKCN,GKCK,THW,THI
     5,RSC,RSN,RSP
     6,CNOFC,CPOFC,DETS,DETE,CER
     7,XER,SLOPE,CDPTHI,CORGCI
     8,POROSI,FHOLI,PTDSNU,VLS
     9,NU,NUI,NJ,NK,NLI,NL
     1,ISOILR,NHOL,NUM