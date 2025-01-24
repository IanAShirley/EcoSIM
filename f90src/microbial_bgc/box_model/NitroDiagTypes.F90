module NitroDiagTypes
  ! !PUBLIC TYPES:
  use data_kind_mod, only : r8 => DAT_KIND_R8
  USE abortutils, only : destroy
  use EcoSiMParDataMod, only : micpar
  implicit none
  save
  private
  character(len=*), parameter :: mod_filename = __FILE__

! accumulative flux diagnostics
type, public :: NitroAQMFluxDiagType
! ratios
    real(r8) :: TFNH4B
    real(r8) :: TFNO3B
    real(r8) :: TFNO2B
    real(r8) :: TFP14B
    real(r8) :: TFPO4B
    real(r8) :: TCH4H
    real(r8) :: TCH4A
    real(r8) :: TFOQC
    real(r8) :: TFOQA
    real(r8) :: TFOXYX
    real(r8) :: TFNH4X
    real(r8) :: TFNO3X
    real(r8) :: TFNO2X
    real(r8) :: TFN2OX
    real(r8) :: TFP14X
    real(r8) :: TFPO4X
!fluxes
    real(r8) :: TRH2G
    real(r8) :: TRINH
    real(r8) :: TRIPO
    real(r8) :: TRINO
    real(r8) :: TRIP1
    real(r8) :: TRINB
    real(r8) :: TRIOB
    real(r8) :: TRIPB
    real(r8) :: TRIB1
    real(r8) :: TRGOM
    real(r8) :: TRGOC
    real(r8) :: TRGOD
    real(r8) :: TRGOA
    real(r8) :: TRGOH
    real(r8) :: TUPOX
    real(r8) :: TRDN3
    real(r8) :: TRDNB
    real(r8) :: TRDN2
    real(r8) :: TRD2B
    real(r8) :: TRDNO
    real(r8) :: TRN2F
  contains
    procedure, public :: ZeroOut => nit_aqmf_diag
  end type NitroAQMFluxDiagType

  type, public :: NitroMicStateType
  real(r8),allocatable :: CNOMA(:,:)
  real(r8),allocatable :: CPOMA(:,:)
  real(r8),allocatable :: OMA(:,:)

  real(r8),allocatable :: OMC2(:,:)
  real(r8),allocatable :: TFNG(:,:)
  real(r8),allocatable :: TFNR(:,:)
  real(r8),allocatable :: OMN2(:,:)
  real(r8),allocatable :: FOM2(:,:)
  real(r8),allocatable :: WFN(:,:)

  real(r8),allocatable :: FCN(:,:)
  real(r8),allocatable :: FCP(:,:)
  real(r8),allocatable :: FCNP(:,:)
  real(r8),allocatable :: FOMA(:,:)
  real(r8),allocatable :: FOMN(:,:)
  real(r8),allocatable :: FOMK(:,:)

  real(r8),allocatable :: CNOMAff(:)
  real(r8),allocatable :: CPOMAff(:)
  real(r8),allocatable :: OMAff(:)
  real(r8),allocatable :: FOMAff(:)
  real(r8),allocatable :: FOMNff(:)
  real(r8),allocatable :: FOMKff(:)
  real(r8),allocatable :: OMC2ff(:)
  real(r8),allocatable :: TFNGff(:)
  real(r8),allocatable :: TFNRff(:)
  real(r8),allocatable :: OMN2ff(:)
  real(r8),allocatable :: FOM2ff(:)
  real(r8),allocatable :: WFNff(:)
  real(r8),allocatable :: FCNff(:)
  real(r8),allocatable :: FCPff(:)
  real(r8),allocatable :: FCNPff(:)
  contains
   procedure, public :: Init => nit_mics_init
   procedure, public :: Destroy => nit_mics_destroy
  end type NitroMicStateType

  type, public :: NitroMicFluxType
! flux ratios
  real(r8),allocatable :: FNH4XR(:,:)
  real(r8),allocatable :: FNO3XR(:,:)
  real(r8),allocatable :: FPO4XR(:,:)
  real(r8),allocatable :: FP14XR(:,:)
