isSelectedMark = 'x'
divider = '|'
WHITE_COLOR = '255,255,255,255'
OPAQUE_WHITE_COLOR = '255,255,255,170'
TRASH_LIMIT = 10;

function Initialize()
	sDynamicMeterFile = SELF:GetOption('DynamicMeterFile')
	sTaskListFile = SELF:GetOption('TaskListFile')
	sTrashListFile = SELF:GetOption('TrashTaskListFile')
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
		dynamicOutput[#dynamicOutput + 1] = "IfMatchAction=[!SetVariable check"..i.." fa-sq]"
		dynamicOutput[#dynamicOutput + 1] = "IfNotMatchAction=[!SetVariable check"..i.." fa-check-sq]"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchMode=1"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"

		dynamicOutput[#dynamicOutput + 1] = "[MeasureRecurringIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Measure=String"
		dynamicOutput[#dynamicOutput + 1] = "String=#recurring"..i.."state#"
		dynamicOutput[#dynamicOutput + 1] = "IfMatch=0"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchAction=[!SetVariable recurring"..i.." "..OPAQUE_WHITE_COLOR.."]"
		dynamicOutput[#dynamicOutput + 1] = "IfNotMatchAction=[!SetVariable recurring"..i.." "..WHITE_COLOR.."]"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchMode=1"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"

		dynamicOutput[#dynamicOutput + 1] = "[MeasureImportantIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Measure=String"
		dynamicOutput[#dynamicOutput + 1] = "String=#important"..i.."state#"
		dynamicOutput[#dynamicOutput + 1] = "IfMatch=0"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchAction=[!SetVariable important"..i.." "..OPAQUE_WHITE_COLOR.."]"
		dynamicOutput[#dynamicOutput + 1] = "IfNotMatchAction=[!SetVariable important"..i.." "..WHITE_COLOR.."]"
		dynamicOutput[#dynamicOutput + 1] = "IfMatchMode=1"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
		
	end

	-- dynamic meters
	for i=1,#tasks,1 do
		if i == 1 then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "X=0"
			dynamicOutput[#dynamicOutput + 1] = "Y=R"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=30"

			dynamicOutput[#dynamicOutput + 1] = "[MeterRepeatingTask"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=305"

			dynamicOutput[#dynamicOutput + 1] = "[MeterRecurringIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureRecurringIcon"..i
			dynamicOutput[#dynamicOutput + 1] = "Text=R"
			dynamicOutput[#dynamicOutput + 1] = "FontSize=8"
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..OPAQUE_WHITE_COLOR..""
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=35"
			dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"

			dynamicOutput[#dynamicOutput + 1] = "[MeterImportantIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureImportantIcon"..i
			dynamicOutput[#dynamicOutput + 1] = "Text=I"
			dynamicOutput[#dynamicOutput + 1] = "FontSize=8"
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..OPAQUE_WHITE_COLOR..""
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=50"
			dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
	

	
		else
		local prevIndex = i - 1
		local nextIndex = i + 1
		-- checkbox
		dynamicOutput[#dynamicOutput + 1] = "[MeterTaskIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureTaskIcon"..i
		dynamicOutput[#dynamicOutput + 1] = "Text=[#[#check"..i.."]]"
		dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
		dynamicOutput[#dynamicOutput + 1] = "FontSize=18"

		if tasks[i][2] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..OPAQUE_WHITE_COLOR..""
		else
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..WHITE_COLOR..""
		end

		dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
		dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
		dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
		dynamicOutput[#dynamicOutput + 1] = "X=0"
		dynamicOutput[#dynamicOutput + 1] = "Y=R"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		dynamicOutput[#dynamicOutput + 1] = "W=30"
		dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!SetVariable check"..i.."state (1-#check"..i.."state#)][!CommandMeasure \"MeasureDynamicTasks\" \"Toggle("..i..",2)\"] [!Refresh][!Refresh]"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"
		
		-- task name
		dynamicOutput[#dynamicOutput + 1] = "[MeterRepeatingTask"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "Text="..tasks[i][1]
		dynamicOutput[#dynamicOutput + 1] = "FontFace=Roboto"
		dynamicOutput[#dynamicOutput + 1] = "FontSize=16"

		-- grey out done task
		if tasks[i][2] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "FontColor="..OPAQUE_WHITE_COLOR..""
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
		dynamicOutput[#dynamicOutput + 1] = "W=300"
		
		
		-- recurring
		dynamicOutput[#dynamicOutput + 1] = "[MeterRecurringIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureRecurringIcon"..i
		dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
		dynamicOutput[#dynamicOutput + 1] = "FontSize=18"
		dynamicOutput[#dynamicOutput + 1] = "FontColor=[#recurring"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
		dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
		dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
		dynamicOutput[#dynamicOutput + 1] = "X=R"
		dynamicOutput[#dynamicOutput + 1] = "Y=r"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		dynamicOutput[#dynamicOutput + 1] = "W=30"
		dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!SetVariable recurring"..i.."state (1-#recurring"..i.."state#)][!CommandMeasure \"MeasureDynamicTasks\" \"Toggle("..i..", 3)\"] [!Refresh][!Refresh]"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"

		if tasks[i][3] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-check-circle-o]"
		else
			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-circle-o]"
		end


		-- important
		dynamicOutput[#dynamicOutput + 1] = "[MeterImportantIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeasureImportantIcon"..i


		if tasks[i][4] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-check-circle-o]"
		else
			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-circle-o]"
		end


		dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
		dynamicOutput[#dynamicOutput + 1] = "FontSize=18"
		dynamicOutput[#dynamicOutput + 1] = "FontColor=[#important"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
		dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
		dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
		dynamicOutput[#dynamicOutput + 1] = "X=R"
		dynamicOutput[#dynamicOutput + 1] = "Y=r"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		dynamicOutput[#dynamicOutput + 1] = "W=30"
		dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!SetVariable important"..i.."state (1-#important"..i.."state#)][!CommandMeasure \"MeasureDynamicTasks\" \"Toggle("..i..", 4)\"] [!Refresh][!Refresh]"
		dynamicOutput[#dynamicOutput + 1] = "DynamicVariables=1"


		-- delete
		if tasks[i][3] ~= isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDeleteIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskDeleteIcon"..i
			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-trash-o]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
			dynamicOutput[#dynamicOutput + 1] = "FontSize=18"
			dynamicOutput[#dynamicOutput + 1] = "FontColor=255,255,255,255"
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "X=4R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=30"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"RemoveTask("..i..")\"][!Refresh][!Refresh]"
		else
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDeleteIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "X=4R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=30"
		end

		-- up		
		dynamicOutput[#dynamicOutput + 1] = "[MeterTaskUpIcon"..i.."]"
		dynamicOutput[#dynamicOutput + 1] = "Meter=String"
		dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskUpIcon"..i

		if i ~= 2 then
			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-angle-up]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
			dynamicOutput[#dynamicOutput + 1] = "FontSize=18"
			dynamicOutput[#dynamicOutput + 1] = "FontColor=255,255,255,255"
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"ChangeOrder("..i..","..prevIndex..")\"][!Refresh][!Refresh]"
		end

		dynamicOutput[#dynamicOutput + 1] = "X=4R"
		dynamicOutput[#dynamicOutput + 1] = "Y=r"
		dynamicOutput[#dynamicOutput + 1] = "H=35"
		dynamicOutput[#dynamicOutput + 1] = "W=30"
		
		-- down

		if table.getn(tasks) > 2 then
			dynamicOutput[#dynamicOutput + 1] = "[MeterTaskDownIcon"..i.."]"
			dynamicOutput[#dynamicOutput + 1] = "Meter=String"
			dynamicOutput[#dynamicOutput + 1] = "MeasureName=MeterTaskDownIcon"..i

			dynamicOutput[#dynamicOutput + 1] = "Text=[#fa-angle-down]"
			dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
			dynamicOutput[#dynamicOutput + 1] = "FontSize=18"
			dynamicOutput[#dynamicOutput + 1] = "FontColor=255,255,255,255"
			dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
			dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
			dynamicOutput[#dynamicOutput + 1] = "ClipString=1"


			dynamicOutput[#dynamicOutput + 1] = "X=R"
			dynamicOutput[#dynamicOutput + 1] = "Y=r"
			dynamicOutput[#dynamicOutput + 1] = "H=35"
			dynamicOutput[#dynamicOutput + 1] = "W=30"
			dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure \"MeasureDynamicTasks\" \"ChangeOrder("..i..","..nextIndex..")\"][!Refresh][!Refresh]"
		end

		end
	end

	dynamicOutput[#dynamicOutput + 1] = "[Variables]"


	-- variables for each task
	for i=1,#tasks,1 do
		if tasks[i][2] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."state=1"
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."=fa-check-sq"
		else
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."state=0"
			dynamicOutput[#dynamicOutput + 1] = "check"..i.."=fa-sq"
		end

		if tasks[i][3] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."state=1"
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."=255,255,255,255"
		else
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."state=0"
			dynamicOutput[#dynamicOutput + 1] = "recurring"..i.."=100,100,100,100"
		end

		if tasks[i][4] == isSelectedMark then
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."state=1"
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."=255,255,255,255"
		else
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."state=0"
			dynamicOutput[#dynamicOutput + 1] = "important"..i.."=100,100,100,100"
		end
	end
	

	-- include Font Awesome icons
	dynamicOutput[#dynamicOutput + 1] = "@Include=#@#FontAwesome.inc"

	-- refresh button
	dynamicOutput[#dynamicOutput + 1] = "[MeterRefreshTasks]"
	dynamicOutput[#dynamicOutput + 1] = "Meter=String"
	dynamicOutput[#dynamicOutput + 1] = "Text=#fa-refresh#"
	dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
	dynamicOutput[#dynamicOutput + 1] = "FontSize=16"
	dynamicOutput[#dynamicOutput + 1] = "FontColor=255,255,255,255"
	dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
	dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
	dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
	dynamicOutput[#dynamicOutput + 1] = "X=0"
	dynamicOutput[#dynamicOutput + 1] = "Y=15R"
	dynamicOutput[#dynamicOutput + 1] = "W=30"
	dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!Refresh][!Refresh]"

	-- add button
	dynamicOutput[#dynamicOutput + 1] = "[MeterAddTasks]"
	dynamicOutput[#dynamicOutput + 1] = "Meter=String"
	dynamicOutput[#dynamicOutput + 1] = "Text=#fa-plus-sq#"
	dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
	dynamicOutput[#dynamicOutput + 1] = "FontSize=16"
	dynamicOutput[#dynamicOutput + 1] = "FontColor=255,255,255,255"
	dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
	dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
	dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
	dynamicOutput[#dynamicOutput + 1] = "X=R"
	dynamicOutput[#dynamicOutput + 1] = "Y=r"
	dynamicOutput[#dynamicOutput + 1] = "W=30"
	dynamicOutput[#dynamicOutput + 1] = "LeftMouseUpAction=[!CommandMeasure MeasureInput \"ExecuteBatch 1-2\"]"

	-- undo button

	local trashTasks = GetTrash()


	if table.getn(trashTasks) > 0 then

	dynamicOutput[#dynamicOutput + 1] = "[MeterUndoTasks]"
	dynamicOutput[#dynamicOutput + 1] = "Meter=String"
	dynamicOutput[#dynamicOutput + 1] = "Text=#fa-undo#"
	dynamicOutput[#dynamicOutput + 1] = "FontFace=FontAwesome"
	dynamicOutput[#dynamicOutput + 1] = "FontSize=16"
	dynamicOutput[#dynamicOutput + 1] = "FontColor=255,255,255,255"
	dynamicOutput[#dynamicOutput + 1] = "SolidColor=0,0,0,1"
	dynamicOutput[#dynamicOutput + 1] = "AntiAlias=1"
	dynamicOutput[#dynamicOutput + 1] = "ClipString=1"
	dynamicOutput[#dynamicOutput + 1] = "X=R"
	dynamicOutput[#dynamicOutput + 1] = "Y=r"
	dynamicOutput[#dynamicOutput + 1] = "W=30"
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
