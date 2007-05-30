module m_dom_error

  use pxf, only: pxfabort

  use m_common_error, only: error_stack, add_error
  implicit none
  private

  !-------------------------------------------------------
  ! EXCEPTION CODES
  !-------------------------------------------------------
  integer, parameter, public :: INDEX_SIZE_ERR              = 1
  integer, parameter, public :: DOMSTRING_SIZE_ERR          = 2
  integer, parameter, public :: HIERARCHY_REQUEST_ERR       = 3
  integer, parameter, public :: WRONG_DOCUMENT_ERR          = 4
  integer, parameter, public :: INVALID_CHARACTER_ERR       = 5
  integer, parameter, public :: NO_DATA_ALLOWED_ERR         = 6
  integer, parameter, public :: NO_MODIFICATION_ALLOWED_ERR = 7
  integer, parameter, public :: NOT_FOUND_ERR               = 8
  integer, parameter, public :: NOT_SUPPORTED_ERR           = 9
  integer, parameter, public :: INUSE_ATTRIBUTE_ERR         = 10
  integer, parameter, public :: INVALID_STATE_ERR           = 11
  integer, parameter, public :: SYNTAX_ERR                  = 12
  integer, parameter, public :: INVALID_MODIFICATION_ERR    = 13
  integer, parameter, public :: NAMESPACE_ERR               = 14
  integer, parameter, public :: INVALID_ACCESS_ERR          = 15
  integer, parameter, public :: VALIDATION_ERR              = 16
  integer, parameter, public :: TYPE_MISMATCH_ERR           = 17

  integer, parameter, public :: FoX_INVALID_CHARACTER       = 201
  integer, parameter, public :: FoX_INVALID_XML_NAME        = 202
  integer, parameter, public :: FoX_INVALID_PI_TARGET       = 203
  integer, parameter, public :: FoX_INVALID_CDATA_SECTION   = 204
  integer, parameter, public :: FoX_INVALID_COMMENT_DATA    = 205

  character(len=27), dimension(0:17), parameter :: errorString = (/ &
    "XMLF90_ERR                 ", &
    "INDEX_SIZE_ERR             ", &
    "DOMSTRING_SIZE_ERR         ", &
    "HIERARCHY_REQUEST_ERR      ", &
    "WRONG_DOCUMENT_ERR         ", &
    "INVALID_CHARACTER_ERR      ", &
    "NO_DATA_ALLOWED_ERR        ", &
    "NO_MODIFICATION_ALLOWED_ERR", &
    "NOT_FOUND_ERR              ", &
    "NOT_SUPPORTED_ERR          ", &
    "INUSE_ATTRIBUTE_ERR        ", &
    "INVALID_STATE_ERR          ", &
    "SYNTAX_ERR                 ", &
    "INVALID_MODIFICATION_ERR   ", &
    "NAMESPACE_ERR              ", &
    "INVALID_ACCESS_ERR         ", &
    "VALIDATION_ERR             ", &
    "TYPE_MISMATCH_ERR          " /)

  public :: dom_error
  public :: internal_error

contains

  subroutine throw_exception(code, msg, ex)
    integer, intent(in) :: code
    character(len=*), intent(in) :: msg
    type(error_stack), intent(inout), optional :: ex

    if (present(ex)) then
      call add_error(ex, msg, 0) ! FIXME
    else
      write(0,'(a)') errorString(code)
      write(0,'(a)') msg
      call pxfabort()
    endif
      
  end subroutine throw_exception


  subroutine dom_error(name,code,msg)
    character(len=*), intent(in) :: name, msg
    integer, intent(in)          :: code

    write(0,'(4a)') "Routine ", name, ":", msg
    write(0,'(a)') errorString(code)
    call pxfabort()

  end subroutine dom_error


  subroutine internal_error(name,msg)
    character(len=*), intent(in) :: name, msg

    write(0,'(4a)') "Internal error in ", name, ":", msg
    call pxfabort()

  end subroutine internal_error

end module m_dom_error
