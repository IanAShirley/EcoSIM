module ErosionMod
  use data_kind_mod, only : r8 => DAT_KIND_R8
  use minimathmod, only : test_aeqb,AZMAX1
  use MicrobialDataType
  use SOMDataType
  use EcoSIMSolverPar
  use FertilizerDataType
  use GridConsts
  use FlagDataType
  use SoilPhysDataType
  use EcoSIMCtrlDataType
  use SoilWaterDataType
  use LandSurfDataType
  use SurfSoilDataType
  use ChemTranspDataType
  use AqueChemDatatype
  use SoilPropertyDataType
  USE SedimentDataType
  use GridDataType
  use EcoSIMConfig, only : nlbiomcp => nlbiomcpc, ndbiomcp=> ndbiomcpc
  use EcoSIMConfig, only : jcplx1=> jcplx1c, NFGs => NFGsc,jcplx=>jcplxc
  use EcoSIMConfig, only : column_mode
  implicit none

  private
  character(len=*),private, parameter :: mod_filename = __FILE__

  real(r8), PARAMETER :: FSINK=0.01_r8

  real(r8), allocatable :: RERSED(:,:,:,:)
  real(r8), allocatable :: TERSED(:,:)
  real(r8), allocatable :: RDTSED(:,:)
  real(r8), allocatable :: FVOLIM(:,:)
  real(r8), allocatable :: FVOLWM(:,:)
  real(r8), allocatable :: FERSNM(:,:)
  real(r8), allocatable :: RERSED0(:,:)

  public :: erosion
  public :: InitErosion
  public :: DestructErosion
  contains

  subroutine InitErosion()

  implicit none

  allocate(RERSED(2,2,JV,JH))
  allocate(TERSED(JY,JX))
  allocate(RDTSED(JY,JX))
  allocate(FVOLIM(JY,JX))
  allocate(FVOLWM(JY,JX))
  allocate(FERSNM(JY,JX))
  allocate(RERSED0(JY,JX))

  end subroutine InitErosion
!------------------------------------------------------------------------------------------

  SUBROUTINE erosion(I,J,NHW,NHE,NVN,NVS)
      !
!     THIS SUBROUTINE CALCULATES DETACHMENT AND OVERLAND TRANSPORT
!     OF SURFACE SEDIMENT FROM PRECIPITATION IN WEATHER FILE AND
!     FROM RUNOFF IN 'WATSUB'
      implicit none

  integer, intent(in) :: I, J
  integer, intent(in) :: NHW,NHE,NVN,NVS
  integer :: M

!     execution begins here
!
  DO M=1,NPH
    call SedimentDetachment(M,NHW,NHE,NVN,NVS)

    call SedimentTransport(M,NHW,NHE,NVN,NVS)
  ENDDO
!
!     INTERNAL SEDIMENT FLUXES
!
  call InternalSedimentFluxes(NHW, NHE,NVN,NVS)
!
!     EXTERNAL BOUNDARY SEDIMENT FLUXES
!
  if(.not.column_mode)call ExternalSedimentFluxes(NHW,NHE,NVN,NVS)

  END subroutine erosion
!---------------------------------------------------------------------------------------------------

  subroutine SedimentDetachment(M,NHW,NHE,NVN,NVS)
!     INTERNAL TIME STEP AT WHICH SEDIMENT DETACHMENT AND TRANSPORT
!     IS CALCULATED. DETACHMENT IS THE SUM OF THAT BY RAINFALL AND
!     OVERLAND FLOW
!
  implicit none

  integer, intent(in) :: M,NHW,NHE,NVN,NVS
  real(r8) :: DETW,SEDX,CSEDD,CSEDX
  real(r8) :: DEPI,DETI,DETR,STPR
  integer :: NY,NX

  DO  NX=NHW,NHE
    DO  NY=NVN,NVS
      IF(IERSNG.EQ.1.OR.IERSNG.EQ.3)THEN
        TERSED(NY,NX)=0._r8
        RDTSED(NY,NX)=0._r8
        FVOLIM(NY,NX)=AMIN1(1.0_r8,AZMAX1(XVOLIM(M,NY,NX)/VOLWG(NY,NX)))
        FVOLWM(NY,NX)=AMIN1(1.0_r8,AZMAX1(XVOLWM(M,NY,NX)/VOLWG(NY,NX)))
        FERSNM(NY,NX)=(1.0_r8-FVOLIM(NY,NX))*FVOLWM(NY,NX)
!
!     DETACHMENT BY RAINFALL WHEN SURFACE WATER IS PRESENT
!
        IF(BKDS(NU(NY,NX),NY,NX).GT.ZERO.AND.ENGYPM(M,NY,NX).GT.0.0_r8 &
          .AND.XVOLWM(M,NY,NX).GT.ZEROS(NY,NX))THEN
!
!     DETACHMENT OF SEDIMENT FROM SURFACE SOIL DEPENDS ON RAINFALL
!     KINETIC ENERGY AND FROM DETACHMENT COEFFICIENT IN 'HOUR1'
!     ATTENUATED BY DEPTH OF SURFACE WATER
!
          DETW=DETS(NY,NX)*(1.0+2.0*VOLWM(M,NU(NY,NX),NY,NX)/VOLA(NU(NY,NX),NY,NX))
          DETR=AMIN1(BKVL(NU(NY,NX),NY,NX)*XNPX &
            ,DETW*ENGYPM(M,NY,NX)*AREA(3,NU(NY,NX),NY,NX) &
            *FMPR(NU(NY,NX),NY,NX)*FSNX(NY,NX)*(1.0-FVOLIM(NY,NX)))
          RDTSED(NY,NX)=RDTSED(NY,NX)+DETR
        ENDIF
!
!     DEPOSITION OF SEDIMENT TO SOIL SURFACE FROM IMMOBILE SURFACE WATER
!
        SEDX=SED(NY,NX)+RDTSED(NY,NX)
        IF(BKDS(NU(NY,NX),NY,NX).GT.ZERO.AND.SEDX.GT.ZEROS(NY,NX) &
          .AND.XVOLTM(M,NY,NX).LE.VOLWG(NY,NX) &
          .AND.FERSNM(NY,NX).GT.ZERO)THEN
          CSEDD=AZMAX1(SEDX/XVOLWM(M,NY,NX))
          DEPI=AMAX1(-SEDX,VLS(NY,NX)*(0.0-CSEDD)*AREA(3,NU(NY,NX),NY,NX) &
            *FERSNM(NY,NX)*FMPR(NU(NY,NX),NY,NX)*XNPH)
          RDTSED(NY,NX)=RDTSED(NY,NX)+DEPI
        ENDIF