! fluxes
  real(r8),allocatable :: CGOMC(:,:)
  real(r8),allocatable :: CGOMN(:,:)
  real(r8),allocatable :: CGOMP(:,:)
  real(r8),allocatable :: CGOQC(:,:)
  real(r8),allocatable :: CGOAC(:,:)
  real(r8),allocatable :: CGOMS(:,:,:)
  real(r8),allocatable :: CGONS(:,:,:)
  real(r8),allocatable :: CGOPS(:,:,:)
  real(r8),allocatable :: RUPOX(:,:)
  real(r8),allocatable :: RGN2F(:,:)
  real(r8),allocatable :: RGOMO(:,:)
  real(r8),allocatable :: ROXYM(:,:)
  real(r8),allocatable :: ROXYP(:,:)
  real(r8),allocatable :: ROXYO(:,:)
  real(r8),allocatable :: RDNO3(:,:)
  real(r8),allocatable :: RDNOB(:,:)
  real(r8),allocatable :: RDNO2(:,:)
  real(r8),allocatable :: RDN2B(:,:)
  real(r8),allocatable :: RDN2O(:,:)
  real(r8),allocatable :: RGOMD(:,:)
  real(r8),allocatable :: RMOMC(:,:,:)
  real(r8),allocatable :: RINH4(:,:)
  real(r8),allocatable :: RINO3(:,:)
  real(r8),allocatable :: RIPO4(:,:)
  real(r8),allocatable :: RINB4(:,:)
  real(r8),allocatable :: RINB3(:,:)
  real(r8),allocatable :: RIPOB(:,:)
  real(r8),allocatable :: RDOMC(:,:,:)
  real(r8),allocatable :: RDOMN(:,:,:)
  real(r8),allocatable :: RDOMP(:,:,:)
  real(r8),allocatable :: RHOMC(:,:,:)
  real(r8),allocatable :: RHOMN(:,:,:)
  real(r8),allocatable :: RHOMP(:,:,:)
  real(r8),allocatable :: RCOMC(:,:,:)
  real(r8),allocatable :: RCOMN(:,:,:)
  real(r8),allocatable :: RCOMP(:,:,:)
  real(r8),allocatable :: RH2GX(:,:)
  real(r8),allocatable :: RDMMC(:,:,:)
  real(r8),allocatable :: RHMMC(:,:,:)
  real(r8),allocatable :: RCMMC(:,:,:)
  real(r8),allocatable :: RDMMN(:,:,:)
  real(r8),allocatable :: RHMMN(:,:,:)
  real(r8),allocatable :: RCMMN(:,:,:)
  real(r8),allocatable :: RDMMP(:,:,:)
  real(r8),allocatable :: RHMMP(:,:,:)
  real(r8),allocatable :: RCMMP(:,:,:)
  real(r8),allocatable :: RCCMC(:,:,:)
  real(r8),allocatable :: RCCMN(:,:,:)
  real(r8),allocatable :: RCCMP(:,:,:)
  real(r8),allocatable :: RN2FX(:,:)
  real(r8),allocatable :: RXOMC(:,:,:)
  real(r8),allocatable :: RXOMN(:,:,:)
  real(r8),allocatable :: RXOMP(:,:,:)
  real(r8),allocatable :: R3OMC(:,:,:)
  real(r8),allocatable :: R3OMN(:,:,:)
  real(r8),allocatable :: R3OMP(:,:,:)
  real(r8),allocatable :: RXMMC(:,:,:)
  real(r8),allocatable :: RXMMN(:,:,:)
  real(r8),allocatable :: RXMMP(:,:,:)
  real(r8),allocatable :: R3MMC(:,:,:)
  real(r8),allocatable :: R3MMN(:,:,:)
  real(r8),allocatable :: R3MMP(:,:,:)
  real(r8),allocatable :: RINH4R(:,:)
  real(r8),allocatable :: RINO3R(:,:)
  real(r8),allocatable :: RIPO4R(:,:)
  real(r8),allocatable :: RGOMY(:,:)
  real(r8),allocatable :: ROQCD(:,:)
  real(r8),allocatable :: RCO2X(:,:)
  real(r8),allocatable :: RCH3X(:,:)
  real(r8),allocatable :: RCH4X(:,:)
  real(r8),allocatable :: RVOXA(:)
  real(r8),allocatable :: RVOXB(:)
  real(r8) :: RVOXAAO
  real(r8) :: RVOXBAO
  real(r8),allocatable :: XOMCZ(:,:,:)
  real(r8),allocatable :: XOMNZ(:,:,:)
  real(r8),allocatable :: XOMPZ(:,:,:)
  real(r8),allocatable :: RIP14(:,:)
  real(r8),allocatable :: RIP1B(:,:)
  real(r8),allocatable :: RIP14R(:,:)

  real(r8),allocatable :: RUPOXff(:)
  real(r8),allocatable :: RGN2Fff(:)
  real(r8),allocatable :: RGOMOff(:)
  real(r8),allocatable :: ROXYMff(:)
  real(r8),allocatable :: ROXYPff(:)
  real(r8),allocatable :: ROXYOff(:)
  real(r8),allocatable :: RDNO3ff(:)
  real(r8),allocatable :: RDNOBff(:)
  real(r8),allocatable :: RDNO2ff(:)
  real(r8),allocatable :: RDN2Bff(:)
  real(r8),allocatable :: RDN2Off(:)
  real(r8),allocatable :: RGOMDff(:)
  real(r8),allocatable :: RMOMCff(:,:)
  real(r8),allocatable :: RINH4ff(:)
  real(r8),allocatable :: RINO3ff(:)
  real(r8),allocatable :: RIPO4ff(:)
  real(r8),allocatable :: RINB4ff(:)
  real(r8),allocatable :: RINB3ff(:)
  real(r8),allocatable :: RIPOBff(:)
  real(r8),allocatable :: RDOMCff(:,:)
  real(r8),allocatable :: RDOMNff(:,:)
  real(r8),allocatable :: RDOMPff(:,:)
  real(r8),allocatable :: RHOMCff(:,:)
  real(r8),allocatable :: RHOMNff(:,:)
  real(r8),allocatable :: RHOMPff(:,:)
  real(r8),allocatable :: RCOMCff(:,:)
  real(r8),allocatable :: RCOMNff(:,:)
  real(r8),allocatable :: RCOMPff(:,:)
  real(r8),allocatable :: CGOMCff(:)
  real(r8),allocatable :: CGOMNff(:)
  real(r8),allocatable :: RH2GXff(:)
  real(r8),allocatable :: CGOMPff(:)
  real(r8),allocatable :: RDMMCff(:,:)
  real(r8),allocatable :: RHMMCff(:,:)
  real(r8),allocatable :: RCMMCff(:,:)
  real(r8),allocatable :: RDMMNff(:,:)
  real(r8),allocatable :: RHMMNff(:,:)
  real(r8),allocatable :: RCMMNff(:,:)
  real(r8),allocatable :: RDMMPff(:,:)
  real(r8),allocatable :: RHMMPff(:,:)
  real(r8),allocatable :: RCMMPff(:,:)
  real(r8),allocatable :: RN2FXff(:)
  real(r8),allocatable :: RXOMCff(:,:)
  real(r8),allocatable :: RXOMNff(:,:)
  real(r8),allocatable :: RXOMPff(:,:)
  real(r8),allocatable :: R3OMCff(:,:)
  real(r8),allocatable :: R3OMNff(:,:)
  real(r8),allocatable :: R3OMPff(:,:)
  real(r8),allocatable :: RXMMCff(:,:)
  real(r8),allocatable :: RXMMNff(:,:)
  real(r8),allocatable :: RXMMPff(:,:)
  real(r8),allocatable :: R3MMCff(:,:)
  real(r8),allocatable :: R3MMNff(:,:)
  real(r8),allocatable :: R3MMPff(:,:)
  real(r8),allocatable :: CGOQCff(:)
  real(r8),allocatable :: CGOACff(:)
  real(r8),allocatable :: RINH4Rff(:)
  real(r8),allocatable :: RINO3Rff(:)
  real(r8),allocatable :: RIPO4Rff(:)
  real(r8),allocatable :: FNH4XRff(:)
  real(r8),allocatable :: FNO3XRff(:)
  real(r8),allocatable :: FPO4XRff(:)
  real(r8),allocatable :: RGOMYff(:)
  real(r8),allocatable :: CGOMSff(:,:)
  real(r8),allocatable :: CGONSff(:,:)
  real(r8),allocatable :: CGOPSff(:,:)
  real(r8),allocatable :: FP14XRff(:)
  real(r8),allocatable :: RCO2Xff(:)
  real(r8),allocatable :: RCH3Xff(:)
  real(r8),allocatable :: RCH4Xff(:)
  real(r8),allocatable :: RIP14ff(:)
  real(r8),allocatable :: RIP1Bff(:)
  real(r8),allocatable :: RIP14Rff(:)
  contains
    procedure, public :: Init => nit_micf_init
    procedure, public :: ZeroOut => nit_micf_zero
    procedure, public :: destroy => nit_micf_destroy
  end type NitroMicFluxType

  type, public :: NitroOMcplxFluxType
    real(r8),allocatable :: RDOSC(:,:)
    real(r8),allocatable :: RDOSN(:,:)
    real(r8),allocatable :: RDOSP(:,:)
    real(r8),allocatable :: RHOSC(:,:)
    real(r8),allocatable :: RHOSN(:,:)
    real(r8),allocatable :: RHOSP(:,:)
    real(r8),allocatable :: RCOSC(:,:)
    real(r8),allocatable :: RCOSN(:,:)
    real(r8),allocatable :: RCOSP(:,:)
    real(r8),allocatable :: RDORC(:,:)
    real(r8),allocatable :: RDORN(:,:)
    real(r8),allocatable :: RDORP(:,:)
    real(r8),allocatable :: RDOHC(:)
    real(r8),allocatable :: RDOHN(:)
    real(r8),allocatable :: RDOHP(:)
    real(r8),allocatable :: RDOHA(:)
    real(r8),allocatable :: CSORP(:)
    real(r8),allocatable :: ZSORP(:)
    real(r8),allocatable :: PSORP(:)
    real(r8),allocatable :: CSORPA(:)
    real(r8),allocatable :: TCGOQC(:)
    real(r8),allocatable :: TCGOAC(:)
    real(r8),allocatable :: TCGOMN(:)
    real(r8),allocatable :: TCGOMP(:)
    real(r8),allocatable :: ROQCK(:)
    real(r8),allocatable :: XOQCK(:)
    real(r8),allocatable :: XOQCZ(:)
    real(r8),allocatable :: XOQNZ(:)
    real(r8),allocatable :: XOQPZ(:)
    real(r8),allocatable :: XOQAZ(:)
  contains
    procedure, public :: Init => nit_omcplxf_init
    procedure, public :: ZeroOut => nit_omcplxf_zero
    procedure, public :: Destroy => nit_omcplxf_destroy
  end type NitroOMcplxFluxType

  type, public :: NitroOMcplxStateType
    real(r8),allocatable :: OSRH(:)
    real(r8),allocatable :: TOMK(:)
    real(r8),allocatable :: TONK(:)
    real(r8),allocatable :: TOPK(:)
    real(r8),allocatable :: FOCA(:)
    real(r8),allocatable :: FOAA(:)
    real(r8),allocatable :: CNQ(:)
    real(r8),allocatable :: CPQ(:)
    real(r8),allocatable :: CNH(:)
    real(r8),allocatable :: CPH(:)
    real(r8),allocatable :: ORCT(:)
    real(r8),allocatable :: OSCT(:)
    real(r8),allocatable :: OSAT(:)
    real(r8),allocatable :: TONX(:)
    real(r8),allocatable :: TOPX(:)
    real(r8),allocatable :: COQC(:)
    real(r8),allocatable :: COQA(:)
  contains
    procedure, public :: Init => nit_omcplxs_init
    procedure, public :: ZeroOut => nit_omcplxs_zero
    procedure, public :: Destroy => nit_omcplxs_destroy
  end type NitroOMcplxStateType

  type, public :: NitroMicDiagType
  real(r8) :: H1P4T
  real(r8) :: H2P4T
  real(r8) :: RH2GZ
  real(r8) :: RCNO2
  real(r8) :: RCNOB
  real(r8) :: RCN2O
  real(r8) :: RCN2B
  real(r8) :: RCNO3
  real(r8) :: RCN3B
  real(r8) :: RCOQN
  real(r8) :: THETR
  real(r8) :: THETZ
  real(r8) :: TORC
  real(r8) :: TOMA
  real(r8) :: TOMN
  real(r8) :: TFNX
  real(r8) :: TFNY
  real(r8) :: VOLWZ
  real(r8) :: WFNG
  real(r8) :: XCO2
  real(r8) :: ZNH4T
  real(r8) :: ZNO3T
  real(r8) :: ZNO2T

  end type NitroMicDiagType

  contains
