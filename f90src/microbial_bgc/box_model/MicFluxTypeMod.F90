module MicFluxTypeMod

  use data_kind_mod, only : r8 => DAT_KIND_R8
  use EcoSiMParDataMod, only : micpar
  use EcoSIMSolverPar, only : NPH
  use abortutils, only : destroy
implicit none

  private
  character(len=*), parameter :: mod_filename = __FILE__

  type, public :: micfluxtype

  real(r8) :: RCO2O
  real(r8) :: RCH4O
  real(r8) :: RH2GO
  real(r8) :: RUPOXO
  real(r8) :: RN2G
  real(r8) :: RN2O
  real(r8) :: XNH4S
  real(r8) :: XNO3S
  real(r8) :: XNO2S
  real(r8) :: XH2PS
  real(r8) :: XH1PS
  real(r8) :: XNH4B
  real(r8) :: XNO3B
  real(r8) :: XNO2B
  real(r8) :: XH2BS
  real(r8) :: XH1BS
  real(r8) :: XN2GS
  real(r8) :: RVMXC
  real(r8) :: RVMBC
  real(r8) :: TRINH4
  real(r8) :: TRIPO4
  real(r8), allocatable :: XOQCS(:)
  real(r8), allocatable :: XOQNS(:)
  real(r8), allocatable :: XOQPS(:)
  real(r8), allocatable :: XOQAS(:)
  real(r8), allocatable :: ROXYSff(:)
  real(r8), allocatable :: RVMX4ff(:)
  real(r8), allocatable :: RVMB4ff(:)
  real(r8), allocatable :: RVMX2ff(:)
  real(r8), allocatable :: RVMB2ff(:)
  real(r8), allocatable :: ROXYS(:,:)
  real(r8), allocatable :: ROQCS(:,:)
  real(r8), allocatable :: ROQAS(:,:)
  real(r8), allocatable :: RVMX3(:,:)
  real(r8), allocatable :: RVMB3(:,:)
  real(r8), allocatable :: RVMX2(:,:)
  real(r8), allocatable :: RVMB2(:,:)
  real(r8), allocatable :: RVMX1(:,:)
  real(r8), allocatable :: ROXSK(:)
  real(r8), allocatable :: RVMX4(:,:)
  real(r8), allocatable :: RVMB4(:,:)
  real(r8), allocatable :: RINHO(:,:)
  real(r8), allocatable :: RINHB(:,:)
  real(r8), allocatable :: RINOO(:,:)
  real(r8), allocatable :: RINOB(:,:)
  real(r8), allocatable :: RIPOO(:,:)
  real(r8), allocatable :: RIPBO(:,:)
  real(r8), allocatable :: RIPO1(:,:)
  real(r8), allocatable :: RIPB1(:,:)
  real(r8), allocatable :: RINHOR(:,:)
  real(r8), allocatable :: RINOOR(:,:)
  real(r8), allocatable :: RIPOOR(:,:)
  real(r8), allocatable :: RIPO1R(:,:)
  real(r8), allocatable :: RINHOff(:)
  real(r8), allocatable :: RINHBff(:)
  real(r8), allocatable :: RINOOff(:)
  real(r8), allocatable :: RINOBff(:)
  real(r8), allocatable :: RIPOOff(:)
  real(r8), allocatable :: RIPBOff(:)
  real(r8), allocatable :: RIPO1ff(:)
  real(r8), allocatable :: RIPB1ff(:)
  real(r8), allocatable :: RINHORff(:)
  real(r8), allocatable :: RINOORff(:)
  real(r8), allocatable :: RIPOORff(:)
  real(r8), allocatable :: RIPO1Rff(:)
  contains
   procedure, public :: Init
   procedure, public :: Destroy=> Destruct
   procedure, public :: ZeroOut
  end type micfluxtype

  contains

  subroutine Init(this)

  implicit none
  class(micfluxtype) :: this
  integer :: jcplx,JG,NFGs
  integer :: NMICBSO, NMICBSA

  jcplx=micpar%jcplx
  JG=micpar%jguilds
  NFGs=micpar%NFGs
  NMICBSO=micpar%NMICBSO
  NMICBSA=micpar%NMICBSA
  allocate(this%ROXSK(NPH));this%ROXSK = 0._r8
  allocate(this%XOQCS(1:jcplx));this%XOQCS=0._r8
  allocate(this%XOQNS(1:jcplx));this%XOQNS=0._r8
  allocate(this%XOQPS(1:jcplx));this%XOQPS=0._r8
  allocate(this%XOQAS(1:jcplx));this%XOQAS=0._r8
  allocate(this%ROXYS(NMICBSO,1:jcplx));this%ROXYS=0._r8
  allocate(this%ROQCS(NMICBSO,1:jcplx));this%ROQCS=0._r8
  allocate(this%ROQAS(NMICBSO,1:jcplx));this%ROQAS=0._r8
  allocate(this%RVMX3(NMICBSO,1:jcplx));this%RVMX3=0._r8
  allocate(this%RVMB3(NMICBSO,1:jcplx));this%RVMB3=0._r8
  allocate(this%RVMX2(NMICBSO,1:jcplx));this%RVMX2=0._r8
  allocate(this%RVMB2(NMICBSO,1:jcplx));this%RVMB2=0._r8
  allocate(this%RVMX1(NMICBSO,1:jcplx));this%RVMX1=0._r8
  allocate(this%RVMX4(NMICBSO,1:jcplx));this%RVMX4=0._r8
  allocate(this%RVMB4(NMICBSO,1:jcplx));this%RVMB4=0._r8
  allocate(this%RINHO(NMICBSO,1:jcplx));this%RINHO=0._r8
  allocate(this%RINHB(NMICBSO,1:jcplx));this%RINHB=0._r8
  allocate(this%RINOO(NMICBSO,1:jcplx));this%RINOO=0._r8
  allocate(this%RINOB(NMICBSO,1:jcplx));this%RINOB=0._r8
  allocate(this%RIPOO(NMICBSO,1:jcplx));this%RIPOO=0._r8
  allocate(this%RIPBO(NMICBSO,1:jcplx));this%RIPBO=0._r8
  allocate(this%RIPO1(NMICBSO,1:jcplx));this%RIPO1=0._r8
  allocate(this%RIPB1(NMICBSO,1:jcplx));this%RIPB1=0._r8
  allocate(this%RINHOR(NMICBSO,1:jcplx));this%RINHOR=0._r8
  allocate(this%RINOOR(NMICBSO,1:jcplx));this%RINOOR=0._r8
  allocate(this%RIPOOR(NMICBSO,1:jcplx));this%RIPOOR=0._r8
  allocate(this%RIPO1R(NMICBSO,1:jcplx));this%RIPO1R=0._r8
  allocate(this%ROXYSff(NMICBSA));this%ROXYSff=0._r8
  allocate(this%RINHOff(NMICBSA));this%RINHOff=0._r8
  allocate(this%RINHBff(NMICBSA));this%RINHBff=0._r8
  allocate(this%RINOOff(NMICBSA));this%RINOOff=0._r8
  allocate(this%RINOBff(NMICBSA));this%RINOBff=0._r8
  allocate(this%RIPOOff(NMICBSA));this%RIPOOff=0._r8
  allocate(this%RIPBOff(NMICBSA));this%RIPBOff=0._r8
  allocate(this%RIPO1ff(NMICBSA));this%RIPO1ff=0._r8
  allocate(this%RIPB1ff(NMICBSA));this%RIPB1ff=0._r8
  allocate(this%RINHORff(NMICBSA));this%RINHORff=0._r8
  allocate(this%RINOORff(NMICBSA));this%RINOORff=0._r8
  allocate(this%RIPOORff(NMICBSA));this%RIPOORff=0._r8
  allocate(this%RIPO1Rff(NMICBSA));this%RIPO1Rff=0._r8
  allocate(this%RVMX4ff(NMICBSA));this%RVMX4ff=0._r8
  allocate(this%RVMB4ff(NMICBSA));this%RVMB4ff=0._r8
  allocate(this%RVMX2ff(NMICBSA));this%RVMX2ff=0._r8
  allocate(this%RVMB2ff(NMICBSA));this%RVMB2ff=0._r8

  end subroutine Init