!
!     DETACHMENT IN SURFACE WATER FROM OVERLAND WATER
!     VELOCITY FROM 'WATSUB' USED TO CALCULATE STREAM POWER,
!     AND FROM SEDIMENT TRANSPORT CAPACITY VS. CURRENT SEDIMENT
!     CONCENTRATION IN SURFACE WATER, MODIFIED BY SOIL COHESION
!     FROM 'HOUR1'
!
!     PTDSNU=particle density
!
        IF(BKDS(NU(NY,NX),NY,NX).GT.ZERO.AND.XVOLTM(M,NY,NX).GT.VOLWG(NY,NX) &
          .AND.FERSNM(NY,NX).GT.ZERO)THEN
          STPR=1.0E+02*QRV(M,NY,NX)*ABS(SLOPE(0,NY,NX))
          CSEDX=PTDSNU(NY,NX)*CER(NY,NX)*AZMAX1(STPR-0.4)**XER(NY,NX)
          CSEDD=AZMAX1(SEDX/XVOLWM(M,NY,NX))
          IF(CSEDX.GT.CSEDD)THEN
            DETI=AMIN1(BKVL(NU(NY,NX),NY,NX)*XNPX &
              ,DETE(NY,NX)*(CSEDX-CSEDD)*AREA(3,NU(NY,NX),NY,NX) &
              *FERSNM(NY,NX)*FMPR(NU(NY,NX),NY,NX)*XNPH)
          ELSE
            IF(SEDX.GT.ZEROS(NY,NX))THEN
              DETI=AMAX1(-SEDX,VLS(NY,NX)*(CSEDX-CSEDD)*AREA(3,NU(NY,NX),NY,NX) &
                *FERSNM(NY,NX)*FMPR(NU(NY,NX),NY,NX)*XNPH)
            ELSE
              DETI=0._r8
            ENDIF
          ENDIF
          RDTSED(NY,NX)=RDTSED(NY,NX)+DETI
        ENDIF
!
!     TRANSPORT OF SEDIMENT IN OVERLAND FLOW FROM SEDIMENT
!     CONCENTRATION TIMES OVERLAND WATER FLUX FROM 'WATSUB'
!
        call OverLandFlowSedTransp(M,NY,NX,NHW,NHE,NVN,NVS)

      ENDIF
    ENDDO
  ENDDO
  end subroutine SedimentDetachment
!------------------------------------------------------------------------------------------
  subroutine OverLandFlowSedTransp(M,NY,NX,NHW,NHE,NVN,NVS)

  implicit none
  integer, intent(in) :: M,NY,NX,NHW,NHE,NVN,NVS
  integer :: N1,N2,N,NN,N4,N5,N4B,N5B
  real(r8) :: SEDX,CSEDE,FERM

  N1=NX
  N2=NY
!     SEDX=SED(N2,N1)
  IF(QRM(M,N2,N1).LE.0.0.OR.BKDS(NU(N2,N1),N2,N1).LE.ZERO)THEN
    RERSED0(N2,N1)=0._r8
  ELSE
    IF(XVOLWM(M,N2,N1).GT.ZEROS2(N2,N1))THEN
      SEDX=SED(N2,N1)+RDTSED(N2,N1)
      CSEDE=AZMAX1(SEDX/XVOLWM(M,N2,N1))
       RERSED0(N2,N1)=AMIN1(SEDX,CSEDE*QRM(M,N2,N1)*(1.0-FVOLIM(N2,N1)))
    ELSE
      RERSED0(N2,N1)=0._r8
    ENDIF
  ENDIF
!
!     LOCATE INTERNAL BOUNDARIES
!
  IF(RERSED0(N2,N1).GT.0.0_r8)THEN
    DO  N=1,2
      DO  NN=1,2
        IF(N.EQ.1)THEN
          IF(NX.EQ.NHE.AND.NN.EQ.1.OR.NX.EQ.NHW.AND.NN.EQ.2)THEN
            cycle
          ELSE
            N4=NX+1
            N5=NY
            N4B=NX-1
            N5B=NY
          ENDIF
        ELSEIF(N.EQ.2)THEN
          IF(NY.EQ.NVS.AND.NN.EQ.1.OR.NY.EQ.NVN.AND.NN.EQ.2)THEN
            cycle
          ELSE
            N4=NX
            N5=NY+1
            N4B=NX
            N5B=NY-1
          ENDIF
        ENDIF
        IF(RERSED0(N2,N1).GT.ZEROS(N2,N1))THEN
          IF(NN.EQ.1)THEN
            FERM=QRMN(M,N,2,N5,N4)/QRM(M,N2,N1)
            RERSED(N,2,N5,N4)=RERSED0(N2,N1)*FERM
            XSEDER(N,2,N5,N4)=XSEDER(N,2,N5,N4)+RERSED(N,2,N5,N4)
          ELSE
            RERSED(N,2,N5,N4)=0._r8
          ENDIF
          IF(NN.EQ.2)THEN
            IF(N4B.GT.0.AND.N5B.GT.0)THEN
              FERM=QRMN(M,N,1,N5B,N4B)/QRM(M,N2,N1)
              RERSED(N,1,N5B,N4B)=RERSED0(N2,N1)*FERM
              XSEDER(N,1,N5B,N4B)=XSEDER(N,1,N5B,N4B)+RERSED(N,1,N5B,N4B)

            ELSE
              RERSED(N,1,N5B,N4B)=0._r8
            ENDIF
          ENDIF
        ELSE
          RERSED(N,2,N5,N4)=0._r8
          IF(N4B.GT.0.AND.N5B.GT.0)THEN
            RERSED(N,1,N5B,N4B)=0._r8
          ENDIF
        ENDIF
      ENDDO
    ENDDO

  ENDIF
  end subroutine OverLandFlowSedTransp
!------------------------------------------------------------------------------------------
  subroutine SedimentTransport(M,NHW,NHE,NVN,NVS)
!     INTERNAL TIME STEP AT WHICH SEDIMENT DETACHMENT AND TRANSPORT
!     IS CALCULATED. DETACHMENT IS THE SUM OF THAT BY RAINFALL AND
!     OVERLAND FLOW
!
  implicit none

  integer, intent(in) :: M,NHW,NHE,NVN,NVS

  real(r8) :: CSEDE,SEDX
  integer :: NGL
  integer :: N1,N2,NY,NX