!------------------------------------------------------------------------------------------

  subroutine nit_aqmf_diag(this)
  implicit none
  class(NitroAQMFluxDiagType) :: this

  this%TFNH4B = 0._r8
  this%TFNO3B = 0._r8
  this%TFNO2B = 0._r8
  this%TFP14B = 0._r8
  this%TFPO4B = 0._r8
  this%TCH4H = 0._r8
  this%TCH4A = 0._r8
  this%TFOQC = 0._r8
  this%TFOQA = 0._r8
  this%TFOXYX = 0._r8
  this%TFNH4X = 0._r8
  this%TFNO3X = 0._r8
  this%TFNO2X = 0._r8
  this%TFN2OX = 0._r8
  this%TFP14X = 0._r8
  this%TFPO4X = 0._r8

  this%TRH2G = 0._r8
  this%TRINH = 0._r8
  this%TRIPO = 0._r8
  this%TRINO=0.0_r8
  this%TRIPO=0.0_r8
  this%TRIP1=0.0_r8
  this%TRINB=0.0_r8
  this%TRIOB=0.0_r8
  this%TRIPB=0.0_r8
  this%TRIB1=0.0_r8
  this%TRGOM=0.0_r8
  this%TRGOC=0.0_r8
  this%TRGOD=0.0_r8
  this%TRGOA=0.0_r8
  this%TRGOH=0.0_r8
  this%TUPOX=0.0_r8
  this%TRDN3=0.0_r8
  this%TRDNB=0.0_r8
  this%TRDN2=0.0_r8
  this%TRD2B=0.0_r8
  this%TRDNO=0.0_r8
  this%TRN2F=0.0_r8
  end subroutine nit_aqmf_diag
