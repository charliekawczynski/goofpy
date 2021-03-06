       module single_procedure_mod
       use IO_tools_mod
       use apply_face_BC_op_mod
       implicit none

       private
       public :: single_procedure
       public :: init,delete,display,print,export,import

       interface init;   module procedure init_single_procedure;          end interface
       interface delete; module procedure delete_single_procedure;        end interface
       interface display;module procedure display_single_procedure;       end interface
       interface print;  module procedure print_single_procedure;         end interface
       interface export; module procedure export_single_procedure;        end interface
       interface import; module procedure import_single_procedure;        end interface
       interface export; module procedure export_wrapper_single_procedure;end interface
       interface import; module procedure import_wrapper_single_procedure;end interface

       type single_procedure
         procedure(apply_face_bc_op),pointer,nopass :: p
         logical :: defined = .false.
         integer :: id = 0
       end type

       contains

       subroutine init_single_procedure(this,that)
         implicit none
         type(single_procedure),intent(inout) :: this
         type(single_procedure),intent(in) :: that
         call delete(this)
         this%p => that%p
         this%defined = that%defined
         this%id = that%id
       end subroutine

       subroutine delete_single_procedure(this)
         implicit none
         type(single_procedure),intent(inout) :: this
         nullify(this%p)
         this%defined = .false.
         this%id = 0
       end subroutine

       subroutine display_single_procedure(this,un)
         implicit none
         type(single_procedure),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) ' -------------------- single_procedure'
         write(un,*) 'defined = ',this%defined
         write(un,*) 'id      = ',this%id
       end subroutine

       subroutine print_single_procedure(this)
         implicit none
         type(single_procedure),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_single_procedure(this,un)
         implicit none
         type(single_procedure),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) this%defined
         write(un,*) this%id
       end subroutine

       subroutine import_single_procedure(this,un)
         implicit none
         type(single_procedure),intent(inout) :: this
         integer,intent(in) :: un
         call delete(this)
         read(un,*) this%defined
         read(un,*) this%id
       end subroutine

       subroutine export_wrapper_single_procedure(this,dir,name)
         implicit none
         type(single_procedure),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_wrapper_single_procedure(this,dir,name)
         implicit none
         type(single_procedure),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module