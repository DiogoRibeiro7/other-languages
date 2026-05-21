       IDENTIFICATION DIVISION.
       PROGRAM-ID. TXNREPORT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TXN-FILE ASSIGN TO "cobol/sample_transactions.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  TXN-FILE.
       01  TXN-LINE                PIC X(19).

       WORKING-STORAGE SECTION.
       01  WS-EOF                  PIC X VALUE "N".
           88 END-OF-FILE          VALUE "Y".
       01  WS-RECORD-COUNT         PIC 9(5) VALUE 0.
       01  WS-VALID-COUNT          PIC 9(5) VALUE 0.
       01  WS-INVALID-COUNT        PIC 9(5) VALUE 0.
       01  WS-DEBIT-TOTAL          PIC 9(12) VALUE 0.
       01  WS-CREDIT-TOTAL         PIC 9(12) VALUE 0.
       01  WS-NET-TOTAL            PIC S9(12) VALUE 0.

       01  WS-ACCOUNT              PIC X(10).
       01  WS-TYPE                 PIC X.
       01  WS-AMOUNT-TEXT          PIC X(8).
       01  WS-AMOUNT               PIC 9(8) VALUE 0.

       PROCEDURE DIVISION.
           OPEN INPUT TXN-FILE
           PERFORM UNTIL END-OF-FILE
               READ TXN-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       PERFORM PROCESS-RECORD
               END-READ
           END-PERFORM
           CLOSE TXN-FILE

           COMPUTE WS-NET-TOTAL = WS-DEBIT-TOTAL - WS-CREDIT-TOTAL

           DISPLAY "TRANSACTION REPORT"
           DISPLAY "TOTAL_RECORDS=" WS-RECORD-COUNT
           DISPLAY "VALID_RECORDS=" WS-VALID-COUNT
           DISPLAY "INVALID_RECORDS=" WS-INVALID-COUNT
           DISPLAY "DEBIT_TOTAL_CENTS=" WS-DEBIT-TOTAL
           DISPLAY "CREDIT_TOTAL_CENTS=" WS-CREDIT-TOTAL
           DISPLAY "NET_TOTAL_CENTS=" WS-NET-TOTAL
           STOP RUN.

       PROCESS-RECORD.
           ADD 1 TO WS-RECORD-COUNT
           MOVE TXN-LINE(1:10) TO WS-ACCOUNT
           MOVE TXN-LINE(11:1) TO WS-TYPE
           MOVE TXN-LINE(12:8) TO WS-AMOUNT-TEXT

           IF WS-TYPE NOT = "D" AND WS-TYPE NOT = "C"
               ADD 1 TO WS-INVALID-COUNT
               EXIT PARAGRAPH
           END-IF

           IF WS-AMOUNT-TEXT IS NOT NUMERIC
               ADD 1 TO WS-INVALID-COUNT
               EXIT PARAGRAPH
           END-IF

           MOVE WS-AMOUNT-TEXT TO WS-AMOUNT
           ADD 1 TO WS-VALID-COUNT

           IF WS-TYPE = "D"
               ADD WS-AMOUNT TO WS-DEBIT-TOTAL
           ELSE
               ADD WS-AMOUNT TO WS-CREDIT-TOTAL
           END-IF.