!------------------------------------------------------------------------------------------

  subroutine nit_micf_init(this,jcplx,NFGS)
  implicit none
  class(NitroMicFluxType) :: this
  integer, intent(in) :: jcplx,NFGS
  integer :: ndbiomcp
  integer :: NMICBSA
  integer :: NMICBSO
  ndbiomcp=micpar%ndbiomcp
  NMICBSA=micpar%NMICBSA
  NMICBSO=micpar%NMICBSO
  allocate(this%RUPOX(NMICBSO,1:jcplx))
  allocate(this%RGN2F(NMICBSO,1:jcplx))
  allocate(this%RGOMO(NMICBSO,1:jcplx))
  allocate(this%ROXYM(NMICBSO,1:jcplx))
  allocate(this%ROXYP(NMICBSO,1:jcplx))
  allocate(this%ROXYO(NMICBSO,1:jcplx))
  allocate(this%RDNO3(NMICBSO,1:jcplx))
  allocate(this%RDNOB(NMICBSO,1:jcplx))
  allocate(this%RDNO2(NMICBSO,1:jcplx))
  allocate(this%RDN2B(NMICBSO,1:jcplx))
  allocate(this%RDN2O(NMICBSO,1:jcplx))
  allocate(this%RGOMD(NMICBSO,1:jcplx))
  allocate(this%RMOMC(2,NMICBSO,1:jcplx))
  allocate(this%RINH4(NMICBSO,1:jcplx))
  allocate(this%RINO3(NMICBSO,1:jcplx))
  allocate(this%RIPO4(NMICBSO,1:jcplx))
  allocate(this%RINB4(NMICBSO,1:jcplx))
  allocate(this%RINB3(NMICBSO,1:jcplx))
  allocate(this%RIPOB(NMICBSO,1:jcplx))
  allocate(this%RDOMC(2,NMICBSO,1:jcplx))
  allocate(this%RDOMN(2,NMICBSO,1:jcplx))
  allocate(this%RDOMP(2,NMICBSO,1:jcplx))
  allocate(this%RHOMC(2,NMICBSO,1:jcplx))
  allocate(this%RHOMN(2,NMICBSO,1:jcplx))
  allocate(this%RHOMP(2,NMICBSO,1:jcplx))
  allocate(this%RCOMC(2,NMICBSO,1:jcplx))
  allocate(this%RCOMN(2,NMICBSO,1:jcplx))
  allocate(this%RCOMP(2,NMICBSO,1:jcplx))
  allocate(this%CGOMC(NMICBSO,1:jcplx))
  allocate(this%CGOMN(NMICBSO,1:jcplx))
  allocate(this%RH2GX(NMICBSO,1:jcplx))
  allocate(this%CGOMP(NMICBSO,1:jcplx))
  allocate(this%RDMMC(2,NMICBSO,1:jcplx))
  allocate(this%RHMMC(2,NMICBSO,1:jcplx))
  allocate(this%RCMMC(2,NMICBSO,1:jcplx))
  allocate(this%RDMMN(2,NMICBSO,1:jcplx))
  allocate(this%RHMMN(2,NMICBSO,1:jcplx))
  allocate(this%RCMMN(2,NMICBSO,1:jcplx))
  allocate(this%RDMMP(2,NMICBSO,1:jcplx))
  allocate(this%RHMMP(2,NMICBSO,1:jcplx))
  allocate(this%RCMMP(2,NMICBSO,1:jcplx))
  allocate(this%RN2FX(NMICBSO,1:jcplx))
  allocate(this%RXOMC(2,NMICBSO,1:jcplx))
  allocate(this%RXOMN(2,NMICBSO,1:jcplx))
  allocate(this%RXOMP(2,NMICBSO,1:jcplx))
  allocate(this%R3OMC(2,NMICBSO,1:jcplx))
  allocate(this%R3OMN(2,NMICBSO,1:jcplx))
  allocate(this%R3OMP(2,NMICBSO,1:jcplx))
  allocate(this%RXMMC(2,NMICBSO,1:jcplx))
  allocate(this%RXMMN(2,NMICBSO,1:jcplx))
  allocate(this%RXMMP(2,NMICBSO,1:jcplx))
  allocate(this%R3MMC(2,NMICBSO,1:jcplx))
  allocate(this%R3MMN(2,NMICBSO,1:jcplx))
  allocate(this%R3MMP(2,NMICBSO,1:jcplx))
  allocate(this%CGOQC(NMICBSO,1:jcplx))
  allocate(this%CGOAC(NMICBSO,1:jcplx))
  allocate(this%RINH4R(NMICBSO,1:jcplx))
  allocate(this%RINO3R(NMICBSO,1:jcplx))
  allocate(this%RIPO4R(NMICBSO,1:jcplx))
  allocate(this%FNH4XR(NMICBSO,1:jcplx))
  allocate(this%FNO3XR(NMICBSO,1:jcplx))
  allocate(this%FPO4XR(NMICBSO,1:jcplx))
  allocate(this%RGOMY(NMICBSO,1:jcplx))
  allocate(this%CGOMS(2,NMICBSO,1:jcplx))
  allocate(this%CGONS(2,NMICBSO,1:jcplx))
  allocate(this%CGOPS(2,NMICBSO,1:jcplx))
  allocate(this%FP14XR(NMICBSO,1:jcplx))
  allocate(this%RCO2X(NMICBSO,1:jcplx))
  allocate(this%RCH3X(NMICBSO,1:jcplx))
  allocate(this%RCH4X(NMICBSO,1:jcplx))
  allocate(this%RIP14(NMICBSO,1:jcplx))
  allocate(this%RIP1B(NMICBSO,1:jcplx))
  allocate(this%RIP14R(NMICBSO,1:jcplx))

  allocate(this%RVOXA(NMICBSA))
  allocate(this%RVOXB(NMICBSA))
  allocate(this%XOMCZ(3,NMICBSO,1:jcplx))
  allocate(this%XOMNZ(3,NMICBSO,1:jcplx))
  allocate(this%XOMPZ(3,NMICBSO,1:jcplx))
  allocate(this%ROQCD(NMICBSO,1:jcplx))
  allocate(this%RCCMC(ndbiomcp,NMICBSO,1:jcplx))
  allocate(this%RCCMN(ndbiomcp,NMICBSO,1:jcplx))
  allocate(this%RCCMP(ndbiomcp,NMICBSO,1:jcplx))

  allocate(this%RUPOXff(NMICBSA))
  allocate(this%RGN2Fff(NMICBSA))
  allocate(this%RGOMOff(NMICBSA))
  allocate(this%ROXYMff(NMICBSA))
  allocate(this%ROXYPff(NMICBSA))
  allocate(this%ROXYOff(NMICBSA))
  allocate(this%RDNO3ff(NMICBSA))
  allocate(this%RDNOBff(NMICBSA))
  allocate(this%RDNO2ff(NMICBSA))
  allocate(this%RDN2Bff(NMICBSA))
  allocate(this%RDN2Off(NMICBSA))
  allocate(this%RGOMDff(NMICBSA))
  allocate(this%RMOMCff(2,NMICBSA))
  allocate(this%RINH4ff(NMICBSA))
  allocate(this%RINO3ff(NMICBSA))
  allocate(this%RIPO4ff(NMICBSA))
  allocate(this%RINB4ff(NMICBSA))
  allocate(this%RINB3ff(NMICBSA))
  allocate(this%RIPOBff(NMICBSA))
  allocate(this%RDOMCff(2,NMICBSA))
  allocate(this%RDOMNff(2,NMICBSA))
  allocate(this%RDOMPff(2,NMICBSA))
  allocate(this%RHOMCff(2,NMICBSA))
  allocate(this%RHOMNff(2,NMICBSA))
  allocate(this%RHOMPff(2,NMICBSA))
  allocate(this%RCOMCff(2,NMICBSA))
  allocate(this%RCOMNff(2,NMICBSA))
  allocate(this%RCOMPff(2,NMICBSA))
  allocate(this%CGOMCff(NMICBSA))
  allocate(this%CGOMNff(NMICBSA))
  allocate(this%RH2GXff(NMICBSA))
  allocate(this%CGOMPff(NMICBSA))
  allocate(this%RDMMCff(2,NMICBSA))
  allocate(this%RHMMCff(2,NMICBSA))
  allocate(this%RCMMCff(2,NMICBSA))
  allocate(this%RDMMNff(2,NMICBSA))
  allocate(this%RHMMNff(2,NMICBSA))
  allocate(this%RCMMNff(2,NMICBSA))
  allocate(this%RDMMPff(2,NMICBSA))
  allocate(this%RHMMPff(2,NMICBSA))
  allocate(this%RCMMPff(2,NMICBSA))
  allocate(this%RN2FXff(NMICBSA))
  allocate(this%RXOMCff(2,NMICBSA))
  allocate(this%RXOMNff(2,NMICBSA))
  allocate(this%RXOMPff(2,NMICBSA))
  allocate(this%R3OMCff(2,NMICBSA))
  allocate(this%R3OMNff(2,NMICBSA))
  allocate(this%R3OMPff(2,NMICBSA))
  allocate(this%RXMMCff(2,NMICBSA))
  allocate(this%RXMMNff(2,NMICBSA))
  allocate(this%RXMMPff(2,NMICBSA))
  allocate(this%R3MMCff(2,NMICBSA))
  allocate(this%R3MMNff(2,NMICBSA))
  allocate(this%R3MMPff(2,NMICBSA))
  allocate(this%CGOQCff(NMICBSA))
  allocate(this%CGOACff(NMICBSA))
  allocate(this%RINH4Rff(NMICBSA))
  allocate(this%RINO3Rff(NMICBSA))
  allocate(this%RIPO4Rff(NMICBSA))
  allocate(this%FNH4XRff(NMICBSA))
  allocate(this%FNO3XRff(NMICBSA))
  allocate(this%FPO4XRff(NMICBSA))
  allocate(this%RGOMYff(NMICBSA))
  allocate(this%CGOMSff(2,NMICBSA))
  allocate(this%CGONSff(2,NMICBSA))
  allocate(this%CGOPSff(2,NMICBSA))
  allocate(this%FP14XRff(NMICBSA))
  allocate(this%RCO2Xff(NMICBSA))
  allocate(this%RCH3Xff(NMICBSA))
  allocate(this%RCH4Xff(NMICBSA))
  allocate(this%RIP14ff(NMICBSA))
  allocate(this%RIP1Bff(NMICBSA))
  allocate(this%RIP14Rff(NMICBSA))

  call this%ZeroOut()
  end subroutine nit_micf_init
