isSelectedMark = 'x'
divider = '|'

COLUMN_INDEX_TASK_NAME = 1
COLUMN_INDEX_CHECKBOX = 2
COLUMN_INDEX_RECURRING = 3
COLUMN_INDEX_IMPORTANT = 4

function Initialize()
	sDynamicMeterFile = SELF:GetOption('DynamicMeterFile')
	sTaskListFile = SELF:GetOption('TaskListFile')
	sTrashListFile = SELF:GetOption('TrashTaskListFile')
	SHOW_RECURRING = SELF:GetNumberOption('SHOW_RECURRING', 1)
	SHOW_IMPORTANT = SELF:GetNumberOption('SHOW_IMPORTANT', 1)
	TRASH_LIMIT = SELF:GetNumberOption('TRASH_LIMIT', 10)
	WHITE_COLOR = SELF:GetOption('ACTIVE_TASK_COLOR', '255,255,255,255')
	COMLETED_TASK_COLOR = SELF:GetOption('COMLETED_TASK_COLOR', '255,255,255,170')
	BUTTON_COLOR = SELF:GetOption('BUTTON_COLOR', '255,255,255,255')
	FONT_FACE = SELF:GetOption('FONT_FACE', 'Inter')
	FONT_SIZE = SELF:GetNumberOption('FONT_SIZE', 15)
	BUTTON_SIZE = SELF:GetNumberOption('BUTTON_SIZE', 16)
	
	TOTAL_BUTTON_COUNT = 3

	if SHOW_RECURRING == 1 then
		TOTAL_BUTTON_COUNT = TOTAL_BUTTON_COUNT + 1
	end 

	if SHOW_IMPORTANT == 1 then
		TOTAL_BUTTON_COUNT = TOTAL_BUTTON_COUNT + 1
	end 

	APPROX_BUTTON_WIDTH = BUTTON_SIZE * 2
	

	if TOTAL_BUTTON_COUNT == 3 then
		APPROX_BUTTON_WIDTH = BUTTON_SIZE * 3
	elseif TOTAL_BUTTON_COUNT == 4 then
		APPROX_BUTTON_WIDTH = BUTTON_SIZE * 2.3
	end



	SKIN_WIDTH = SKIN:GetW() - (APPROX_BUTTON_WIDTH * TOTAL_BUTTON_COUNT)
end


