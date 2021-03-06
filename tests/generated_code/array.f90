       module ARRAY_mod
       use module_needed_for_array_mod
       implicit none

       private
       public :: init,delete,display,print,export,import

       interface init;   module interface init_array;          end interface
       interface init;   module interface init_many_array;     end interface
       interface delete; module interface delete_array;        end interface
       interface delete; module interface delete_many_array;   end interface
       interface display;module interface display_array;       end interface
       interface display;module interface display_many_array;  end interface
       interface print;  module interface print_array;         end interface
       interface print;  module interface print_many_array;    end interface
       interface export; module interface export_array;        end interface
       interface import; module interface import_array;        end interface
       interface export; module interface export_wrapper_array;end interface
       interface import; module interface import_wrapper_array;end interface

       type ARRAY
         private
         integer :: n = 0
         real(8),dimension(:),allocatable :: a
       end type

       contains

       subroutine init_ARRAY(this,that)
         implicit none
         type(array),intent(inout) :: this
         type(array),intent(in) :: that
         call delete(this)
         this%n = that%n
         if (allocated(that%a)) then
           allocate(this%a(size(that%a)))
           this%a = that%a
         endif
       end subroutine

       subroutine init_many_ARRAY(this,that)
         implicit none
         type(array),dimension(:),intent(inout) :: this
         type(array),dimension(:),intent(in) :: that
         integer :: i_iter
         if (allocated(that)) then
           allocate(this(size(that)))
           do i_iter=1,size(this)
             call init(this(i_iter),that(i_iter))
           enddo
         endif
       end subroutine

       subroutine delete_ARRAY(this)
         implicit none
         type(array),intent(inout) :: this
         this%n = 0
         if (allocated(this%a)) then
           this%a = 0.0
           deallocate(this%a)
         endif
       end subroutine

       subroutine delete_many_ARRAY(this)
         implicit none
         type(array),dimension(:),intent(inout) :: this
         integer :: i_iter
         if (allocated(this)) then
           do i_iter=1,size(this)
             call delete(this(i_iter))
           enddo
           deallocate(this)
         endif
       end subroutine

       subroutine display_ARRAY(this,un)
         implicit none
         type(array),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) 'n = ',this%n
         write(un,*) 'a = ',this%a
       end subroutine

       subroutine display_many_ARRAY(this,un)
         implicit none
         type(array),dimension(:),intent(in) :: this
         integer,intent(in) :: un
         integer :: i_iter
         if (allocated(this)) then
           do i_iter=1,size(this)
             call display(this(i_iter),un)
           enddo
         endif
       end subroutine

       subroutine print_ARRAY(this)
         implicit none
         type(array),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine print_many_ARRAY(this)
         implicit none
         type(array),dimension(:),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_ARRAY(this,un)
         implicit none
         type(array),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) this%n
         write(un,*) this%a
       end subroutine

       subroutine export_wrapper_ARRAY(this,dir,name)
         implicit none
         type(array),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_ARRAY(this,un)
         implicit none
         type(array),intent(inout) :: this
         integer,intent(in) :: un
         read(un,*) this%n
         read(un,*) this%a
       end subroutine

       subroutine import_wrapper_ARRAY(this,dir,name)
         implicit none
         type(array),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module