!------------------------------------------------------------------------------------------

  subroutine nit_mics_init(this, jcplx,NFGS)

  implicit none
  class(NitroMicStateType) :: this
  integer, intent(in) :: jcplx,NFGS
  integer :: NMICBSA,NMICBSO
  NMICBSA=micpar%NMICBSA
  NMICBSO=micpar%NMICBSO

  allocate(this%CNOMA(NMICBSO,1:jcplx))
  allocate(this%CPOMA(NMICBSO,1:jcplx))
  allocate(this%OMA(NMICBSO,1:jcplx))
  allocate(this%FOMA(NMICBSO,1:jcplx))
  allocate(this%FOMN(NMICBSO,1:jcplx))
  allocate(this%FOMK(NMICBSO,1:jcplx))
  allocate(this%OMC2(NMICBSO,1:jcplx))
  allocate(this%TFNG(NMICBSO,1:jcplx))
  allocate(this%TFNR(NMICBSO,1:jcplx))
  allocate(this%OMN2(NMICBSO,1:jcplx))
  allocate(this%FOM2(NMICBSO,1:jcplx))
  allocate(this%WFN(NMICBSO,1:jcplx))
  allocate(this%FCN(NMICBSO,1:jcplx))
  allocate(this%FCP(NMICBSO,1:jcplx))
  allocate(this%FCNP(NMICBSO,1:jcplx))

  allocate(this%CNOMAff(NMICBSA))
  allocate(this%CPOMAff(NMICBSA))
  allocate(this%OMAff(NMICBSA))
  allocate(this%FOMAff(NMICBSA))
  allocate(this%FOMNff(NMICBSA))
  allocate(this%FOMKff(NMICBSA))
  allocate(this%OMC2ff(NMICBSA))
  allocate(this%TFNGff(NMICBSA))
  allocate(this%TFNRff(NMICBSA))
  allocate(this%OMN2ff(NMICBSA))
  allocate(this%FOM2ff(NMICBSA))
  allocate(this%WFNff(NMICBSA))
  allocate(this%FCNff(NMICBSA))
  allocate(this%FCPff(NMICBSA))
  allocate(this%FCNPff(NMICBSA))
  end subroutine nit_mics_init
