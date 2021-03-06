       module stitch_face_mod
       use IO_tools_mod
       implicit none

       private
       public :: stitch_face
       public :: init,delete,display,print,export,import

       interface init;   module procedure init_stitch_face;          end interface
       interface delete; module procedure delete_stitch_face;        end interface
       interface display;module procedure display_stitch_face;       end interface
       interface print;  module procedure print_stitch_face;         end interface
       interface export; module procedure export_stitch_face;        end interface
       interface import; module procedure import_stitch_face;        end interface
       interface export; module procedure export_wrapper_stitch_face;end interface
       interface import; module procedure import_wrapper_stitch_face;end interface

       type stitch_face
         logical,dimension(3) :: hmin = .false.
         logical,dimension(3) :: hmax = .false.
         integer,dimension(3) :: hmin_id = 0
         integer,dimension(3) :: hmax_id = 0
       end type

       contains

       subroutine init_stitch_face(this,that)
         implicit none
         type(stitch_face),intent(inout) :: this
         type(stitch_face),intent(in) :: that
         call delete(this)
         this%hmin = that%hmin
         this%hmax = that%hmax
         this%hmin_id = that%hmin_id
         this%hmax_id = that%hmax_id
       end subroutine

       subroutine delete_stitch_face(this)
         implicit none
         type(stitch_face),intent(inout) :: this
         this%hmin = .false.
         this%hmax = .false.
         this%hmin_id = 0
         this%hmax_id = 0
       end subroutine

       subroutine display_stitch_face(this,un)
         implicit none
         type(stitch_face),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) ' -------------------- stitch_face'
         write(un,*) 'hmin    = ',this%hmin
         write(un,*) 'hmax    = ',this%hmax
         write(un,*) 'hmin_id = ',this%hmin_id
         write(un,*) 'hmax_id = ',this%hmax_id
       end subroutine

       subroutine print_stitch_face(this)
         implicit none
         type(stitch_face),intent(in) :: this
         call display(this,6)
       end subroutine

       subroutine export_stitch_face(this,un)
         implicit none
         type(stitch_face),intent(in) :: this
         integer,intent(in) :: un
         write(un,*) this%hmin
         write(un,*) this%hmax
         write(un,*) this%hmin_id
         write(un,*) this%hmax_id
       end subroutine

       subroutine import_stitch_face(this,un)
         implicit none
         type(stitch_face),intent(inout) :: this
         integer,intent(in) :: un
         call delete(this)
         read(un,*) this%hmin
         read(un,*) this%hmax
         read(un,*) this%hmin_id
         read(un,*) this%hmax_id
       end subroutine

       subroutine export_wrapper_stitch_face(this,dir,name)
         implicit none
         type(stitch_face),intent(in) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call export(this,un)
         close(un)
       end subroutine

       subroutine import_wrapper_stitch_face(this,dir,name)
         implicit none
         type(stitch_face),intent(inout) :: this
         character(len=*),intent(in) :: dir,name
         integer :: un
         un = new_and_open(dir,name)
         call import(this,un)
         close(un)
       end subroutine

       end module