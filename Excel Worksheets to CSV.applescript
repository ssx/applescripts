-- Excel Spreadsheet to CSV Files
-- by Scott Wilcox <scott@dor.ky>
-- https://github.com/dordotky/applescripts

-- Get the filename of the Excel Spreadsheet we're going to use
set theFile to (choose file with prompt "Select the Excel Spreadsheet to Convert:")

-- The directory that will contain our CSV files
set outputDirectory to (choose folder with prompt "Select Folder to Output To:")
tell application "Microsoft Excel"
	-- Get Excel to activate
	activate
	
	-- Close any workbooks that we have open
	close workbooks
	
	-- Ask Excel to open the theFile spreadsheet
	open theFile
	
	-- Set maxCount to the total number of sheets in this workbook
	set maxCount to count of worksheets of active workbook
	
	-- For each sheet in the workbook, loop through then one by one
	repeat with i from 1 to maxCount
		if i > 1 then
			open theFile
		end if
		
		-- Set the current worksheet to our loop position
		set theWorksheetname to name of worksheet i of active workbook
		set theWorksheet to worksheet i of active workbook
		activate object theWorksheet
		
		-- Save the worksheet as a CSV file
		set theSheetsPath to outputDirectory & theWorksheetname & ".csv" as string
		save as theWorksheet filename theSheetsPath file format CSV file format with overwrite
		
		-- Close the worksheet that we've just created
		close active workbook saving no
	end repeat
	
	-- Clean up and close files
	close workbooks
end tell