!------------------------------------------------------------------------------------------
  subroutine ZeroOut(this)

  implicit none
  class(micfluxtype) :: this
  integer :: jcplx,JG,NFGs

  this%ROXSK = 0._r8
  this%XOQCS=0._r8
  this%XOQNS=0._r8
  this%XOQPS=0._r8
  this%XOQAS=0._r8
  this%ROXYS=0._r8
  this%ROQCS=0._r8
  this%ROQAS=0._r8
  this%RVMX3=0._r8
  this%RVMB3=0._r8
  this%RVMX2=0._r8
  this%RVMB2=0._r8
  this%RVMX1=0._r8
  this%RVMX4=0._r8
  this%RVMB4=0._r8
  this%RINHO=0._r8
  this%RINHB=0._r8
  this%RINOO=0._r8
  this%RINOB=0._r8
  this%RIPOO=0._r8
  this%RIPBO=0._r8
  this%RIPO1=0._r8
  this%RIPB1=0._r8
  this%RINHOR=0._r8
  this%RINOOR=0._r8
  this%RIPOOR=0._r8
  this%RIPO1R=0._r8
  this%ROXYSff=0._r8
  this%RINHOff=0._r8
  this%RINHBff=0._r8
  this%RINOOff=0._r8
  this%RINOBff=0._r8
  this%RIPOOff=0._r8
  this%RIPBOff=0._r8
  this%RIPO1ff=0._r8
  this%RIPB1ff=0._r8
  this%RINHORff=0._r8
  this%RINOORff=0._r8
  this%RIPOORff=0._r8
  this%RIPO1Rff=0._r8
  this%RVMX4ff=0._r8
  this%RVMB4ff=0._r8
  this%RVMX2ff=0._r8
  this%RVMB2ff=0._r8

  end subroutine ZeroOut