!------------------------------------------------------------------------------------------

  subroutine nit_micf_zero(this)
  implicit none
  class(NitroMicFLuxType) :: this

  this%RUPOX = 0._r8
  this%RGN2F = 0._r8
  this%RGOMO = 0._r8
  this%ROXYM = 0._r8
  this%ROXYP = 0._r8
  this%ROXYO = 0._r8
  this%RDNO3 = 0._r8
  this%RDNOB = 0._r8
  this%RDNO2 = 0._r8
  this%RDN2B = 0._r8
  this%RDN2O = 0._r8
  this%RGOMD = 0._r8
  this%RMOMC = 0._r8
  this%RINH4 = 0._r8
  this%RINO3 = 0._r8
  this%RIPO4 = 0._r8
  this%RINB4 = 0._r8
  this%RINB3 = 0._r8
  this%RIPOB = 0._r8
  this%RDOMC = 0._r8
  this%RDOMN = 0._r8
  this%RDOMP = 0._r8
  this%RHOMC = 0._r8
  this%RHOMN = 0._r8
  this%RHOMP = 0._r8
  this%RCOMC = 0._r8
  this%RCOMN = 0._r8
  this%RCOMP = 0._r8
  this%CGOMC = 0._r8
  this%CGOMN = 0._r8
  this%RH2GX = 0._r8
  this%CGOMP = 0._r8
  this%RDMMC = 0._r8
  this%RHMMC = 0._r8
  this%RCMMC = 0._r8
  this%RDMMN = 0._r8
  this%RHMMN = 0._r8
  this%RCMMN = 0._r8
  this%RDMMP = 0._r8
  this%RHMMP = 0._r8
  this%RCMMP = 0._r8
  this%RCCMC = 0._r8
  this%RCCMN = 0._r8
  this%RCCMP = 0._r8
  this%RN2FX = 0._r8

  this%RXOMC = 0._r8
  this%RXOMN = 0._r8
  this%RXOMP = 0._r8
  this%R3OMC = 0._r8
  this%R3OMN = 0._r8
  this%R3OMP = 0._r8
  this%RXMMC = 0._r8
  this%RXMMN = 0._r8
  this%RXMMP = 0._r8
  this%R3MMC = 0._r8
  this%R3MMN = 0._r8
  this%R3MMP = 0._r8
  this%CGOQC = 0._r8
  this%CGOAC = 0._r8
  this%RINH4R = 0._r8
  this%RINO3R = 0._r8
  this%RIPO4R = 0._r8
  this%FNH4XR = 0._r8
  this%FNO3XR = 0._r8
  this%FPO4XR = 0._r8
  this%RGOMY = 0._r8
  this%ROQCD = 0._r8
  this%CGOMS = 0._r8
  this%CGONS = 0._r8
  this%CGOPS = 0._r8
  this%FP14XR = 0._r8
  this%RCO2X = 0._r8
  this%RCH3X = 0._r8
  this%RCH4X = 0._r8
  this%RVOXA = 0._r8
  this%RVOXB = 0._r8
  this%XOMCZ = 0._r8
  this%XOMNZ = 0._r8
  this%XOMPZ = 0._r8
  this%RIP14 = 0._r8
  this%RIP1B = 0._r8
  this%RIP14R = 0._r8

  this%RUPOXff = 0._r8
  this%RGN2Fff = 0._r8
  this%RGOMOff = 0._r8
  this%ROXYMff = 0._r8
  this%ROXYPff = 0._r8
  this%ROXYOff = 0._r8
  this%RDNO3ff = 0._r8
  this%RDNOBff = 0._r8
  this%RDNO2ff = 0._r8
  this%RDN2Bff = 0._r8
  this%RDN2Off = 0._r8
  this%RGOMDff = 0._r8
  this%RMOMCff = 0._r8
  this%RINH4ff = 0._r8
  this%RINO3ff = 0._r8
  this%RIPO4ff = 0._r8
  this%RINB4ff = 0._r8
  this%RINB3ff = 0._r8
  this%RIPOBff = 0._r8
  this%RDOMCff = 0._r8
  this%RDOMNff = 0._r8
  this%RDOMPff = 0._r8
  this%RHOMCff = 0._r8
  this%RHOMNff = 0._r8
  this%RHOMPff = 0._r8
  this%RCOMCff = 0._r8
  this%RCOMNff = 0._r8
  this%RCOMPff = 0._r8
  this%CGOMCff = 0._r8
  this%CGOMNff = 0._r8
  this%RH2GXff = 0._r8
  this%CGOMPff = 0._r8
  this%RDMMCff = 0._r8
  this%RHMMCff = 0._r8
  this%RCMMCff = 0._r8
  this%RDMMNff = 0._r8
  this%RHMMNff = 0._r8
  this%RCMMNff = 0._r8
  this%RDMMPff = 0._r8
  this%RHMMPff = 0._r8
  this%RCMMPff = 0._r8
  this%RN2FXff = 0._r8

  this%RXOMCff = 0._r8
  this%RXOMNff = 0._r8
  this%RXOMPff = 0._r8
  this%R3OMCff = 0._r8
  this%R3OMNff = 0._r8
  this%R3OMPff = 0._r8
  this%RXMMCff = 0._r8
  this%RXMMNff = 0._r8
  this%RXMMPff = 0._r8
  this%R3MMCff = 0._r8
  this%R3MMNff = 0._r8
  this%R3MMPff = 0._r8
  this%CGOQCff = 0._r8
  this%CGOACff = 0._r8
  this%RINH4Rff = 0._r8
  this%RINO3Rff = 0._r8
  this%RIPO4Rff = 0._r8
  this%FNH4XRff = 0._r8
  this%FNO3XRff = 0._r8
  this%FPO4XRff = 0._r8
  this%RGOMYff = 0._r8
  this%CGOMSff = 0._r8
  this%CGONSff = 0._r8
  this%CGOPSff = 0._r8
  this%FP14XRff = 0._r8
  this%RCO2Xff = 0._r8
  this%RCH3Xff = 0._r8
  this%RCH4Xff = 0._r8
  this%RIP14ff = 0._r8
  this%RIP1Bff = 0._r8
  this%RIP14Rff = 0._r8

  end subroutine nit_micf_zero