!
!     BOUNDARY SEDIMENT FLUXES
!
  DO  NX=NHW,NHE
    DO  NY=NVN,NVS
      IF(IERSNG.EQ.1.OR.IERSNG.EQ.3)THEN
        N1=NX
        N2=NY
        IF(QRM(M,N2,N1).LE.0.0.OR.BKDS(NU(N2,N1),N2,N1).LE.ZERO)THEN
          RERSED0(N2,N1)=0._r8
        ELSE
          IF(XVOLWM(M,N2,N1).GT.ZEROS2(N2,N1))THEN
            SEDX=SED(NY,NX)+RDTSED(NY,NX)
            CSEDE=AZMAX1(SEDX/XVOLWM(M,N2,N1))
            RERSED0(N2,N1)=AMIN1(SEDX,CSEDE*QRM(M,N2,N1))
          ELSE
            RERSED0(N2,N1)=0._r8
          ENDIF
        ENDIF
!
        if(.not. column_mode)call XBoundSedTransp(M,NY,NX,NHW,NHE,NVN,NVS,N1,N2)

      ENDIF
    ENDDO
  ENDDO
!
!     UPDATE STATE VARIABLES FOR SEDIMENT TRANSPORT
!
  DO  NX=NHW,NHE
    DO  NY=NVN,NVS
      IF(IERSNG.EQ.1.OR.IERSNG.EQ.3)THEN
        SED(NY,NX)=SED(NY,NX)+TERSED(NY,NX)+RDTSED(NY,NX)
      ENDIF
    ENDDO
  ENDDO
  end subroutine SedimentTransport
!------------------------------------------------------------------------------------------
  subroutine XBoundSedTransp(M,NY,NX,NHW,NHE,NVN,NVS,N1,N2)

  implicit none
  integer, intent(in) :: M,N1,N2,NY,NX,NHW,NHE,NVN,NVS
!     LOCATE EXTERNAL BOUNDARIES
!
  integer :: N,NN,N4,N5,N4B,N5B
  integer :: M1,M2,M4,M5
  real(r8) :: RCHQF,FERM,XN

  D9580: DO  N=1,2
    D9575: DO  NN=1,2
      IF(N.EQ.1)THEN
        N4=NX+1
        N5=NY
        N4B=NX-1
        N5B=NY
        IF(NN.EQ.1)THEN
          IF(NX.EQ.NHE)THEN
            M1=NX
            M2=NY
            M4=NX+1
            M5=NY
            XN=-1.0_r8
            RCHQF=RCHQE(M2,M1)
          ELSE
            cycle
          ENDIF
        ELSEIF(NN.EQ.2)THEN
          IF(NX.EQ.NHW)THEN
            M1=NX
            M2=NY
            M4=NX
            M5=NY
            XN=1.0_r8
            RCHQF=RCHQW(M5,M4)
          ELSE
            cycle
          ENDIF
        ENDIF
      ELSEIF(N.EQ.2)THEN
        N4=NX
        N5=NY+1
        N4B=NX
        N5B=NY-1
        IF(NN.EQ.1)THEN
          IF(NY.EQ.NVS)THEN
            M1=NX
            M2=NY
            M4=NX
            M5=NY+1
            XN=-1.0_r8
            RCHQF=RCHQS(M2,M1)
          ELSE
            cycle
          ENDIF
        ELSEIF(NN.EQ.2)THEN
          IF(NY.EQ.NVN)THEN
            M1=NX
            M2=NY
            M4=NX
            M5=NY
            XN=1.0_r8
            RCHQF=RCHQN(M5,M4)
          ELSE
            cycle
          ENDIF
        ENDIF
      ENDIF
!
!     SEDIMENT TRANSPORT ACROSS BOUNDARY FROM BOUNDARY RUNOFF
!     IN 'WATSUB' TIMES BOUNDARY SEDIMENT CONCENTRATION IN
!     SURFACE WATER
!
      IF(IRCHG(NN,N,N2,N1).EQ.0.OR.test_aeqb(RCHQF,0._r8) &
        .OR.RERSED0(N2,N1).LE.ZEROS(N2,N1))THEN
        RERSED(N,NN,M5,M4)=0._r8
      ELSE
        IF(QRM(M,N2,N1).GT.ZEROS(N2,N1))THEN
          IF((NN.EQ.1.AND.QRMN(M,N,NN,M5,M4).GT.ZEROS(N2,N1)) &
            .OR.(NN.EQ.2.AND.QRMN(M,N,NN,M5,M4).LT.ZEROS(N2,N1)))THEN
            FERM=QRMN(M,N,NN,M5,M4)/QRM(M,N2,N1)
            RERSED(N,NN,M5,M4)=RERSED0(N2,N1)*FERM
            XSEDER(N,NN,M5,M4)=XSEDER(N,NN,M5,M4)+RERSED(N,NN,M5,M4)
          ELSEIF((NN.EQ.2.AND.QRMN(M,N,NN,M5,M4).GT.ZEROS(N2,N1)) &
            .OR.(NN.EQ.1.AND.QRMN(M,N,NN,M5,M4).LT.ZEROS(N2,N1)))THEN
            RERSED(N,NN,M5,M4)=0._r8
          ELSE
            RERSED(N,NN,M5,M4)=0._r8
          ENDIF
        ENDIF
      ENDIF
    ENDDO D9575
!
!     TOTAL SEDIMENT FLUXES
!
    D1202: DO  NN=1,2
      TERSED(N2,N1)=TERSED(N2,N1)+RERSED(N,NN,N2,N1)
      IF(IFLBM(M,N,NN,N5,N4).EQ.0)THEN
        TERSED(N2,N1)=TERSED(N2,N1)-RERSED(N,NN,N5,N4)
      ENDIF
      IF(N4B.GT.0.AND.N5B.GT.0.AND.NN.EQ.1)THEN
        TERSED(N2,N1)=TERSED(N2,N1)-RERSED(N,NN,N5B,N4B)
      ENDIF
    ENDDO D1202
  ENDDO D9580
  end subroutine XBoundSedTransp
