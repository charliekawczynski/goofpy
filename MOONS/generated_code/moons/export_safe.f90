       module export_safe_mod
       use current_precision_mod
       use IO_tools_mod
       implicit none

       private
       public :: export_safe
       public :: init,delete,display,print,export,import

       interface init;   module procedure init_export_safe;          end interface
       interface delete; module procedure delete_export_safe;        end interface
       interface display;module procedure display_export_safe;       end interface
       interface print;  module procedure print_export_safe;         end interface
       interface export; module procedure export_export_safe;        end interface
       interface import; module procedure import_export_safe;        end interface
       interface export; module procedure export_wrapper_export_safe;end interface
       interface import; module procedure import_wrapper_export_safe;end interface

       type export_safe
         logical :: export_now = .false.
         real(cp) :: export_period_sec = 0.0_cp
         real(cp) :: mod_period = 0.0_cp
         real(cp) :: mod_period_last = 0.0_cp
       end type

       contains

       subroutine init_export_safe(this,that)
         implicit none
         type(export_safe),intent(inout) :: this
         type(export_safe),intent(in) :: that
         call delete(this)
         this%export_now = that%export_now
         this%export_period_sec = that%export_period_sec
         this%mod_period = that%mod_period
         this%mod_period_last = that%mod_period_last
       end subroutine

       subroutine delete_export_safe(this)
         implicit none
         type(export_safe),intent(inout) :: this
         this%export_now = .false.
         this%export_period_sec = 0.0_cp
         this%mod_period = 0.0_cp
         this%mod_period_last = 0.0_cp
       end subroutine

       subroutine display_export_safe(this,un)
         implicit none
         type(export_safe),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) ' -------------------- export_safe'
         write(un,*) 'export_now        = ',this%export_now
         write(un,*) 'export_period_sec = ',this%export_period_sec
         write(un,*) 'mod_period        = ',this%mod_period
         write(un,*) 'mod_period_last   = ',this%mod_period_last
       end subroutine

       subroutine print_export_safe(this)
         implicit none
         type(export_safe),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_export_safe(this,un)
         implicit none
         type(export_safe),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) this%export_now
         write(un,*) this%export_period_sec
         write(un,*) this%mod_period
         write(un,*) this%mod_period_last
       end subroutine

       subroutine import_export_safe(this,un)
         implicit none
         type(export_safe),intent(inout) :: this
         integer,intent(in) :: un
         call delete(this)
         read(un,*) this%export_now
         read(un,*) this%export_period_sec
         read(un,*) this%mod_period
         read(un,*) this%mod_period_last
       end subroutine

       subroutine export_wrapper_export_safe(this,dir,name)
         implicit none
         type(export_safe),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_wrapper_export_safe(this,dir,name)
         implicit none
         type(export_safe),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module