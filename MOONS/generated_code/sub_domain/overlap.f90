       module overlap_mod
       use IO_tools_mod
       implicit none

       private
       public :: overlap
       public :: init,delete,display,print,export,import

       interface init;   module procedure init_overlap;          end interface
       interface delete; module procedure delete_overlap;        end interface
       interface display;module procedure display_overlap;       end interface
       interface print;  module procedure print_overlap;         end interface
       interface export; module procedure export_overlap;        end interface
       interface import; module procedure import_overlap;        end interface
       interface export; module procedure export_wrapper_overlap;end interface
       interface import; module procedure import_wrapper_overlap;end interface

       type overlap
         integer,dimension(2) :: i1 = 0
         integer,dimension(2) :: i2 = 0
         integer :: ir = 0
         logical :: success = .false.
       end type

       contains

       subroutine init_overlap(this,that)
         implicit none
         type(overlap),intent(inout) :: this
         type(overlap),intent(in) :: that
         call delete(this)
         this%i1 = that%i1
         this%i2 = that%i2
         this%ir = that%ir
         this%success = that%success
       end subroutine

       subroutine delete_overlap(this)
         implicit none
         type(overlap),intent(inout) :: this
         this%i1 = 0
         this%i2 = 0
         this%ir = 0
         this%success = .false.
       end subroutine

       subroutine display_overlap(this,un)
         implicit none
         type(overlap),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) ' -------------------- overlap'
         write(un,*) 'i1      = ',this%i1
         write(un,*) 'i2      = ',this%i2
         write(un,*) 'ir      = ',this%ir
         write(un,*) 'success = ',this%success
       end subroutine

       subroutine print_overlap(this)
         implicit none
         type(overlap),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_overlap(this,un)
         implicit none
         type(overlap),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) this%i1
         write(un,*) this%i2
         write(un,*) this%ir
         write(un,*) this%success
       end subroutine

       subroutine import_overlap(this,un)
         implicit none
         type(overlap),intent(inout) :: this
         integer,intent(in) :: un
         call delete(this)
         read(un,*) this%i1
         read(un,*) this%i2
         read(un,*) this%ir
         read(un,*) this%success
       end subroutine

       subroutine export_wrapper_overlap(this,dir,name)
         implicit none
         type(overlap),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_wrapper_overlap(this,dir,name)
         implicit none
         type(overlap),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module