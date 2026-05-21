program circlearea
    implicit none
    real :: radius, area
    real, parameter :: pi = 3.14159

    ! Compute the area of a circle from a provided radius.
    print *, "What is the radius?"
    read *, radius
    area = pi * radius ** 2
    print *, "The area is", area
end program circlearea
