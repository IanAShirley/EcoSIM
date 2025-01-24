module TFlxTypeMod

  use GridDataType
  use data_kind_mod, only : r8 => DAT_KIND_R8
  use abortutils, only : destroy
  use TracerIDMod
  use EcoSIMConfig, only : jcplx => jcplxc,jsken=>jskenc,NFGs=>NFGsc
  use EcoSIMConfig, only : nlbiomcp=>nlbiomcpc,ndbiomcp=>ndbiomcpc
implicit none

  character(len=*), private, parameter :: mod_filename = __FILE__

  public
  real(r8),allocatable ::  trcg_TBLS(:,:,:,:)
  real(r8),allocatable ::  trcn_TBLS(:,:,:,:)
  real(r8),allocatable ::  trcsa_TBLS(:,:,:,:)                      !
  real(r8),allocatable ::  trcs_TFLS(:,:,:,:)                      !
  real(r8),allocatable ::  trcs_TFHS(:,:,:,:)                      !
  real(r8),allocatable ::  TQR(:,:)                           !
  real(r8),allocatable ::  THQR(:,:)                          !
  real(r8),allocatable ::  TQS(:,:)                           !
  real(r8),allocatable ::  TQW(:,:)                           !
  real(r8),allocatable ::  TQI(:,:)                           !
  real(r8),allocatable ::  THQS(:,:)                          !
  real(r8),allocatable ::  TFLWS(:,:,:)                       !
  real(r8),allocatable ::  TFLWW(:,:,:)                       !
  real(r8),allocatable ::  TFLWI(:,:,:)                       !
  real(r8),allocatable ::  THFLWW(:,:,:)                      !
  real(r8),allocatable ::  trcg_TQR(:,:,:)                        !
  real(r8),allocatable ::  trcn_TQR(:,:,:)                        !

  real(r8),allocatable ::  trcsa_TQR(:,:,:)                         !
                    !
  real(r8),allocatable ::  trcg_QSS(:,:,:)
  real(r8),allocatable ::  trcn_QSS(:,:,:)
  real(r8),allocatable ::  TCOQSS(:,:)                        !
  real(r8),allocatable ::  TCHQSS(:,:)                        !
  real(r8),allocatable ::  TOXQSS(:,:)                        !
  real(r8),allocatable ::  TNGQSS(:,:)                        !
  real(r8),allocatable ::  TN2QSS(:,:)                        !
  real(r8),allocatable ::  TN4QSS(:,:)                        !
  real(r8),allocatable ::  TN3QSS(:,:)                        !
  real(r8),allocatable ::  TNOQSS(:,:)                        !
  real(r8),allocatable ::  TPOQSS(:,:)                        !
  real(r8),allocatable ::  TP1QSS(:,:)                        !

  real(r8),allocatable ::  trcsa_TFLS(:,:,:,:)                      !
  real(r8),allocatable ::  trcsa_TFHS(:,:,:,:)                      !

  real(r8),allocatable ::  TSANER(:,:)                        !
  real(r8),allocatable ::  TSILER(:,:)                        !
  real(r8),allocatable ::  TCLAER(:,:)                        !
  real(r8),allocatable ::  TNH4ER(:,:)                        !
  real(r8),allocatable ::  TNH3ER(:,:)                        !
  real(r8),allocatable ::  TNHUER(:,:)                        !
  real(r8),allocatable ::  TNO3ER(:,:)                        !
  real(r8),allocatable ::  TNH4EB(:,:)                        !
  real(r8),allocatable ::  TNH3EB(:,:)                        !
  real(r8),allocatable ::  TNHUEB(:,:)                        !
  real(r8),allocatable ::  TNO3EB(:,:)                        !
  real(r8),allocatable ::  trcx_TER(:,:,:)                         !
  real(r8),allocatable ::  trcp_TER(:,:,:)                        !
  real(r8),allocatable ::  TSEDER(:,:)                        !
  real(r8),allocatable ::  TFLW(:,:,:)                        !
  real(r8),allocatable ::  TFLWX(:,:,:)                       !
  real(r8),allocatable ::  THFLW(:,:,:)                       !
  real(r8),allocatable ::  TFLWH(:,:,:)                       !

  real(r8),allocatable ::  RTGasADFlx(:,:,:,:)                      !

  real(r8),allocatable ::  TTHAW(:,:,:)                       !
  real(r8),allocatable ::  THTHAW(:,:,:)                      !
  real(r8),allocatable ::  TTHAWH(:,:,:)                      !
  real(r8),allocatable ::  VOLW1(:,:,:)                       !
  real(r8),allocatable ::  VOLI1(:,:,:)                       !
  real(r8),allocatable ::  VOLWH1(:,:,:)                      !
  real(r8),allocatable ::  VOLIH1(:,:,:)                      !

  real(r8),allocatable :: TOMCER(:,:,:,:,:)
  real(r8),allocatable :: TOMNER(:,:,:,:,:)
  real(r8),allocatable :: TOMPER(:,:,:,:,:)

  real(r8),allocatable :: trcsa_TQS(:,:,:)
  real(r8),allocatable :: TOMCERff(:,:,:,:)
  real(r8),allocatable :: TOMNERff(:,:,:,:)
  real(r8),allocatable :: TOMPERff(:,:,:,:)

  real(r8),allocatable ::  TOCFLS(:,:,:,:)
  real(r8),allocatable ::  TONFLS(:,:,:,:)
  real(r8),allocatable ::  TOPFLS(:,:,:,:)
  real(r8),allocatable ::  TOAFLS(:,:,:,:)
  real(r8),allocatable ::  TOCFHS(:,:,:,:)
  real(r8),allocatable ::  TONFHS(:,:,:,:)
  real(r8),allocatable ::  TOPFHS(:,:,:,:)
  real(r8),allocatable ::  TOAFHS(:,:,:,:)
  real(r8),allocatable ::  TOCQRS(:,:,:)
  real(r8),allocatable ::  TONQRS(:,:,:)
  real(r8),allocatable ::  TOPQRS(:,:,:)
  real(r8),allocatable ::  TOAQRS(:,:,:)
  real(r8),allocatable ::  TORCER(:,:,:,:)
  real(r8),allocatable ::  TORNER(:,:,:,:)
  real(r8),allocatable ::  TORPER(:,:,:,:)
  real(r8),allocatable ::  TOHCER(:,:,:)
  real(r8),allocatable ::  TOHNER(:,:,:)
  real(r8),allocatable ::  TOHPER(:,:,:)
  real(r8),allocatable ::  TOHAER(:,:,:)
  real(r8),allocatable ::  TOSCER(:,:,:,:)
  real(r8),allocatable ::  TOSAER(:,:,:,:)
  real(r8),allocatable ::  TOSNER(:,:,:,:)
  real(r8),allocatable ::  TOSPER(:,:,:,:)

  real(r8) :: TDLYXF,TDYLXC,TDVOLI,TDORGC
  DATA TDORGC,TDYLXC/0.0,0.0/
  DATA TDVOLI,TDLYXF/0.0,0.0/


  contains

