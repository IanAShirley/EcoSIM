module PlantDisturbMod
!
!! Description:
! code to apply distance to plants
  use data_kind_mod, only : r8 => DAT_KIND_R8
  use minimathmod, only : test_aeqb
  use SOMDataType
  use GrosubPars
  use PlantTraitDataType
  use GridConsts
  use FlagDataType
  use SoilWaterDataType
  use EcoSIMCtrlDataType
  use PlantDataRateType
  use FertilizerDataType
  use ClimForcDataType
  use EcosimConst
  use PlantMngmtDataType
  use RootDataType
  use CanopyDataType
  use EcoSimSumDataType
  use SoilBGCDataType
  use EcosimBGCFluxType
  use GridDataType
  implicit none
  private
  character(len=*),private, parameter :: mod_filename = __FILE__
! end_include_section

  public :: PrepLandscapeGrazing
  contains

!------------------------------------------------------------------------------------------

  subroutine PrepLandscapeGrazing(I,J,NHW,NHE,NVN,NVS)
  implicit none
  integer, intent(in) :: I, J
  integer, intent(in) :: NHW,NHE,NVN,NVS
  integer :: NX,NY,NZ,nn,nx1,NY1
  real(r8) :: WTSHTZ
!     begin_execution

  D2995: DO NX=NHW,NHE
    D2990: DO NY=NVN,NVS
      D2985: DO NZ=1,NP(NY,NX)
!
!     IHVST=harvest type:0=none,1=grain,2=all above-ground
!                       ,3=pruning,4=grazing,5=fire,6=herbivory
!     LSG=landscape grazing section number
!     WTSHTZ,WTSHTA=total,average biomass in landscape grazing section
!
        IF(IHVST(NZ,I,NY,NX).EQ.4.OR.IHVST(NZ,I,NY,NX).EQ.6)THEN
          WTSHTZ=0
          NN=0
          D1995: DO NX1=NHW,NHE
            D1990: DO NY1=NVN,NVS
              IF(LSG(NZ,NY1,NX1).EQ.LSG(NZ,NY,NX))THEN
                IF(IFLGC(NZ,NY1,NX1).EQ.1)THEN
                  WTSHTZ=WTSHTZ+WTSHTE(ielmc,NZ,NY1,NX1)
                  NN=NN+1
                ENDIF
              ENDIF
            ENDDO D1990
          ENDDO D1995
          IF(NN.GT.0)THEN
            WTSHTA(NZ,NY,NX)=WTSHTZ/NN
          ELSE
            WTSHTA(NZ,NY,NX)=WTSHTE(ielmc,NZ,NY,NX)
          ENDIF
        ENDIF
      ENDDO D2985
    ENDDO D2990
  ENDDO D2995
  end subroutine PrepLandscapeGrazing
end module PlantDisturbMod