function GetTasks()
	local taskList = {}
	for line in io.lines(sTaskListFile) do		
			taskList[#taskList + 1] = SplitText(line)
	end
	return taskList
end

function GetTrash()
	local trashTaskList = {}
	for line in io.lines(sTrashListFile) do		
		trashTaskList[#trashTaskList + 1] = line
	end
	return trashTaskList
end

function Update()

	-- task scheme
		-- name
		-- checked
		-- recurring
		-- important

	dynamicOutput = {}
	tasks = GetTasks()

	-- dynamic measures checking task status
	for i=1,#tasks,1 do 
		dynamicOutput[#dynamicOutput + 1] = "[MeasureTaskIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Measure=String"
		dynamicOutput[#dynamicOutput + 1] = "String=#check"..i.."state#"
		dynamicOutput[#dynamicOutput + 1] = "IfMatch=0"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchAction=[!SetVariable check"..i.." mui-check]"
		dynamicOutput[#dynamicOutput + 1] = "IfNotMatchAction=[!SetVariable check"..i.." mui-checked]"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchMode=1"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"

		if SHOW_RECURRING == 1 then
			dynamicOutput[#dynamicOutput + 1] = "[MeasureRecurringIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Measure=String"
			dynamicOutput[#dynamicOutput + 1] = "String=#recurring"..i.."state#"
			dynamicOutput[#dynamicOutput + 1] = "IfMatch=0"
			dynamicOutput[#dynamicOutput + 1] = "IfMatchAction=[!SetVariable recurring"..i.." "..COMLETED_TASK_COLOR.."]"
			dynamicOutput[#dynamicOutput + 1] = "IfNotMatchAction=[!SetVariable recurring"..i.." "..WHITE_COLOR.."]"
			dynamicOutput[#dynamicOutput + 1] = "IfMatchMode=1"
			dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
		end

		if SHOW_IMPORTANT == 1 then
			dynamicOutput[#dynamicOutput + 1] = "[MeasureImportantIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Measure=String"
			dynamicOutput[#dynamicOutput + 1] = "String=#important"..i.."state#"
			dynamicOutput[#dynamicOutput + 1] = "IfMatch=0"
			dynamicOutput[#dynamicOutput + 1] = "IfMatchAction=[!SetVariable important"..i.." "..COMLETED_TASK_COLOR.."]"
			dynamicOutput[#dynamicOutput + 1] = "IfNotMatchAction=[!SetVariable important"..i.." "..WHITE_COLOR.."]"
			dynamicOutput[#dynamicOutput + 1] = "IfMatchMode=1"
			dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
		end
		
	end

	-- dynamic meters
	for i=1,#tasks,1 do
		if i == 1 then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "X=10"
			dynamicOutput[#dynamicOutput + 1] = "Y=10"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W="..APPROX_BUTTON_WIDTH..""

			dynamicOutput[#dynamicOutput + 1] = "[MeterRepeatingTask"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W="..SKIN_WIDTH..""

			-- recurring
			if SHOW_RECURRING == 1 then
				dynamicOutput[#dynamicOutput + 1] = "[MeterRecurringIcon"..i.."]"
				dynamicOutput[#dynamicOutput + 1] = "Meter=String"
				dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureRecurringIcon"..i
				dynamicOutput[#dynamicOutput + 1] = "Text=#mui-repeat#"
				dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
				dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
				dynamicOutput[#dynamicOutput + 1] = "FontColor="..COMLETED_TASK_COLOR..""
				dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
				dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
				dynamicOutput[#dynamicOutput + 1] = "X=R"
				dynamicOutput[#dynamicOutput + 1] = "Y=r"
				dynamicOutput[#dynamicOutput + 1] = "H=35"
				dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
			end 

			-- important
			if SHOW_IMPORTANT == 1 then
				dynamicOutput[#dynamicOutput + 1] = "[MeterImportantIcon"..i.."]"
				dynamicOutput[#dynamicOutput + 1] = "Meter=String"
				dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureImportantIcon"..i
				dynamicOutput[#dynamicOutput + 1] = "Text=#mui-important#"
				dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
				dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
				dynamicOutput[#dynamicOutput + 1] = "FontColor="..COMLETED_TASK_COLOR..""
				dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
				dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
				dynamicOutput[#dynamicOutput + 1] = "X=4R"
				dynamicOutput[#dynamicOutput + 1] = "Y=r"
				dynamicOutput[#dynamicOutput + 1] = "H=35"
				dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
			end

	
		else
		local prevIndex = i - 1
		local nextIndex = i + 1
		-- checkbox
		dynamicOutput[#dynamicOutput + 1] = "[MeterTaskIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureTaskIcon"..i
		dynamicOutput[#dynamicOutput + 1] = "Text=[#[#check"..i.."]]"
		dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
		dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""

		if tasks[i][COLUMN_INDEX_CHECKBOX] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..COMLETED_TASK_COLOR..""
		else
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..WHITE_COLOR..""
		end

		dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
		dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
		dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
		dynamicOutput[#dynamicOutput + 1] = "X=10"
		dynamicOutput[#dynamicOutput + 1] = "Y=R"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		dynamicOutput[#dynamicOutput + 1] = "W="..APPROX_BUTTON_WIDTH..""
		dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!SetVariable check"..i.."state (1-#check"..i.."state#)][!CommandMeasure \"MeasureDynamicTasks\" \"Toggle("..i..",2)\"] [!Refresh][!Refresh]"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
		
		-- task name
		dynamicOutput[#dynamicOutput + 1] = "[MeterRepeatingTask"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "Text="..tasks[i][COLUMN_INDEX_TASK_NAME]
		dynamicOutput[#dynamicOutput + 1] = "FontFace="..FONT_FACE..""
		dynamicOutput[#dynamicOutput + 1] = "FontSize="..FONT_SIZE..""

		-- grey out done task
		if tasks[i][COLUMN_INDEX_CHECKBOX] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..COMLETED_TASK_COLOR..""
		else
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..WHITE_COLOR..""
		end


		dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
		dynamicOutput[#dynamicOutput + 1] = "StringStyle=Bold"
		dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
		dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
		dynamicOutput[#dynamicOutput + 1] = "X=R"
		dynamicOutput[#dynamicOutput + 1] = "Y=r"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		dynamicOutput[#dynamicOutput + 1] = "W="..SKIN_WIDTH..""
		
		
		-- recurring
		if SHOW_RECURRING == 1 then
			dynamicOutput[#dynamicOutput + 1] = "[MeterRecurringIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureRecurringIcon"..i
			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor=[#recurring"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!SetVariable recurring"..i.."state (1-#recurring"..i.."state#)][!CommandMeasure \"MeasureDynamicTasks\" \"Toggle("..i..", 3)\"] [!Refresh][!Refresh]"
			dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"

			if tasks[i][COLUMN_INDEX_RECURRING] == isSelectedMark then
				dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-circle-checked]"
			else
				dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-circle]"
			end

		end


		-- important
		if SHOW_IMPORTANT == 1 then
			dynamicOutput[#dynamicOutput + 1] = "[MeterImportantIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureImportantIcon"..i


			if tasks[i][COLUMN_INDEX_IMPORTANT] == isSelectedMark then
				dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-circle-checked]"
			else
				dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-circle]"
			end


			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor=[#important"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "X=4R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!SetVariable important"..i.."state (1-#important"..i.."state#)][!CommandMeasure \"MeasureDynamicTasks\" \"Toggle("..i..", 4)\"] [!Refresh][!Refresh]"
			dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
		end


		-- up		
		dynamicOutput[#dynamicOutput + 1] = "[MeterTaskUpIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskUpIcon"..i

		if i == 2 then
			dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-up]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor=0,0,0,0"
		end

		if i ~= 2 then
			dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-up]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..BUTTON_COLOR..""
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"ChangeOrder("..i..","..prevIndex..")\"][!Refresh][!Refresh]"
		end

		dynamicOutput[#dynamicOutput + 1] = "X=4R"
		dynamicOutput[#dynamicOutput + 1] = "Y=r"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		
		-- down

		if table.getn(tasks) > 2 and i ~= table.getn(tasks)  then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDownIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskDownIcon"..i

			dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-down]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..BUTTON_COLOR..""
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"


			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"ChangeOrder("..i..","..nextIndex..")\"][!Refresh][!Refresh]"
		end

		if table.getn(tasks) > 2 and i == table.getn(tasks)  then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDownIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskDownIcon"..i
			dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-down]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor=0,0,0,0"
			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
		end

		
		-- delete
		if tasks[i][COLUMN_INDEX_RECURRING] ~= isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDeleteIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskDeleteIcon"..i
			dynamicOutput[#dynamicOutput + 1] = "Text=[#mui-to-trash]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
			dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..BUTTON_COLOR..""
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "X=4R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"RemoveTask("..i..")\"][!Refresh][!Refresh]"
		else
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDeleteIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "X=4R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
		end

		end
	end

	dynamicOutput[#dynamicOutput + 1] = "[Variables]"


	-- variables for each task
	for i=1,#tasks,1 do
		if tasks[i][COLUMN_INDEX_CHECKBOX] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."state=1"
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."=mui-checked"
		else
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."state=0"
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."=mui-check"
		end

		if tasks[i][COLUMN_INDEX_RECURRING] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."state=1"
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."=255,255,255,255"
		else
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."state=0"
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."=100,100,100,100"
		end

		if tasks[i][COLUMN_INDEX_IMPORTANT] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."state=1"
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."=255,255,255,255"
		else
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."state=0"
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."=100,100,100,100"
		end
	end
	

	-- include Font Awesome icons
	dynamicOutput[#dynamicOutput + 1] = "@Include=#@#MUI.inc"

	-- refresh button
	dynamicOutput[#dynamicOutput + 1] = "[MeterRefreshTasks]"
	dynamicOutput[#dynamicOutput + 1] = "Meter=String"
	dynamicOutput[#dynamicOutput + 1] = "Text=#mui-refresh#"
	dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
	dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
	dynamicOutput[#dynamicOutput + 1] = "FontColor="..BUTTON_COLOR..""
	dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
	dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
	dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
	dynamicOutput[#dynamicOutput + 1] = "X=10"
	dynamicOutput[#dynamicOutput + 1] = "Y=15R"
	dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!Refresh][!Refresh]"

	-- add button
	dynamicOutput[#dynamicOutput + 1] = "[MeterAddTasks]"
	dynamicOutput[#dynamicOutput + 1] = "Meter=String"
	dynamicOutput[#dynamicOutput + 1] = "Text=#mui-create#"
	dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
	dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
	dynamicOutput[#dynamicOutput + 1] = "FontColor="..BUTTON_COLOR..""
	dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
	dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
	dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
	dynamicOutput[#dynamicOutput + 1] = "X=4R"
	dynamicOutput[#dynamicOutput + 1] = "Y=r"
	dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure MeasureInput \"ExecuteBatch 1-2\"]"

	-- undo button

	local trashTasks = GetTrash()


	if table.getn(trashTasks) > 0 then

	dynamicOutput[#dynamicOutput + 1] = "[MeterUndoTasks]"
	dynamicOutput[#dynamicOutput + 1] = "Meter=String"
	dynamicOutput[#dynamicOutput + 1] = "Text=#mui-from-trash#"
	dynamicOutput[#dynamicOutput + 1] = "FontFace=Material Icons"
	dynamicOutput[#dynamicOutput + 1] = "FontSize="..BUTTON_SIZE..""
	dynamicOutput[#dynamicOutput + 1] = "FontColor="..BUTTON_COLOR..""
	dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
	dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
	dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
	dynamicOutput[#dynamicOutput + 1] = "X=4R"
	dynamicOutput[#dynamicOutput + 1] = "Y=r"
	dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"UndoDeletedTask()\"][!Refresh][!Refresh]"

	end
		
	-- create dynamic meter file
	local File = io.open(sDynamicMeterFile, 'w')

	-- error handling
	if not File then
		print('Update: unable to open file at ' .. sDynamicMeterFile)
		return
	end

	output = table.concat(dynamicOutput, '\n')

	File:write(output)
	File:close()

	return true
	
end

function Toggle(lineNumber, columnIndex)

	tasks = GetTasks()
	content = {}

	for i=1,#tasks,1 do 
		if i == lineNumber then
			if tasks[i][columnIndex] == isSelectedMark then
				tasks[i][columnIndex] = ''
			else
				tasks[i][columnIndex] = isSelectedMark
			end
		end

		content[#content+1] = table.concat(tasks[i], divider)
	end

	-- open task list for writing
    hFile = io.open( sTaskListFile, "w+" )
 
    for i = 1, #content do
		hFile:write( string.format( "%s\n", content[i] ) )
    end
 
	hFile:close()

	return true

end


function ChangeOrder(currentLine, nextLine)	
	tasks = GetTasks()
	content = {}
	temp = {}

	-- because of the header line
	if nextLine == 1 then
		return false
	end

	temp = tasks[currentLine]
	tasks[currentLine] = tasks[nextLine]
	tasks[nextLine] = temp

	for i=1,#tasks,1 do 
		content[#content+1] = table.concat(tasks[i], divider)
	end

	hFile = io.open( sTaskListFile, "w+" )
 
    for i = 1, #content do
		hFile:write( string.format( "%s\n", content[i] ) )
    end
 
	hFile:close()

	return true
end
	
function AddTask(newline)
	-- read entire task list
	local hFile = io.open(sTaskListFile, "r")
	local wholeFile = hFile:read("*a")
	hFile:close()
	-- write task list back to itself and add new line
	hFile = io.open(sTaskListFile, "w")
	hFile:write(wholeFile)
	-- we add tree ||| because of scheme. 
	-- todo: do it with loop ;)
	hFile:write(newline .. "|||", "\n")
	hFile:close()
	return true
end

function AddToTrash(newline)
	-- read entire task list
	local hFile = io.open(sTrashListFile, "r")
	local wholeFile = hFile:read("*a")
	hFile:close()
	-- write task list back to itself and add new line
	hFile = io.open(sTrashListFile, "w")
	hFile:write(wholeFile)
	-- we add tree ||| because of scheme. 
	-- todo: do it with loop ;)
	hFile:write(newline, "\n")
	hFile:close()
	return true
end

function RemoveTask( starting_line, isPermanentDelete )
	targetFile = sTaskListFile
	tasks = GetTasks()

	if isPermanentDelete == 1 then
		targetFile = sTrashListFile
	end
	
    local hFile = io.open( targetFile, "r" )
 
    content = {}
    i = 1;
    for line in hFile:lines() do
        if i < starting_line or i >= starting_line + 1 then
	    content[#content+1] = line
	end
	i = i + 1
    end
 
    if i > starting_line and i < starting_line + 1 then
		print( "Warning: Tried to remove lines after EOF." )
    end
 
	-- close task list for reading
    hFile:close()
	
	-- open task list for writing
    hFile = io.open( targetFile, "w+" )
 
    for i = 1, #content do
		hFile:write( string.format( "%s\n", content[i] ) )
    end
 
	hFile:close()

	-- not to trash
	if isPermanentDelete ~= 1 then
		AddToTrash(tasks[starting_line][1])

		local trashTasks = GetTrash()
		local tableLength = table.getn(trashTasks)

		if tableLength > TRASH_LIMIT then
			RemoveTask(1,1)
		end

	end

	return true
end

function UndoDeletedTask()
	local trashTasks = GetTrash()
	local tableLength = table.getn(trashTasks)

	RemoveTask(tableLength,1)
	AddTask(trashTasks[tableLength])

end

-- string split function
function SplitText(inputstr, sep) sep=sep or '%|' local t={}  for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do table.insert(t,field)  if s=="" then return t end end end