!------------------------------------------------------------------------------------------

  subroutine InternalSedimentFluxes(NHW, NHE,NVN,NVS)
  implicit none
  integer, intent(in) :: NHW,NHE,NVN,NVS

  integer :: NGL,NTX,NTP
  integer :: K,NN,N,NO,M,NY,NX
  integer :: N1,N2,N4,N5,N4B,N5B
  real(r8) :: FSEDER

  DO  NX=NHW,NHE
    DO  NY=NVN,NVS
      IF(IERSNG.EQ.1.OR.IERSNG.EQ.3)THEN
        N1=NX
        N2=NY
        DO  N=1,2
          DO  NN=1,2
            IF(N.EQ.1)THEN
              IF(NX.EQ.NHE.AND.NN.EQ.1.OR.NX.EQ.NHW.AND.NN.EQ.2)THEN
                cycle
              ELSE
                N4=NX+1
                N5=NY
                N4B=NX-1
                N5B=NY
              ENDIF
            ELSEIF(N.EQ.2)THEN
              IF(NY.EQ.NVS.AND.NN.EQ.1.OR.NY.EQ.NVN.AND.NN.EQ.2)THEN
                cycle
              ELSE
                N4=NX
                N5=NY+1
                N4B=NX
                N5B=NY-1
              ENDIF
            ENDIF
!
!     FLUXES OF ALL SOLID MATERIALS IN SEDIMENT ARE CALCULATED
!     FROM VALUES OF THEIR CURRENT STATE VARIABLES MULTIPLIED
!     BY THE FRACTION OF THE TOTAL SURFACE LAYER MASS THAT IS
!     TRANSPORTED IN SEDIMENT
!
!     SOIL MINERALS
!
!     *ER=sediment flux from erosion.f
!     sediment code:XSED=total,XSAN=sand,XSIL=silt,XCLA=clay
!
            IF(NN.EQ.1)THEN
              FSEDER=AMIN1(1.0,XSEDER(N,2,N5,N4)/BKVLNU(N2,N1))
              XSANER(N,2,N5,N4)=FSEDER*SAND(NU(N2,N1),N2,N1)
              XSILER(N,2,N5,N4)=FSEDER*SILT(NU(N2,N1),N2,N1)
              XCLAER(N,2,N5,N4)=FSEDER*CLAY(NU(N2,N1),N2,N1)
!
!     FERTILIZER POOLS
!
!     *ER=sediment flux from erosion.f
!     sediment code:NH4,NH3,NHU,NO3=NH4,NH3,urea,NO3 in non-band
!                  :NH4B,NH3B,NHUB,NO3B=NH4,NH3,urea,NO3 in band
!
              XNH4ER(N,2,N5,N4)=FSEDER*FertN_soil(ifert_nh4,NU(N2,N1),N2,N1)
              XNH3ER(N,2,N5,N4)=FSEDER*FertN_soil(ifert_nh3,NU(N2,N1),N2,N1)
              XNHUER(N,2,N5,N4)=FSEDER*FertN_soil(ifert_urea,NU(N2,N1),N2,N1)
              XNO3ER(N,2,N5,N4)=FSEDER*FertN_soil(ifert_no3,NU(N2,N1),N2,N1)

              XNH4EB(N,2,N5,N4)=FSEDER*FertN_band(ifert_nh4_band,NU(N2,N1),N2,N1)
              XNH3EB(N,2,N5,N4)=FSEDER*FertN_band(ifert_nh3_band,NU(N2,N1),N2,N1)
              XNHUEB(N,2,N5,N4)=FSEDER*FertN_band(ifert_urea_band,NU(N2,N1),N2,N1)
              XNO3EB(N,2,N5,N4)=FSEDER*FertN_band(ifert_no3_band,NU(N2,N1),N2,N1)
!
!     EXCHANGEABLE CATIONS AND ANIONS
!
!     sediment code
!       :XN4,XNB=adsorbed NH4 in non-band,band
!       :XHY,XAL,XFE,XCA,XMG,XNA,XKA,XHC,AL2,FE2
!        =adsorbed H,Al,Fe,Ca,Mg,Na,K,HCO3,AlOH2,FeOH2
!       :XOH0,XOH1,XOH2=adsorbed R-,R-OH,R-OH2 in non-band
!       :XOH0B,XOH1B,XOH2B=adsorption sites R-,R-OH,R-OH2 in band
!       :XH1P,XH2P=adsorbed HPO4,H2PO4 in non-band
!       :XH1PB,XP2PB=adsorbed HPO4,H2PO4 in band
!
              DO NTX=idx_beg,idx_end
                trcx_XER(NTX,N,2,N5,N4)=FSEDER*trcx_solml(NTX,NU(N2,N1),N2,N1)
              ENDDO
!
!     PRECIPITATES
!
!     sediment code
!       :PALO,PFEO=precip AlOH,FeOH
!       :PCAC,PCAS=precip CaCO3,CaSO4
!       :PALP,PFEP=precip AlPO4,FEPO4 in non-band
!       :PALPB,PFEPB=precip AlPO4,FEPO4 in band
!       :PCPM,PCPD,PCPH=precip CaH2PO4,CaHPO4,apatite in non-band
!       :PCPMB,PCPDB,PCPHB=precip CaH2PO4,CaHPO4,apatite in band
!
              DO NTP=idsp_beg,idsp_end
                trcp_ER(NTP,N,2,N5,N4)   =FSEDER*trcp_salml(NTP,NU(N2,N1),N2,N1)
              ENDDO
!
!     ORGANIC MATTER
!
              DO  K=1,jcplx
                DO NO=1,NFGs
                  DO NGL=JGnio(NO),JGnfo(NO)
                    DO M=1,nlbiomcp
                      OMCER(M+(NGL-1)*nlbiomcp,K,N,2,N5,N4)=FSEDER*OMC(M,NGL,K,NU(N2,N1),N2,N1)
                      OMNER(M+(NGL-1)*nlbiomcp,K,N,2,N5,N4)=FSEDER*OMN(M,NGL,K,NU(N2,N1),N2,N1)
                      OMPER(M+(NGL-1)*nlbiomcp,K,N,2,N5,N4)=FSEDER*OMP(M,NGL,K,NU(N2,N1),N2,N1)
                    ENDDO
                  ENDDO
                ENDDO
              ENDDO

              DO NO=1,NFGs
                DO NGL=JGniA(NO),JGnfA(NO)
                  DO M=1,nlbiomcp
                    OMCERff(M+(NGL-1)*nlbiomcp,N,2,N5,N4)=FSEDER*OMCff(M,NGL,NU(N2,N1),N2,N1)
                    OMNERff(M+(NGL-1)*nlbiomcp,N,2,N5,N4)=FSEDER*OMNff(M,NGL,NU(N2,N1),N2,N1)
                    OMPERff(M+(NGL-1)*nlbiomcp,N,2,N5,N4)=FSEDER*OMPff(M,NGL,NU(N2,N1),N2,N1)
                  ENDDO
                ENDDO
              ENDDO

              DO  K=1,jcplx
                DO  M=1,ndbiomcp
                  ORCER(M,K,N,2,N5,N4)=FSEDER*ORC(M,K,NU(N2,N1),N2,N1)
                  ORNER(M,K,N,2,N5,N4)=FSEDER*ORN(M,K,NU(N2,N1),N2,N1)
                  ORPER(M,K,N,2,N5,N4)=FSEDER*ORP(M,K,NU(N2,N1),N2,N1)
                ENDDO
                OHCER(K,N,2,N5,N4)=FSEDER*OHC(K,NU(N2,N1),N2,N1)
                OHNER(K,N,2,N5,N4)=FSEDER*OHN(K,NU(N2,N1),N2,N1)
                OHPER(K,N,2,N5,N4)=FSEDER*OHP(K,NU(N2,N1),N2,N1)
                OHAER(K,N,2,N5,N4)=FSEDER*OHA(K,NU(N2,N1),N2,N1)
                DO  M=1,jsken
                  OSCER(M,K,N,2,N5,N4)=FSEDER*OSC(M,K,NU(N2,N1),N2,N1)
                  OSAER(M,K,N,2,N5,N4)=FSEDER*OSA(M,K,NU(N2,N1),N2,N1)
                  OSNER(M,K,N,2,N5,N4)=FSEDER*OSN(M,K,NU(N2,N1),N2,N1)
                  OSPER(M,K,N,2,N5,N4)=FSEDER*OSP(M,K,NU(N2,N1),N2,N1)
                ENDDO
              ENDDO
            ELSE
              XSANER(N,2,N5,N4)=0._r8
              XSILER(N,2,N5,N4)=0._r8
              XCLAER(N,2,N5,N4)=0._r8
