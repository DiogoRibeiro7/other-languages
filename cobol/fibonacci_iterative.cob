       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIBIT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 N            PIC 9(02) VALUE 20.
       01 I            PIC 9(02) VALUE 0.
       01 PREV-VALUE   PIC 9(18) VALUE 0.
       01 CURR-VALUE   PIC 9(18) VALUE 1.
       01 NEXT-VALUE   PIC 9(18) VALUE 0.
       01 RESULT       PIC 9(18) VALUE 0.

       PROCEDURE DIVISION.
           IF N = 0
               MOVE 0 TO RESULT
           ELSE
               IF N = 1
                   MOVE 1 TO RESULT
               ELSE
                   PERFORM VARYING I FROM 2 BY 1 UNTIL I > N
                       ADD PREV-VALUE CURR-VALUE GIVING NEXT-VALUE
                       MOVE CURR-VALUE TO PREV-VALUE
                       MOVE NEXT-VALUE TO CURR-VALUE
                   END-PERFORM
                   MOVE CURR-VALUE TO RESULT
               END-IF
           END-IF

           DISPLAY "FIB_ITERATIVE(" N ") = " RESULT
           STOP RUN.
