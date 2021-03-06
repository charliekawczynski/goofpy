       module refine_mesh_mod
       use IO_tools_mod
       use string_mod
       use step_mod
       implicit none

       private
       public :: refine_mesh
       public :: init,delete,display,print,export,import

       interface init;   module procedure init_refine_mesh;          end interface
       interface delete; module procedure delete_refine_mesh;        end interface
       interface display;module procedure display_refine_mesh;       end interface
       interface print;  module procedure print_refine_mesh;         end interface
       interface export; module procedure export_refine_mesh;        end interface
       interface import; module procedure import_refine_mesh;        end interface
       interface export; module procedure export_wrapper_refine_mesh;end interface
       interface import; module procedure import_wrapper_refine_mesh;end interface

       type refine_mesh
         type(step) :: all
         type(step) :: x
         type(step) :: y
         type(step) :: z
         type(step) :: x_plane
         type(step) :: y_plane
         type(step) :: z_plane
         logical :: any_next = .false.
         integer :: un = 0
         integer :: i_level = 0
         integer :: i_level_last = 0
         type(string) :: dir
         type(string) :: name
         type(string) :: level
         type(string) :: level_last
       end type

       contains

       subroutine init_refine_mesh(this,that)
         implicit none
         type(refine_mesh),intent(inout) :: this
         type(refine_mesh),intent(in) :: that
         call delete(this)
         call init(this%all,that%all)
         call init(this%x,that%x)
         call init(this%y,that%y)
         call init(this%z,that%z)
         call init(this%x_plane,that%x_plane)
         call init(this%y_plane,that%y_plane)
         call init(this%z_plane,that%z_plane)
         this%any_next = that%any_next
         this%un = that%un
         this%i_level = that%i_level
         this%i_level_last = that%i_level_last
         call init(this%dir,that%dir)
         call init(this%name,that%name)
         call init(this%level,that%level)
         call init(this%level_last,that%level_last)
       end subroutine

       subroutine delete_refine_mesh(this)
         implicit none
         type(refine_mesh),intent(inout) :: this
         call delete(this%all)
         call delete(this%x)
         call delete(this%y)
         call delete(this%z)
         call delete(this%x_plane)
         call delete(this%y_plane)
         call delete(this%z_plane)
         this%any_next = .false.
         this%un = 0
         this%i_level = 0
         this%i_level_last = 0
         call delete(this%dir)
         call delete(this%name)
         call delete(this%level)
         call delete(this%level_last)
       end subroutine

       subroutine display_refine_mesh(this,un)
         implicit none
         type(refine_mesh),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) ' -------------------- refine_mesh'
         call display(this%all,un)
         call display(this%x,un)
         call display(this%y,un)
         call display(this%z,un)
         call display(this%x_plane,un)
         call display(this%y_plane,un)
         call display(this%z_plane,un)
         write(un,*) 'any_next     = ',this%any_next
         write(un,*) 'un           = ',this%un
         write(un,*) 'i_level      = ',this%i_level
         write(un,*) 'i_level_last = ',this%i_level_last
         call display(this%dir,un)
         call display(this%name,un)
         call display(this%level,un)
         call display(this%level_last,un)
       end subroutine

       subroutine print_refine_mesh(this)
         implicit none
         type(refine_mesh),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_refine_mesh(this,un)
         implicit none
         type(refine_mesh),intent(in) :: this
         integer,intent(in) :: un
         call export(this%all,un)
         call export(this%x,un)
         call export(this%y,un)
         call export(this%z,un)
         call export(this%x_plane,un)
         call export(this%y_plane,un)
         call export(this%z_plane,un)
         write(un,*) this%any_next
         write(un,*) this%un
         write(un,*) this%i_level
         write(un,*) this%i_level_last
         call export(this%dir,un)
         call export(this%name,un)
         call export(this%level,un)
         call export(this%level_last,un)
       end subroutine

       subroutine import_refine_mesh(this,un)
         implicit none
         type(refine_mesh),intent(inout) :: this
         integer,intent(in) :: un
         call delete(this)
         call import(this%all,un)
         call import(this%x,un)
         call import(this%y,un)
         call import(this%z,un)
         call import(this%x_plane,un)
         call import(this%y_plane,un)
         call import(this%z_plane,un)
         read(un,*) this%any_next
         read(un,*) this%un
         read(un,*) this%i_level
         read(un,*) this%i_level_last
         call import(this%dir,un)
         call import(this%name,un)
         call import(this%level,un)
         call import(this%level_last,un)
       end subroutine

       subroutine export_wrapper_refine_mesh(this,dir,name)
         implicit none
         type(refine_mesh),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_wrapper_refine_mesh(this,dir,name)
         implicit none
         type(refine_mesh),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module