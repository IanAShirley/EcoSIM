module EcoSIMAPI
  USE EcoSIMCtrlDataType
  use timings      , only : start_timer, end_timer
  use ErosionMod   , only : erosion
  use Hour1Mod     , only : hour1
  use RedistMod    , only : redist
  use GeochemAPI   , only : soluteModel
  use PlantAPI     , only : PlantModel
  use MicBGCAPI    , only : MicrobeModel, MicAPI_Init, MicAPI_cleanup
  use TrnsfrMod    , only : trnsfr
  use TrnsfrsMod   , only : trnsfrs
  use EcoSIMCtrlMod, only : lverb,plant_model,soichem_model,micb_model,salt_model
  use WatsubMod    , only : watsub
implicit none

  character(len=*),private, parameter :: mod_filename = __FILE__
  public :: Run_EcoSIM_one_step

contains

  subroutine Run_EcoSIM_one_step(I,J,NHW,NHE,NVN,NVS)

  implicit none
  integer, intent(in) :: I,J,NHW,NHE,NVN,NVS
  real(r8) :: t1

  if(lverb)WRITE(*,334)'HOUR1'
  call start_timer(t1)
  CALL HOUR1(I,J,NHW,NHE,NVN,NVS)
  call end_timer('HOUR1',t1)
  !
  !   CALCULATE SOIL ENERGY BALANCE, WATER AND HEAT FLUXES IN 'WATSUB'
  !
  if(lverb)WRITE(*,334)'WAT'
  call start_timer(t1)
  CALL WATSUB(I,J,NHW,NHE,NVN,NVS)
  call end_timer('WAT',t1)
  !
  !   CALCULATE SOIL BIOLOGICAL TRANSFORMATIONS IN 'NITRO'
  !
  if(micb_model)then
    if(lverb)WRITE(*,334)'NIT'
    call start_timer(t1)
    CALL MicrobeModel(I,J,NHW,NHE,NVN,NVS)
    call end_timer('NIT',t1)
  endif
  !
  !   UPDATE PLANT biogeochemistry
  !
  if(lverb)WRITE(*,334)'PlantModel'
  if(plant_model)then
    call PlantModel(I,J,NHW,NHE,NVN,NVS)
  endif
  !
  !
  !   CALCULATE SOLUTE EQUILIBRIA IN 'SOLUTE'
  !
  
  if(soichem_model)then
    if(lverb)WRITE(*,334)'SOL'  
    call start_timer(t1)
    CALL soluteModel(I,J,NHW,NHE,NVN,NVS)
    call end_timer('SOL',t1)
  endif
  !
  !   CALCULATE GAS AND SOLUTE FLUXES IN 'TRNSFR'
  !
  if(lverb)WRITE(*,334)'TRN'
  call start_timer(t1)
  CALL TRNSFR(I,J,NHW,NHE,NVN,NVS)
  call end_timer('TRN',t1)
  !
  !   CALCULATE ADDITIONAL SOLUTE FLUXES IN 'TRNSFRS' IF SALT OPTION SELECTED
  !
  if(lverb)WRITE(*,334)'TRNS'
  !    if(I>=170)print*,TKS(0,NVN,NHW)'
  if(salt_model)then
    call start_timer(t1)
    CALL TRNSFRS(I,J,NHW,NHE,NVN,NVS)
    call end_timer('TRNSFRS',t1)
  endif
  !
  !   CALCULATE SOIL SEDIMENT TRANSPORT IN 'EROSION'
  !
  if(lverb)WRITE(*,334)'EROSION'
  !    if(I>=170)print*,TKS(0,NVN,NHW)
  call start_timer(t1)
  CALL EROSION(I,J,NHW,NHE,NVN,NVS)
  call end_timer('EROSION',t1)
  !
  !   UPDATE ALL SOIL STATE VARIABLES FOR WATER, HEAT, GAS, SOLUTE
  !   AND SEDIMENT FLUXES IN 'REDIST'
  !
  if(lverb)WRITE(*,334)'RED'
  !    if(I>=170)print*,TKS(0,NVN,NHW)
  call start_timer(t1)
  CALL REDIST(I,J,NHW,NHE,NVN,NVS)
  call end_timer('RED',t1)

334   FORMAT(A8)

  end subroutine Run_EcoSIM_one_step



end module EcoSIMAPI