!------------------------------------------------------------------------------------------

  subroutine InitTflxType()

  implicit none

  allocate(trcg_TBLS(idg_beg:idg_end-1,JS,JY,JX)); trcg_TBLS=0._r8
  allocate(trcn_TBLS(ids_nut_beg:ids_nuts_end,JS,JY,JX)); trcn_TBLS=0._r8
  allocate(trcsa_TBLS(idsa_beg:idsa_end,JS,JY,JX));   trcsa_TBLS=0._r8
  allocate(trcs_TFHS(ids_beg:ids_end,JZ,JY,JX));   trcs_TFHS=0._r8
  allocate(RTGasADFlx(idg_beg:idg_end-1,JZ,JY,JX));   RTGasADFlx=0._r8

  allocate(TQR(JY,JX));         TQR=0._r8
  allocate(THQR(JY,JX));        THQR=0._r8
  allocate(TQS(JY,JX));         TQS=0._r8
  allocate(TQW(JY,JX));         TQW=0._r8
  allocate(TQI(JY,JX));         TQI=0._r8
  allocate(THQS(JY,JX));        THQS=0._r8
  allocate(TFLWS(JS,JY,JX));    TFLWS=0._r8
  allocate(TFLWW(JS,JY,JX));    TFLWW=0._r8
  allocate(TFLWI(JS,JY,JX));    TFLWI=0._r8
  allocate(THFLWW(JS,JY,JX));   THFLWW=0._r8

  allocate(trcg_TQR(idg_beg:idg_end-1,JY,JX));      trcg_TQR=0._r8
  allocate(trcsa_TQR(idsa_beg:idsa_end,JY,JX));       trcsa_TQR=0._r8
  allocate(trcn_TQR(ids_nut_beg:ids_nuts_end,JY,JX));      trcn_TQR=0._r8
  allocate(trcg_QSS(idg_beg:idg_end-1,JY,JX));trcg_QSS=0._r8
  allocate(trcn_QSS(ids_nut_beg:ids_nuts_end,JY,JX));trcn_QSS=0._r8

  allocate(TCOQSS(JY,JX));      TCOQSS=0._r8
  allocate(TCHQSS(JY,JX));      TCHQSS=0._r8
  allocate(TOXQSS(JY,JX));      TOXQSS=0._r8
  allocate(TNGQSS(JY,JX));      TNGQSS=0._r8
  allocate(TN2QSS(JY,JX));      TN2QSS=0._r8
  allocate(TN4QSS(JY,JX));      TN4QSS=0._r8
  allocate(TN3QSS(JY,JX));      TN3QSS=0._r8
  allocate(TNOQSS(JY,JX));      TNOQSS=0._r8
  allocate(TPOQSS(JY,JX));      TPOQSS=0._r8
  allocate(TP1QSS(JY,JX));      TP1QSS=0._r8

  allocate(trcsa_TFLS(idsa_beg:idsab_end,JZ,JY,JX)); trcsa_TFLS=0._r8
  allocate(trcsa_TFHS(idsa_beg:idsab_end,JZ,JY,JX)); trcsa_TFHS=0._r8

  allocate(TSANER(JY,JX));      TSANER=0._r8
  allocate(TSILER(JY,JX));      TSILER=0._r8
  allocate(TCLAER(JY,JX));      TCLAER=0._r8
  allocate(TNH4ER(JY,JX));      TNH4ER=0._r8
  allocate(TNH3ER(JY,JX));      TNH3ER=0._r8
  allocate(TNHUER(JY,JX));      TNHUER=0._r8
  allocate(TNO3ER(JY,JX));      TNO3ER=0._r8
  allocate(TNH4EB(JY,JX));      TNH4EB=0._r8
  allocate(TNH3EB(JY,JX));      TNH3EB=0._r8
  allocate(TNHUEB(JY,JX));      TNHUEB=0._r8
  allocate(TNO3EB(JY,JX));      TNO3EB=0._r8

  allocate(trcx_TER(idx_beg:idx_end,JY,JX));    trcx_TER=0._r8
  allocate(trcp_TER(idsp_beg:idsp_end,JY,JX));      trcp_TER=0._r8
  allocate(trcs_TFLS(ids_beg:ids_end,JZ,JY,JX));   trcs_TFLS=0._r8

  allocate(TSEDER(JY,JX));      TSEDER=0._r8
  allocate(TFLW(JZ,JY,JX));     TFLW=0._r8
  allocate(TFLWX(JZ,JY,JX));    TFLWX=0._r8
  allocate(THFLW(JZ,JY,JX));    THFLW=0._r8
  allocate(TFLWH(JZ,JY,JX));    TFLWH=0._r8
  allocate(TTHAW(JZ,JY,JX));    TTHAW=0._r8
  allocate(THTHAW(JZ,JY,JX));   THTHAW=0._r8
  allocate(TTHAWH(JZ,JY,JX));   TTHAWH=0._r8
  allocate(VOLW1(JZ,JY,JX));    VOLW1=0._r8
  allocate(VOLI1(JZ,JY,JX));    VOLI1=0._r8
  allocate(VOLWH1(JZ,JY,JX));   VOLWH1=0._r8
  allocate(VOLIH1(JZ,JY,JX));   VOLIH1=0._r8
  allocate(TOMCER(nlbiomcp,NMICBSO,1:jcplx,JY,JX)); TOMCER=0._r8
  allocate(TOMNER(nlbiomcp,NMICBSO,1:jcplx,JY,JX)); TOMNER=0._r8
  allocate(TOMPER(nlbiomcp,NMICBSO,1:jcplx,JY,JX)); TOMPER=0._r8

  allocate(TOMCERff(nlbiomcp,NMICBSA,JY,JX));TOMCERff=0._r8
  allocate(TOMNERff(nlbiomcp,NMICBSA,JY,JX));TOMNERff=0._r8
  allocate(TOMPERff(nlbiomcp,NMICBSA,JY,JX));TOMPERff=0._r8

  allocate(TOCFLS(1:jcplx,JZ,JY,JX));TOCFLS=0._r8
  allocate(TONFLS(1:jcplx,JZ,JY,JX));TONFLS=0._r8
  allocate(TOPFLS(1:jcplx,JZ,JY,JX));TOPFLS=0._r8
  allocate(TOAFLS(1:jcplx,JZ,JY,JX));TOAFLS=0._r8
  allocate(TOCFHS(1:jcplx,JZ,JY,JX));TOCFHS=0._r8
  allocate(TONFHS(1:jcplx,JZ,JY,JX));TONFHS=0._r8
  allocate(TOPFHS(1:jcplx,JZ,JY,JX));TOPFHS=0._r8
  allocate(TOAFHS(1:jcplx,JZ,JY,JX));TOAFHS=0._r8
  allocate(TOCQRS(1:jcplx,JY,JX));TOCQRS=0._r8
  allocate(TONQRS(1:jcplx,JY,JX));TONQRS=0._r8
  allocate(TOPQRS(1:jcplx,JY,JX));TOPQRS=0._r8
  allocate(TOAQRS(1:jcplx,JY,JX));TOAQRS=0._r8
  allocate(TORCER(ndbiomcp,1:jcplx,JY,JX));TORCER=0._r8
  allocate(TORNER(ndbiomcp,1:jcplx,JY,JX));TORNER=0._r8
  allocate(TORPER(ndbiomcp,1:jcplx,JY,JX));TORPER=0._r8
  allocate(TOHCER(1:jcplx,JY,JX));TOHCER=0._r8
  allocate(TOHNER(1:jcplx,JY,JX));TOHNER=0._r8
  allocate(TOHPER(1:jcplx,JY,JX));TOHPER=0._r8
  allocate(TOHAER(1:jcplx,JY,JX));TOHAER=0._r8
  allocate(TOSCER(jsken,1:jcplx,JY,JX));TOSCER=0._r8
  allocate(TOSAER(jsken,1:jcplx,JY,JX));TOSAER=0._r8
  allocate(TOSNER(jsken,1:jcplx,JY,JX));TOSNER=0._r8
  allocate(TOSPER(jsken,1:jcplx,JY,JX));TOSPER=0._r8
  allocate(trcsa_TQS(idsa_beg:idsa_end,JY,JX));trcsa_TQS=0._r8
  end subroutine InitTflxType


