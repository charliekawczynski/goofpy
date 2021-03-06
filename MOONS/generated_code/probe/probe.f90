       module probe_mod
       use current_precision_mod
       use IO_tools_mod
       use string_mod
       implicit none

       private
       public :: probe
       public :: init,delete,display,print,export,import

       interface init;   module procedure init_probe;          end interface
       interface delete; module procedure delete_probe;        end interface
       interface display;module procedure display_probe;       end interface
       interface print;  module procedure print_probe;         end interface
       interface export; module procedure export_probe;        end interface
       interface import; module procedure import_probe;        end interface
       interface export; module procedure export_wrapper_probe;end interface
       interface import; module procedure import_wrapper_probe;end interface

       type probe
         type(string) :: dir
         type(string) :: name
         real(cp) :: d = 0.0_cp
         real(cp) :: d_data_dt = 0.0_cp
         real(cp) :: d_amax = 0.0_cp
         real(cp) :: t = 0.0_cp
         integer :: un = 0
         integer :: cols = 0
         integer(li) :: n_step = 0
         logical :: restart = .false.
         logical :: simple = .false.
       end type

       contains

       subroutine init_probe(this,that)
         implicit none
         type(probe),intent(inout) :: this
         type(probe),intent(in) :: that
         call delete(this)
         call init(this%dir,that%dir)
         call init(this%name,that%name)
         this%d = that%d
         this%d_data_dt = that%d_data_dt
         this%d_amax = that%d_amax
         this%t = that%t
         this%un = that%un
         this%cols = that%cols
         this%n_step = that%n_step
         this%restart = that%restart
         this%simple = that%simple
       end subroutine

       subroutine delete_probe(this)
         implicit none
         type(probe),intent(inout) :: this
         call delete(this%dir)
         call delete(this%name)
         this%d = 0.0_cp
         this%d_data_dt = 0.0_cp
         this%d_amax = 0.0_cp
         this%t = 0.0_cp
         this%un = 0
         this%cols = 0
         this%n_step = 0
         this%restart = .false.
         this%simple = .false.
       end subroutine

       subroutine display_probe(this,un)
         implicit none
         type(probe),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) ' -------------------- probe'
         call display(this%dir,un)
         call display(this%name,un)
         write(un,*) 'd         = ',this%d
         write(un,*) 'd_data_dt = ',this%d_data_dt
         write(un,*) 'd_amax    = ',this%d_amax
         write(un,*) 't         = ',this%t
         write(un,*) 'un        = ',this%un
         write(un,*) 'cols      = ',this%cols
         write(un,*) 'n_step    = ',this%n_step
         write(un,*) 'restart   = ',this%restart
         write(un,*) 'simple    = ',this%simple
       end subroutine

       subroutine print_probe(this)
         implicit none
         type(probe),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_probe(this,un)
         implicit none
         type(probe),intent(in) :: this
         integer,intent(in) :: un
         call export(this%dir,un)
         call export(this%name,un)
         write(un,*) this%d
         write(un,*) this%d_data_dt
         write(un,*) this%d_amax
         write(un,*) this%t
         write(un,*) this%un
         write(un,*) this%cols
         write(un,*) this%n_step
         write(un,*) this%restart
         write(un,*) this%simple
       end subroutine

       subroutine import_probe(this,un)
         implicit none
         type(probe),intent(inout) :: this
         integer,intent(in) :: un
         call delete(this)
         call import(this%dir,un)
         call import(this%name,un)
         read(un,*) this%d
         read(un,*) this%d_data_dt
         read(un,*) this%d_amax
         read(un,*) this%t
         read(un,*) this%un
         read(un,*) this%cols
         read(un,*) this%n_step
         read(un,*) this%restart
         read(un,*) this%simple
       end subroutine

       subroutine export_wrapper_probe(this,dir,name)
         implicit none
         type(probe),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_wrapper_probe(this,dir,name)
         implicit none
         type(probe),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module