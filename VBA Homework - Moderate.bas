Attribute VB_Name = "Module1"
Sub homework()
    'Setup variables
    Dim ticker As String
    Dim volume As Double
    Dim openp As Double
    Dim closep As Double
        
    'loop through each worksheet
    For Each ws In Worksheets
        
        ' Determine the Ticker Last Row
        TickerLastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        'Set Starting Values
        ticker = ws.Cells(2, 1)
        openp = ws.Cells(2, 3)
        volume = 0
        
        'Start Table
            ws.Cells(1, 9) = "Ticker"
            ws.Cells(1, 10) = "Yearly Change"
            ws.Cells(1, 11) = "Percent Change"
            ws.Cells(1, 12) = "Total Stock Value"
        
        'loop through all rows on sheet
        For i = 2 To TickerLastRow
            
            'If this is not the first pass, add to volume and update closing price
            If ws.Cells(i, 1) = ticker Then
                volume = volume + Int(ws.Cells(i, 7))
                closep = ws.Cells(i, 6)
                
                'If original opening price was zero, update to current opening price
                If openp = 0 Then
                    openp = ws.Cells(i, 3)
                End If
            
            'If you encounter new ticker, fill data from the last ticker
            Else
                
                'Determine List Last Row
                ListLastRow = ws.Cells(Rows.Count, 9).End(xlUp).Row
                
                'Print Previous Ticker in Last Row
                ws.Cells(ListLastRow + 1, 9) = ticker
                ws.Cells(ListLastRow + 1, 10) = closep - openp
                If closep - openp > 0 Then
                    ws.Cells(ListLastRow + 1, 10).Interior.ColorIndex = 4
                Else
                    ws.Cells(ListLastRow + 1, 10).Interior.ColorIndex = 3
                End If
                If openp > 0 Then
                    ws.Cells(ListLastRow + 1, 11) = (closep - openp) / openp
                End If
                ws.Cells(ListLastRow + 1, 11).NumberFormat = "0.00%"
                ws.Cells(ListLastRow + 1, 12) = volume
                
                'Update volume and opening price for new ticker
                ticker = ws.Cells(i, 1)
                volume = Int(ws.Cells(i, 7))
                openp = ws.Cells(i, 3)
            End If
        Next i
    Next ws

End Sub