!
!     FERTILIZER POOLS
!
              XNH4ER(N,2,N5,N4)=0._r8
              XNH3ER(N,2,N5,N4)=0._r8
              XNHUER(N,2,N5,N4)=0._r8
              XNO3ER(N,2,N5,N4)=0._r8
              XNH4EB(N,2,N5,N4)=0._r8
              XNH3EB(N,2,N5,N4)=0._r8
              XNHUEB(N,2,N5,N4)=0._r8
              XNO3EB(N,2,N5,N4)=0._r8
!
!     EXCHANGEABLE CATIONS AND ANIONS
!
              trcx_XER(idx_beg:idx_end,N,2,N5,N4)=0._r8
!
!     PRECIPITATES
!
              trcp_ER(idsp_beg:idsp_end,N,2,N5,N4)=0._r8
!
!     ORGANIC MATTER
!
              DO  K=1,jcplx
                DO  NO=1,NFGs
                  DO NGL=JGnio(NO),JGnfo(NO)
                    DO  M=1,nlbiomcp
                      OMCER(M+(NGL-1)*nlbiomcp,K,N,2,N5,N4)=0._r8
                      OMNER(M+(NGL-1)*nlbiomcp,K,N,2,N5,N4)=0._r8
                      OMPER(M+(NGL-1)*nlbiomcp,K,N,2,N5,N4)=0._r8
                    enddo
                  ENDDO
                enddo
              ENDDO

              DO  NO=1,NFGs
                DO NGL=JGniA(NO),JGnfA(NO)
                  DO  M=1,nlbiomcp
                    OMCERff(M+(NGL-1)*nlbiomcp,N,2,N5,N4)=0._r8
                    OMNERff(M+(NGL-1)*nlbiomcp,N,2,N5,N4)=0._r8
                    OMPERff(M+(NGL-1)*nlbiomcp,N,2,N5,N4)=0._r8
                  enddo
                ENDDO
              enddo

              DO  K=1,jcplx
                DO  M=1,ndbiomcp
                  ORCER(M,K,N,2,N5,N4)=0._r8
                  ORNER(M,K,N,2,N5,N4)=0._r8
                  ORPER(M,K,N,2,N5,N4)=0._r8
                ENDDO
                OHCER(K,N,2,N5,N4)=0._r8
                OHNER(K,N,2,N5,N4)=0._r8
                OHPER(K,N,2,N5,N4)=0._r8
                OHAER(K,N,2,N5,N4)=0._r8
                DO  M=1,jsken
                  OSCER(M,K,N,2,N5,N4)=0._r8
                  OSAER(M,K,N,2,N5,N4)=0._r8
                  OSNER(M,K,N,2,N5,N4)=0._r8
                  OSPER(M,K,N,2,N5,N4)=0._r8
                ENDDO
              ENDDO
            ENDIF
            IF(NN.EQ.2)THEN
              IF(N4B.GT.0.AND.N5B.GT.0)THEN
                FSEDER=AMIN1(1.0,XSEDER(N,1,N5B,N4B)/BKVLNU(N2,N1))
                XSANER(N,1,N5B,N4B)=FSEDER*SAND(NU(N2,N1),N2,N1)
                XSILER(N,1,N5B,N4B)=FSEDER*SILT(NU(N2,N1),N2,N1)
                XCLAER(N,1,N5B,N4B)=FSEDER*CLAY(NU(N2,N1),N2,N1)
!
!     FERTILIZER POOLS
!
!     *ER=sediment flux from erosion.f
!     sediment code:NH4,NH3,NHU,NO3=NH4,NH3,urea,NO3 in non-band
!                  :NH4B,NH3B,NHUB,NO3B=NH4,NH3,urea,NO3 in band
!
                XNH4ER(N,1,N5B,N4B)=FSEDER*FertN_soil(ifert_nh4,NU(N2,N1),N2,N1)
                XNH3ER(N,1,N5B,N4B)=FSEDER*FertN_soil(ifert_nh3,NU(N2,N1),N2,N1)
                XNHUER(N,1,N5B,N4B)=FSEDER*FertN_soil(ifert_urea,NU(N2,N1),N2,N1)
                XNO3ER(N,1,N5B,N4B)=FSEDER*FertN_soil(ifert_no3,NU(N2,N1),N2,N1)
                XNH4EB(N,1,N5B,N4B)=FSEDER*FertN_band(ifert_nh4_band,NU(N2,N1),N2,N1)
                XNH3EB(N,1,N5B,N4B)=FSEDER*FertN_band(ifert_nh3_band,NU(N2,N1),N2,N1)
                XNHUEB(N,1,N5B,N4B)=FSEDER*FertN_band(ifert_urea_band,NU(N2,N1),N2,N1)
                XNO3EB(N,1,N5B,N4B)=FSEDER*FertN_band(ifert_no3_band,NU(N2,N1),N2,N1)
