# Rainmeter To-Do

While searching for a Rainmeter todo skin for my personal needs, I found a skin named [rainmeter-todo-list](https://github.com/Pernickety/rainmeter-todo-list). This project has been developed based on [rainmeter-todo-list](https://github.com/Pernickety/rainmeter-todo-list).  I developed this code with various performance fixes and features (delete, order, trash etc...).

## Preview

![](https://raw.githubusercontent.com/alperenozlu/rainmeter-todo/master/screenshots/Preview.PNG)


## Features

- Add Task 
- Delete Task
- Reorder Task
- Mark the task as recurring (R) and important (I)
- Recover deleted tasks
- The completed task looks opaque

## Installing

###### Via Installer

+ Go to [release](https://github.com/alperenozlu/rainmeter-todo/releases) page and download latest .rmskin file.
+ Install skin with double click to downloaded file.
+ Activate skin

###### Via Source Code

- Download this source code and place entire `rainmeter-todo` folder in your Rainmeter skins location. Generally it is look like `C:\Users\<USERNAME>\Documents\Rainmeter\Skins\`
- Activate skin

##### Activate Skin

- Activate `rainmeter-todo` skin
  - You can do this by right-clicking on an already active skin to bring up the Rainmeter menu
  - Navigate to `Rainmeter > Skins > rainmeter-todo > todo > todo.ini`
    - If you do not see `rainmeter-todo` in the skin selection, try navigating to `Rainmeter > Refresh all`

## Preview

![](https://raw.githubusercontent.com/alperenozlu/rainmeter-todo/master/screenshots/CreateTask.gif)

![](https://raw.githubusercontent.com/alperenozlu/rainmeter-todo/master/screenshots/Reorder.gif)

![](https://raw.githubusercontent.com/alperenozlu/rainmeter-todo/master/screenshots/RecurringImportant.gif)

![](https://raw.githubusercontent.com/alperenozlu/rainmeter-todo/master/screenshots/Recover.gif)

## Editing Directly

In an emergency, you may want to edit the task file manually. For this, you must first know the structure of the task file.

- In the first line of the `tasks.txt` file, there is `task|x|x` information. This line should never be deleted. The program accepts this line as the title.

- Each line in the file is a task.

- Task's information is separated by  `|` character. The attribute belonging to a column is shown in the table below.  

  - | 1         | 2            | 3            | 4            |
    | --------- | ------------ | ------------ | ------------ |
    | Task Text | Is Completed | Is Recurring | Is Important |

    For example, a completed and important task would look like this `task title|x||x` 
    
    If it's just a completed task, it's look like `task title|x||` 

## Sync With Multiple Device

Added and deleted tasks are stored on a file basis. Since there is no database connection, you can use programs such as Google Drive, Dropbox, OneDrive to synchronize between multiple devices.

- Go to `rainmeter-todo` folder in your Rainmeter skins location
- Start the sync process for the `todo` folder through the cloud program you use.

## Settings & Notes

- In the `@Resources/MeasureDynamicTasks.lua` file, you can make the following settings.
  - WHITE_COLOR : Task text color
  - OPAQUE_WHITE_COLOR : Completed text color
  - TRASH_LIMIT : By default, the trash bin keeps the last 10 deleted tasks. You can change this limit.
- You can't delete the recurring tasks. It's not a bug it's a feature

## Next Version [1.0.2]

I plan to add the following features in future versions of the program. 

- Interface for color settings
- Code Optimization