!------------------------------------------------------------------------------------------
  subroutine Destruct(this)
  use abortutils, only : destroy
  implicit none
  class(micfluxtype) :: this

  call destroy(this%XOQCS)
  call destroy(this%XOQNS)
  call destroy(this%XOQPS)
  call destroy(this%XOQAS)
  call destroy(this%RVMX4ff)
  call destroy(this%RVMB4ff)
  call destroy(this%RVMX2ff)
  call destroy(this%RVMB2ff)
  call destroy(this%ROXYS)
  call destroy(this%ROQCS)
  call destroy(this%ROQAS)
  call destroy(this%RVMX3)
  call destroy(this%RVMB3)
  call destroy(this%RVMX2)
  call destroy(this%RVMB2)
  call destroy(this%RVMX1)
  call destroy(this%ROXSK)
  call destroy(this%RVMX4)
  call destroy(this%RVMB4)
  call destroy(this%RINHO)
  call destroy(this%RINHB)
  call destroy(this%RINOO)
  call destroy(this%RINOB)
  call destroy(this%RIPOO)
  call destroy(this%RIPBO)
  call destroy(this%RIPO1)
  call destroy(this%RIPB1)
  call destroy(this%RINHOR)
  call destroy(this%RINOOR)
  call destroy(this%RIPOOR)
  call destroy(this%RIPO1R)
  call destroy(this%RINHOff)
  call destroy(this%RINHBff)
  call destroy(this%RINOOff)
  call destroy(this%RINOBff)
  call destroy(this%RIPOOff)
  call destroy(this%RIPBOff)
  call destroy(this%RIPO1ff)
  call destroy(this%RIPB1ff)
  call destroy(this%RINHORff)
  call destroy(this%RINOORff)
  call destroy(this%RIPOORff)
  call destroy(this%RIPO1Rff)
  call destroy(this%ROXYSff)

  end subroutine Destruct
end module MicFluxTypeMod