!------------------------------------------------------------------------------------------

  subroutine nit_micf_destroy(this)

  implicit none
  class(NitroMicFLuxType) :: this

  call destroy(this%RUPOX)
  call destroy(this%RGN2F)
  call destroy(this%RGOMO)
  call destroy(this%ROXYM)
  call destroy(this%ROXYP)
  call destroy(this%ROXYO)
  call destroy(this%RDNO3)
  call destroy(this%RDNOB)
  call destroy(this%RDNO2)
  call destroy(this%RDN2B)
  call destroy(this%RDN2O)
  call destroy(this%RGOMD)
  call destroy(this%RMOMC)
  call destroy(this%RINH4)
  call destroy(this%RINO3)
  call destroy(this%RIPO4)
  call destroy(this%RINB4)
  call destroy(this%RINB3)
  call destroy(this%RIPOB)
  call destroy(this%RDOMC)
  call destroy(this%RDOMN)
  call destroy(this%RDOMP)
  call destroy(this%RHOMC)
  call destroy(this%RHOMN)
  call destroy(this%RHOMP)
  call destroy(this%RCOMC)
  call destroy(this%RCOMN)
  call destroy(this%RCOMP)
  call destroy(this%CGOMC)
  call destroy(this%CGOMN)
  call destroy(this%RH2GX)
  call destroy(this%CGOMP)
  call destroy(this%RDMMC)
  call destroy(this%RHMMC)
  call destroy(this%RCMMC)
  call destroy(this%RDMMN)
  call destroy(this%RHMMN)
  call destroy(this%RCMMN)
  call destroy(this%RDMMP)
  call destroy(this%RHMMP)
  call destroy(this%RCMMP)
  call destroy(this%RCCMC)
  call destroy(this%RCCMN)
  call destroy(this%RCCMP)
  call destroy(this%RN2FX)
  call destroy(this%RXOMC)
  call destroy(this%RXOMN)
  call destroy(this%RXOMP)
  call destroy(this%R3OMC)
  call destroy(this%R3OMN)
  call destroy(this%R3OMP)
  call destroy(this%RXMMC)
  call destroy(this%RXMMN)
  call destroy(this%RXMMP)
  call destroy(this%R3MMC)
  call destroy(this%R3MMN)
  call destroy(this%R3MMP)
  call destroy(this%CGOQC)
  call destroy(this%CGOAC)
  call destroy(this%RINH4R)
  call destroy(this%RINO3R)
  call destroy(this%RIPO4R)
  call destroy(this%FNH4XR)
  call destroy(this%FNO3XR)
  call destroy(this%FPO4XR)
  call destroy(this%RGOMY)
  call destroy(this%ROQCD)
  call destroy(this%CGOMS)
  call destroy(this%CGONS)
  call destroy(this%CGOPS)
  call destroy(this%FP14XR)
  call destroy(this%RCO2X)
  call destroy(this%RCH3X)
  call destroy(this%RCH4X)
  call destroy(this%RVOXA)
  call destroy(this%RVOXB)
  call destroy(this%XOMCZ)
  call destroy(this%XOMNZ)
  call destroy(this%XOMPZ)
  call destroy(this%RIP14)
  call destroy(this%RIP1B)
  call destroy(this%RIP14R)

  call destroy(this%RUPOXff)
  call destroy(this%RGN2Fff)
  call destroy(this%RGOMOff)
  call destroy(this%ROXYMff)
  call destroy(this%ROXYPff)
  call destroy(this%ROXYOff)
  call destroy(this%RDNO3ff)
  call destroy(this%RDNOBff)
  call destroy(this%RDNO2ff)
  call destroy(this%RDN2Bff)
  call destroy(this%RDN2Off)
  call destroy(this%RGOMDff)
  call destroy(this%RMOMCff)
  call destroy(this%RINH4ff)
  call destroy(this%RINO3ff)
  call destroy(this%RIPO4ff)
  call destroy(this%RINB4ff)
  call destroy(this%RINB3ff)
  call destroy(this%RIPOBff)
  call destroy(this%RDOMCff)
  call destroy(this%RDOMNff)
  call destroy(this%RDOMPff)
  call destroy(this%RHOMCff)
  call destroy(this%RHOMNff)
  call destroy(this%RHOMPff)
  call destroy(this%RCOMCff)
  call destroy(this%RCOMNff)
  call destroy(this%RCOMPff)
  call destroy(this%CGOMCff)
  call destroy(this%CGOMNff)
  call destroy(this%RH2GXff)
  call destroy(this%CGOMPff)
  call destroy(this%RDMMCff)
  call destroy(this%RHMMCff)
  call destroy(this%RCMMCff)
  call destroy(this%RDMMNff)
  call destroy(this%RHMMNff)
  call destroy(this%RCMMNff)
  call destroy(this%RDMMPff)
  call destroy(this%RHMMPff)
  call destroy(this%RCMMPff)
  call destroy(this%RN2FXff)
  call destroy(this%RXOMCff)
  call destroy(this%RXOMNff)
  call destroy(this%RXOMPff)
  call destroy(this%R3OMCff)
  call destroy(this%R3OMNff)
  call destroy(this%R3OMPff)
  call destroy(this%RXMMCff)
  call destroy(this%RXMMNff)
  call destroy(this%RXMMPff)
  call destroy(this%R3MMCff)
  call destroy(this%R3MMNff)
  call destroy(this%R3MMPff)
  call destroy(this%CGOQCff)
  call destroy(this%CGOACff)
  call destroy(this%RINH4Rff)
  call destroy(this%RINO3Rff)
  call destroy(this%RIPO4Rff)
  call destroy(this%FNH4XRff)
  call destroy(this%FNO3XRff)
  call destroy(this%FPO4XRff)
  call destroy(this%RGOMYff)
  call destroy(this%CGOMSff)
  call destroy(this%CGONSff)
  call destroy(this%CGOPSff)
  call destroy(this%FP14XRff)
  call destroy(this%RCO2Xff)
  call destroy(this%RCH3Xff)
  call destroy(this%RCH4Xff)
  call destroy(this%RIP14ff)
  call destroy(this%RIP1Bff)
  call destroy(this%RIP14Rff)

  end subroutine nit_micf_destroy
!------------------------------------------------------------------------------------------

  subroutine nit_mics_destroy(this)
  implicit none
  class(NitroMicStateType) :: this

  call destroy(this%CNOMA)
  call destroy(this%CPOMA)
  call destroy(this%OMA)
  call destroy(this%FOMA)
  call destroy(this%FOMN)
  call destroy(this%FOMK)
  call destroy(this%OMC2)
  call destroy(this%TFNG)
  call destroy(this%TFNR)
  call destroy(this%OMN2)
  call destroy(this%FOM2)
  call destroy(this%WFN)
  call destroy(this%FCN)
  call destroy(this%FCP)
  call destroy(this%FCNP)

  call destroy(this%CNOMAff)
  call destroy(this%CPOMAff)
  call destroy(this%OMAff)
  call destroy(this%FOMAff)
  call destroy(this%FOMNff)
  call destroy(this%FOMKff)
  call destroy(this%OMC2ff)
  call destroy(this%TFNGff)
  call destroy(this%TFNRff)
  call destroy(this%OMN2ff)
  call destroy(this%FOM2ff)
  call destroy(this%WFNff)
  call destroy(this%FCNff)
  call destroy(this%FCPff)
  call destroy(this%FCNPff)
  end subroutine nit_mics_destroy