!
!     EXCHANGEABLE CATIONS AND ANIONS
!
!     sediment code
!       :XN4,XNB=adsorbed NH4 in non-band,band
!       :XHY,XAL,XFE,XCA,XMG,XNA,XKA,XHC,AL2,FE2
!        =adsorbed H,Al,Fe,Ca,Mg,Na,K,HCO3,AlOH2,FeOH2
!       :XOH0,XOH1,XOH2=adsorbed R-,R-OH,R-OH2 in non-band
!       :XOH0B,XOH1B,XOH2B=adsorption sites R-,R-OH,R-OH2 in band
!       :XH1P,XH2P=adsorbed HPO4,H2PO4 in non-band
!       :XH1PB,XP2PB=adsorbed HPO4,H2PO4 in band
!
                DO NTX=idx_beg,idx_end
                  trcx_XER(NTX,N,1,N5B,N4B)=FSEDER*trcx_solml(NTX,NU(N2,N1),N2,N1)
                ENDDO
!
!     PRECIPITATES
!
!     sediment code
!       :PALO,PFEO=precip AlOH,FeOH
!       :PCAC,PCAS=precip CaCO3,CaSO4
!       :PALP,PFEP=precip AlPO4,FEPO4 in non-band
!       :PALPB,PFEPB=precip AlPO4,FEPO4 in band
!       :PCPM,PCPD,PCPH=precip CaH2PO4,CaHPO4,apatite in non-band
!       :PCPMB,PCPDB,PCPHB=precip CaH2PO4,CaHPO4,apatite in band
!
                DO NTP=idsp_beg,idsp_end
                  trcp_ER(NTP,N,1,N5B,N4B)=FSEDER*trcp_salml(NTP,NU(N2,N1),N2,N1)
                ENDDO
!
!     ORGANIC MATTER
!
                DO  K=1,jcplx
                  DO  NO=1,NFGs
                    DO NGL=JGnio(NO),JGnfo(NO)
                      DO  M=1,nlbiomcp
                        OMCER(M+(NGL-1)*nlbiomcp,K,N,1,N5B,N4B)=FSEDER*OMC(M,NGL,K,NU(N2,N1),N2,N1)
                        OMNER(M+(NGL-1)*nlbiomcp,K,N,1,N5B,N4B)=FSEDER*OMN(M,NGL,K,NU(N2,N1),N2,N1)
                        OMPER(M+(NGL-1)*nlbiomcp,K,N,1,N5B,N4B)=FSEDER*OMP(M,NGL,K,NU(N2,N1),N2,N1)
                      enddo
                    enddo
                  ENDDO
                ENDDO
                DO  NO=1,NFGs
                  DO NGL=JGniA(NO),JGnfA(NO)
                    DO  M=1,nlbiomcp
                      OMCERff(M+(NGL-1)*nlbiomcp,N,1,N5B,N4B)=FSEDER*OMCff(M,NGL,NU(N2,N1),N2,N1)
                      OMNERff(M+(NGL-1)*nlbiomcp,N,1,N5B,N4B)=FSEDER*OMNff(M,NGL,NU(N2,N1),N2,N1)
                      OMPERff(M+(NGL-1)*nlbiomcp,N,1,N5B,N4B)=FSEDER*OMPff(M,NGL,NU(N2,N1),N2,N1)
                    enddo
                  enddo
                ENDDO

                DO  K=1,jcplx
                  DO  M=1,ndbiomcp
                    ORCER(M,K,N,1,N5B,N4B)=FSEDER*ORC(M,K,NU(N2,N1),N2,N1)
                    ORNER(M,K,N,1,N5B,N4B)=FSEDER*ORN(M,K,NU(N2,N1),N2,N1)
                    ORPER(M,K,N,1,N5B,N4B)=FSEDER*ORP(M,K,NU(N2,N1),N2,N1)
                  ENDDO
                  OHCER(K,N,1,N5B,N4B)=FSEDER*OHC(K,NU(N2,N1),N2,N1)
                  OHNER(K,N,1,N5B,N4B)=FSEDER*OHN(K,NU(N2,N1),N2,N1)
                  OHPER(K,N,1,N5B,N4B)=FSEDER*OHP(K,NU(N2,N1),N2,N1)
                  OHAER(K,N,1,N5B,N4B)=FSEDER*OHA(K,NU(N2,N1),N2,N1)
                  DO  M=1,jsken
                    OSCER(M,K,N,1,N5B,N4B)=FSEDER*OSC(M,K,NU(N2,N1),N2,N1)
                    OSAER(M,K,N,1,N5B,N4B)=FSEDER*OSA(M,K,NU(N2,N1),N2,N1)
                    OSNER(M,K,N,1,N5B,N4B)=FSEDER*OSN(M,K,NU(N2,N1),N2,N1)
                    OSPER(M,K,N,1,N5B,N4B)=FSEDER*OSP(M,K,NU(N2,N1),N2,N1)
                  ENDDO
                ENDDO
              ELSE
                XSANER(N,1,N5B,N4B)=0._r8
                XSILER(N,1,N5B,N4B)=0._r8
                XCLAER(N,1,N5B,N4B)=0._r8
!
!     FERTILIZER POOLS
!
                XNH4ER(N,1,N5B,N4B)=0._r8
                XNH3ER(N,1,N5B,N4B)=0._r8
                XNHUER(N,1,N5B,N4B)=0._r8
                XNO3ER(N,1,N5B,N4B)=0._r8
                XNH4EB(N,1,N5B,N4B)=0._r8
                XNH3EB(N,1,N5B,N4B)=0._r8
                XNHUEB(N,1,N5B,N4B)=0._r8
                XNO3EB(N,1,N5B,N4B)=0._r8
!
!     EXCHANGEABLE CATIONS AND ANIONS
!
                trcx_XER(idx_beg:idx_end,N,1,N5B,N4B)=0._r8
!
!     PRECIPITATES
!
                trcp_ER(idsp_beg:idsp_end,N,1,N5B,N4B)=0._r8