!------------------------------------------------------------------------------------------

  subroutine DestructTflxType

  implicit none

  call destroy(trcx_TER)

  call destroy(TOMCER)
  call destroy(TOMNER)
  call destroy(TOMPER)
  call destroy(TOMCERff)
  call destroy(TOMNERff)
  call destroy(TOMPERff)
  call destroy(TOCFLS)
  call destroy(TONFLS)
  call destroy(TOPFLS)
  call destroy(TOAFLS)
  call destroy(TOCFHS)
  call destroy(TONFHS)
  call destroy(TOPFHS)
  call destroy(TOAFHS)
  call destroy(TOCQRS)
  call destroy(TONQRS)
  call destroy(TOPQRS)
  call destroy(TOAQRS)
  call destroy(TORCER)
  call destroy(TORNER)
  call destroy(TORPER)
  call destroy(TOHCER)
  call destroy(TOHNER)
  call destroy(TOHPER)
  call destroy(TOHAER)
  call destroy(TOSCER)
  call destroy(TOSAER)
  call destroy(TOSNER)
  call destroy(TOSPER)
  call destroy(trcsa_TFLS)
  call destroy(trcs_TFLS)
  call destroy(trcsa_TQS)
  call destroy(trcg_TBLS)
  call destroy(trcn_TBLS)

  call destroy(trcsa_TQR)
  call destroy(trcsa_TFHS)
  call destroy(TQR)
  call destroy(THQR)
  call destroy(TQS)
  call destroy(TQW)
  call destroy(TQI)
  call destroy(THQS)
  call destroy(TFLWS)
  call destroy(TFLWW)
  call destroy(TFLWI)
  call destroy(THFLWW)

  call destroy(trcs_TFHS)
  call destroy(trcg_QSS)
  call destroy(trcn_QSS)
  call destroy(TCOQSS)
  call destroy(TCHQSS)
  call destroy(TOXQSS)
  call destroy(TNGQSS)
  call destroy(TN2QSS)
  call destroy(TN4QSS)
  call destroy(TN3QSS)
  call destroy(TNOQSS)
  call destroy(TPOQSS)
  call destroy(TP1QSS)

  call destroy(TSANER)
  call destroy(TSILER)
  call destroy(TCLAER)
  call destroy(TNH4ER)
  call destroy(TNH3ER)
  call destroy(TNHUER)
  call destroy(TNO3ER)
  call destroy(TNH4EB)
  call destroy(TNH3EB)
  call destroy(TNHUEB)
  call destroy(TNO3EB)
  call destroy(TSEDER)
  call destroy(TFLW)
  call destroy(TFLWX)
  call destroy(THFLW)
  call destroy(TFLWH)
  call destroy(TTHAW)
  call destroy(THTHAW)
  call destroy(TTHAWH)
  call destroy(VOLW1)
  call destroy(VOLI1)
  call destroy(VOLWH1)
  call destroy(VOLIH1)

  call destroy(trcp_TER)
  call destroy(RTGasADFlx)
  call destroy(trcg_TQR)
  call destroy(trcn_TQR)
  end subroutine DestructTflxType
end module TFlxTypeMod