!------------------------------------------------------------------------------------------
  subroutine nit_omcplxf_init(this)
  implicit none
  class(NitroOMcplxFluxType) :: this
  integer :: nkinets
  integer :: ncplx
  integer :: ndbiomcp

  nkinets=micpar%jsken
  ncplx=micpar%jcplx
  ndbiomcp=micpar%ndbiomcp
  allocate(this%RDOSC(nkinets,1:ncplx))
  allocate(this%RDOSN(nkinets,1:ncplx))
  allocate(this%RDOSP(nkinets,1:ncplx))
  allocate(this%RHOSC(nkinets,1:ncplx))
  allocate(this%RHOSN(nkinets,1:ncplx))
  allocate(this%RHOSP(nkinets,1:ncplx))
  allocate(this%RCOSC(nkinets,1:ncplx))
  allocate(this%RCOSN(nkinets,1:ncplx))
  allocate(this%RCOSP(nkinets,1:ncplx))
  allocate(this%RDORC(ndbiomcp,1:ncplx))
  allocate(this%RDORN(ndbiomcp,1:ncplx))
  allocate(this%RDORP(ndbiomcp,1:ncplx))
  allocate(this%RDOHC(1:ncplx))
  allocate(this%RDOHN(1:ncplx))
  allocate(this%RDOHP(1:ncplx))
  allocate(this%RDOHA(1:ncplx))
  allocate(this%CSORP(1:ncplx))
  allocate(this%ZSORP(1:ncplx))
  allocate(this%PSORP(1:ncplx))
  allocate(this%CSORPA(1:ncplx))
  allocate(this%TCGOQC(1:ncplx+1))
  allocate(this%TCGOAC(1:ncplx+1))
  allocate(this%TCGOMN(1:ncplx+1))
  allocate(this%TCGOMP(1:ncplx+1))
  allocate(this%ROQCK(1:ncplx))
  allocate(this%XOQCK(1:ncplx))
  allocate(this%XOQCZ(1:ncplx))
  allocate(this%XOQNZ(1:ncplx))
  allocate(this%XOQPZ(1:ncplx))
  allocate(this%XOQAZ(1:ncplx))

  call this%ZeroOut()
  end subroutine nit_omcplxf_init
!------------------------------------------------------------------------------------------

  subroutine nit_omcplxf_destroy(this)
  implicit none
  class(NitroOMcplxFluxType) :: this

  call destroy(this%RDOSC)
  call destroy(this%RDOSN)
  call destroy(this%RDOSP)
  call destroy(this%RHOSC)
  call destroy(this%RHOSN)
  call destroy(this%RHOSP)
  call destroy(this%RCOSC)
  call destroy(this%RCOSN)
  call destroy(this%RCOSP)
  call destroy(this%RDORC)
  call destroy(this%RDORN)
  call destroy(this%RDORP)
  call destroy(this%RDOHC)
  call destroy(this%RDOHN)
  call destroy(this%RDOHP)
  call destroy(this%RDOHA)
  call destroy(this%CSORP)
  call destroy(this%ZSORP)
  call destroy(this%PSORP)
  call destroy(this%CSORPA)
  call destroy(this%TCGOQC)
  call destroy(this%TCGOAC)
  call destroy(this%TCGOMN)
  call destroy(this%TCGOMP)
  call destroy(this%ROQCK)
  call destroy(this%XOQCK)
  call destroy(this%XOQCZ)
  call destroy(this%XOQNZ)
  call destroy(this%XOQPZ)
  call destroy(this%XOQAZ)

  end subroutine nit_omcplxf_destroy
!------------------------------------------------------------------------------------------

  subroutine nit_omcplxf_zero(this)
  implicit none
  class(NitroOMcplxFluxType) :: this

  this%RDOSC=0._r8
  this%RDOSN=0._r8
  this%RDOSP=0._r8
  this%RHOSC=0._r8
  this%RHOSN=0._r8
  this%RHOSP=0._r8
  this%RCOSC=0._r8
  this%RCOSN=0._r8
  this%RCOSP=0._r8
  this%RDORC=0._r8
  this%RDORN=0._r8
  this%RDORP=0._r8
  this%RDOHC=0._r8
  this%RDOHN=0._r8
  this%RDOHP=0._r8
  this%RDOHA=0._r8
  this%CSORP=0._r8
  this%ZSORP=0._r8
  this%PSORP=0._r8
  this%CSORPA=0._r8
  this%TCGOQC=0._r8
  this%TCGOAC=0._r8
  this%TCGOMN=0._r8
  this%TCGOMP=0._r8
  this%ROQCK=0._r8
  this%XOQCK=0._r8
  this%XOQCZ=0._r8
  this%XOQNZ=0._r8
  this%XOQPZ=0._r8
  this%XOQAZ=0._r8
  end subroutine nit_omcplxf_zero
!------------------------------------------------------------------------------------------

  subroutine nit_omcplxs_init(this)
  implicit none
  class(NitroOMcplxStateType) :: this
  integer :: ncplx

  ncplx=micpar%jcplx
  allocate(this%OSRH(1:ncplx))
  allocate(this%TOMK(1:ncplx+1))
  allocate(this%TONK(1:ncplx+1))
  allocate(this%TOPK(1:ncplx+1))
  allocate(this%FOCA(1:ncplx))
  allocate(this%FOAA(1:ncplx))
  allocate(this%CNQ(1:ncplx))
  allocate(this%CPQ(1:ncplx))
  allocate(this%CNH(1:ncplx))
  allocate(this%CPH(1:ncplx))
  allocate(this%ORCT(1:ncplx))
  allocate(this%OSCT(1:ncplx))
  allocate(this%OSAT(1:ncplx))
  allocate(this%TONX(1:ncplx+1))
  allocate(this%TOPX(1:ncplx+1))
  allocate(this%COQC(1:ncplx))
  allocate(this%COQA(1:ncplx))
  call this%ZeroOut()
  end subroutine nit_omcplxs_init
!------------------------------------------------------------------------------------------

  subroutine nit_omcplxs_zero(this)

  implicit none
  class(NitroOMcplxStateType) :: this

  this%OSRH=0._r8
  this%TOMK=0._r8
  this%TONK=0._r8
  this%TOPK=0._r8
  this%FOCA=0._r8
  this%FOAA=0._r8
  this%CNQ=0._r8
  this%CPQ=0._r8
  this%CNH=0._r8
  this%CPH=0._r8
  this%ORCT=0._r8
  this%OSCT=0._r8
  this%OSAT=0._r8
  this%TONX=0._r8
  this%TOPX=0._r8

  end subroutine nit_omcplxs_zero


!------------------------------------------------------------------------------------------
  subroutine nit_omcplxs_destroy(this)
  implicit none
  class(NitroOMcplxStateType) :: this

  call destroy(this%OSRH)
  call destroy(this%TOMK)
  call destroy(this%TONK)
  call destroy(this%TOPK)
  call destroy(this%FOCA)
  call destroy(this%FOAA)
  call destroy(this%CNQ)
  call destroy(this%CPQ)
  call destroy(this%CNH)
  call destroy(this%CPH)
  call destroy(this%ORCT)
  call destroy(this%OSCT)
  call destroy(this%OSAT)
  call destroy(this%TONX)
  call destroy(this%TOPX)
  call destroy(this%COQC)
  call destroy(this%COQA)

  end subroutine nit_omcplxs_destroy
end module NitroDiagTypes