!
!     ORGANIC MATTER
!
                DO  K=1,jcplx
                  DO  NO=1,NFGs
                    DO NGL=JGnio(NO),JGnfo(NO)
                      DO  M=1,nlbiomcp
                        OMCER(M+(NGL-1)*nlbiomcp,K,N,1,N5B,N4B)=0._r8
                        OMNER(M+(NGL-1)*nlbiomcp,K,N,1,N5B,N4B)=0._r8
                        OMPER(M+(NGL-1)*nlbiomcp,K,N,1,N5B,N4B)=0._r8
                      enddo
                    ENDDO
                  enddo
                ENDDO

                DO  NO=1,NFGs
                  DO NGL=JGniA(NO),JGnfA(NO)
                    DO  M=1,nlbiomcp
                      OMCERff(M+(NGL-1)*nlbiomcp,N,1,N5B,N4B)=0._r8
                      OMNERff(M+(NGL-1)*nlbiomcp,N,1,N5B,N4B)=0._r8
                      OMPERff(M+(NGL-1)*nlbiomcp,N,1,N5B,N4B)=0._r8
                    enddo
                  ENDDO
                enddo

                DO  K=1,jcplx
                  DO  M=1,ndbiomcp
                    ORCER(M,K,N,1,N5B,N4B)=0._r8
                    ORNER(M,K,N,1,N5B,N4B)=0._r8
                    ORPER(M,K,N,1,N5B,N4B)=0._r8
                  ENDDO
                  OHCER(K,N,1,N5B,N4B)=0._r8
                  OHNER(K,N,1,N5B,N4B)=0._r8
                  OHPER(K,N,1,N5B,N4B)=0._r8
                  OHAER(K,N,1,N5B,N4B)=0._r8
                  DO  M=1,jsken
                    OSCER(M,K,N,1,N5B,N4B)=0._r8
                    OSAER(M,K,N,1,N5B,N4B)=0._r8
                    OSNER(M,K,N,1,N5B,N4B)=0._r8
                    OSPER(M,K,N,1,N5B,N4B)=0._r8
                  ENDDO
                ENDDO
              ENDIF
            ENDIF
          ENDDO
        ENDDO
      ENDIF
    ENDDO
  ENDDO
  end subroutine InternalSedimentFluxes
!----------------------------------------------------------------------------------------------

  subroutine ExternalSedimentFluxes(NHW,NHE,NVN,NVS)
  implicit none

  integer, intent(in) :: NHW,NHE,NVN,NVS

  real(r8) :: RCHQF,FSEDER
  integer :: NGL
  integer :: NY,NX
  integer :: N,NN,K,NO,M,NTX,NTP
  integer :: N1,N2,N4,N5
  integer :: M1,M2,M4,M5
  real(r8) :: XN

  DO  NX=NHW,NHE
    DO  NY=NVN,NVS
      IF((IERSNG.EQ.1.OR.IERSNG.EQ.3).AND.BKDS(NU(NY,NX),NY,NX).GT.ZERO)THEN
        N1=NX
        N2=NY
        D8980: DO  N=1,2
          D8975: DO  NN=1,2
            IF(N.EQ.1)THEN
              N4=NX+1
              N5=NY
              IF(NN.EQ.1)THEN
                IF(NX.EQ.NHE)THEN
                  M1=NX
                  M2=NY
                  M4=NX+1
                  M5=NY
                  XN=-1.0_r8
                  RCHQF=RCHQE(M2,M1)
                ELSE
                  cycle
                ENDIF
              ELSEIF(NN.EQ.2)THEN
                IF(NX.EQ.NHW)THEN
                  M1=NX
                  M2=NY
                  M4=NX
                  M5=NY
                  XN=1.0_r8
                  RCHQF=RCHQW(M5,M4)
                ELSE
                  cycle
                ENDIF
              ENDIF
            ELSEIF(N.EQ.2)THEN
              N4=NX
              N5=NY+1
              IF(NN.EQ.1)THEN
                IF(NY.EQ.NVS)THEN
                  M1=NX
                  M2=NY
                  M4=NX
                  M5=NY+1
                  XN=-1.0_r8
                  RCHQF=RCHQS(M2,M1)
                ELSE
                  cycle
                ENDIF
              ELSEIF(NN.EQ.2)THEN
                IF(NY.EQ.NVN)THEN
                  M1=NX
                  M2=NY
                  M4=NX
                  M5=NY
                  XN=1.0_r8
                  RCHQF=RCHQN(M5,M4)
                ELSE
                  cycle
                ENDIF
              ENDIF
            ENDIF
            IF(IRCHG(NN,N,N2,N1).EQ.0.OR.test_aeqb(RCHQF,0._r8) &
              .OR.ABS(XSEDER(N,NN,M5,M4)).LE.ZEROS(N2,N1))THEN
              XSANER(N,NN,M5,M4)=0._r8
              XSILER(N,NN,M5,M4)=0._r8
              XCLAER(N,NN,M5,M4)=0._r8
!
!     FERTILIZER POOLS
!
              XNH4ER(N,NN,M5,M4)=0._r8
              XNH3ER(N,NN,M5,M4)=0._r8
              XNHUER(N,NN,M5,M4)=0._r8
              XNO3ER(N,NN,M5,M4)=0._r8
              XNH4EB(N,NN,M5,M4)=0._r8
              XNH3EB(N,NN,M5,M4)=0._r8
              XNHUEB(N,NN,M5,M4)=0._r8
              XNO3EB(N,NN,M5,M4)=0._r8
!
!     EXCHANGEABLE CATIONS AND ANIONS
!
              trcx_XER(idx_beg:idx_end,N,NN,M5,M4)=0._r8
!
!     PRECIPITATES
!
              trcp_ER(idsp_beg:idsp_end,N,NN,M5,M4)=0._r8
!
!     ORGANIC MATTER
!
              DO  K=1,jcplx
                DO  NO=1,NFGs
                  DO NGL=JGnio(NO),JGnfo(NO)
                    DO  M=1,nlbiomcp
                      OMCER(M+(NGL-1)*nlbiomcp,K,N,NN,M5,M4)=0._r8
                      OMNER(M+(NGL-1)*nlbiomcp,K,N,NN,M5,M4)=0._r8
                      OMPER(M+(NGL-1)*nlbiomcp,K,N,NN,M5,M4)=0._r8
                    enddo
                  ENDDO
                enddo
              enddo
              DO  NO=1,NFGs
                DO NGL=JGniA(NO),JGnfA(NO)
                  DO  M=1,nlbiomcp
                    OMCERff(M+(NGL-1)*nlbiomcp,N,NN,M5,M4)=0._r8
                    OMNERff(M+(NGL-1)*nlbiomcp,N,NN,M5,M4)=0._r8
                    OMPERff(M+(NGL-1)*nlbiomcp,N,NN,M5,M4)=0._r8
                  enddo
                ENDDO
              enddo
              DO  K=1,jcplx
                DO  M=1,ndbiomcp
                  ORCER(M,K,N,NN,M5,M4)=0._r8
                  ORNER(M,K,N,NN,M5,M4)=0._r8
                  ORPER(M,K,N,NN,M5,M4)=0._r8
                ENDDO
                OHCER(K,N,NN,M5,M4)=0._r8
                OHNER(K,N,NN,M5,M4)=0._r8
                OHPER(K,N,NN,M5,M4)=0._r8
                OHAER(K,N,NN,M5,M4)=0._r8
                DO  M=1,jsken
                  OSCER(M,K,N,NN,M5,M4)=0._r8
                  OSAER(M,K,N,NN,M5,M4)=0._r8
                  OSNER(M,K,N,NN,M5,M4)=0._r8
                  OSPER(M,K,N,NN,M5,M4)=0._r8
                ENDDO
              ENDDO
