function Initialize()
    taskPath = SKIN:MakePathAbsolute('\\@Resources\\taskPersistent.txt')
    taskFile = io.open(taskPath, "a+")
    io.output(taskFile)
    taskList = {}
    for line in taskFile:lines() do
        taskList[#taskList+1] = {0, line};
    end
    taskString = ""
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
    task = SKIN:GetVariable('NewTask')
    print(task)
    taskList[#taskList+1] = {0, task}
    needRefresh = 1
    io.write('\n'..task)
end