function Initialize()
    taskCount = 0
    taskPath = SKIN:MakePathAbsolute('\\@Resources\\taskPersistent.txt')
    taskFile = io.open(taskPath, "r")
    taskList = {}
    taskString = ""
    for line in taskFile:lines() do
        taskList[#taskList+1] = {0, line};
        taskCount = taskCount + 1
    end
    io.close(taskFile)
    needRefresh = 1
end

function Update()
    if needRefresh == 1 then
        needRefresh = 0
        taskString = ""
        concatList()
    end
    return taskString
end

function concatList()
    for i = 1, #taskList do
        taskString = taskString .. taskList[i][2] .. '\n'
    end
end

function addTask()
    taskFile = io.open(taskPath, "a+")
    io.output(taskFile)
    task = SKIN:GetVariable('NewTask')
    print(task)
    taskList[#taskList+1] = {0, task}
    needRefresh = 1
    io.write('\n'..task)
    io.close(taskFile)
end

function removeTask(index)
    table.remove(taskList, index)
    print(index)
    os.remove(taskPath)
    taskFile = io.open(taskPath, "a+")
    io.output(taskFile)
    for i = 1, #taskList do
        io.write(taskList[i][2]..'\n')
    end
    io.close(taskFile)
    needRefresh = 1
end

function detLine()
    mouseX = SKIN:GetVariable('$MouseX$')
    mouseY = SKIN:GetVariable('MouseYPos')
    removeTask(math.ceil(mouseY/26))
    print("Y: "..mouseY)
end