!
!     CALCULATE FRACTION OF SURACE MATERIAL ERODED
!
            ELSE
              FSEDER=AMIN1(1.0,XSEDER(N,NN,N5,N4)/BKVLNU(N2,N1))
!
!     SOIL MINERALS
!
              XSANER(N,NN,M5,M4)=FSEDER*SAND(NU(N2,N1),N2,N1)
              XSILER(N,NN,M5,M4)=FSEDER*SILT(NU(N2,N1),N2,N1)
              XCLAER(N,NN,M5,M4)=FSEDER*CLAY(NU(N2,N1),N2,N1)
!
!     FERTILIZER POOLS
!
              XNH4ER(N,NN,M5,M4)=FSEDER*FertN_soil(ifert_nh4,NU(N2,N1),N2,N1)
              XNH3ER(N,NN,M5,M4)=FSEDER*FertN_soil(ifert_nh3,NU(N2,N1),N2,N1)
              XNHUER(N,NN,M5,M4)=FSEDER*FertN_soil(ifert_urea,NU(N2,N1),N2,N1)
              XNO3ER(N,NN,M5,M4)=FSEDER*FertN_soil(ifert_no3,NU(N2,N1),N2,N1)
              XNH4EB(N,NN,M5,M4)=FSEDER*FertN_band(ifert_nh4_band,NU(N2,N1),N2,N1)
              XNH3EB(N,NN,M5,M4)=FSEDER*FertN_band(ifert_nh3_band,NU(N2,N1),N2,N1)
              XNHUEB(N,NN,M5,M4)=FSEDER*FertN_band(ifert_urea_band,NU(N2,N1),N2,N1)
              XNO3EB(N,NN,M5,M4)=FSEDER*FertN_band(ifert_no3_band,NU(N2,N1),N2,N1)
!
!     EXCHANGEABLE CATIONS AND ANIONS
!
              DO NTX=idx_beg,idx_end
                trcx_XER(NTX,N,NN,M5,M4)=FSEDER*trcx_solml(NTX,NU(N2,N1),N2,N1)
              ENDDO
!
!     PRECIPITATES
!
              DO NTP=idsp_beg,idsp_end
                trcp_ER(NTP,N,NN,M5,M4)=FSEDER*trcp_salml(NTP,NU(N2,N1),N2,N1)
              ENDDO
!
!     ORGANIC MATTER
!
              DO  K=1,jcplx
                DO NO=1,NFGs
                  DO NGL=JGnio(NO),JGnfo(NO)
                    DO M=1,nlbiomcp
                      OMCER(M+(NGL-1)*nlbiomcp,K,N,NN,M5,M4)=FSEDER*OMC(M,NGL,K,NU(N2,N1),N2,N1)
                      OMNER(M+(NGL-1)*nlbiomcp,K,N,NN,M5,M4)=FSEDER*OMN(M,NGL,K,NU(N2,N1),N2,N1)
                      OMPER(M+(NGL-1)*nlbiomcp,K,N,NN,M5,M4)=FSEDER*OMP(M,NGL,K,NU(N2,N1),N2,N1)
                    ENDDO
                  ENDDO
                ENDDO
              ENDDO
              DO NO=1,NFGs
                DO NGL=JGniA(NO),JGnfo(NO)
                  DO M=1,nlbiomcp
                    OMCERff(M+(NGL-1)*nlbiomcp,N,NN,M5,M4)=FSEDER*OMCff(M,NGL,NU(N2,N1),N2,N1)
                    OMNERff(M+(NGL-1)*nlbiomcp,N,NN,M5,M4)=FSEDER*OMNff(M,NGL,NU(N2,N1),N2,N1)
                    OMPERff(M+(NGL-1)*nlbiomcp,N,NN,M5,M4)=FSEDER*OMPff(M,NGL,NU(N2,N1),N2,N1)
                  ENDDO
                ENDDO
              ENDDO

              DO  K=1,jcplx
                DO  M=1,ndbiomcp
                  ORCER(M,K,N,NN,M5,M4)=FSEDER*ORC(M,K,NU(N2,N1),N2,N1)
                  ORNER(M,K,N,NN,M5,M4)=FSEDER*ORN(M,K,NU(N2,N1),N2,N1)
                  ORPER(M,K,N,NN,M5,M4)=FSEDER*ORP(M,K,NU(N2,N1),N2,N1)
                ENDDO
                OHCER(K,N,NN,M5,M4)=FSEDER*OHC(K,NU(N2,N1),N2,N1)
                OHNER(K,N,NN,M5,M4)=FSEDER*OHN(K,NU(N2,N1),N2,N1)
                OHPER(K,N,NN,M5,M4)=FSEDER*OHP(K,NU(N2,N1),N2,N1)
                OHAER(K,N,NN,M5,M4)=FSEDER*OHA(K,NU(N2,N1),N2,N1)
                DO  M=1,jsken
                  OSCER(M,K,N,NN,M5,M4)=FSEDER*OSC(M,K,NU(N2,N1),N2,N1)
                  OSAER(M,K,N,NN,M5,M4)=FSEDER*OSA(M,K,NU(N2,N1),N2,N1)
                  OSNER(M,K,N,NN,M5,M4)=FSEDER*OSN(M,K,NU(N2,N1),N2,N1)
                  OSPER(M,K,N,NN,M5,M4)=FSEDER*OSP(M,K,NU(N2,N1),N2,N1)
                ENDDO
              ENDDO
            ENDIF
          ENDDO D8975
        ENDDO D8980
      ENDIF
    ENDDO
  ENDDO

  end subroutine ExternalSedimentFluxes

!------------------------------------------------------------------------------------------
  subroutine DestructErosion()
  use abortutils, only : destroy

  implicit none

  call destroy(RERSED)
  call destroy(TERSED)
  call destroy(RDTSED)
  call destroy(FVOLIM)
  call destroy(FVOLWM)
  call destroy(FERSNM)
  call destroy(RERSED0)

  end subroutine DestructErosion
  end module ErosionMod
