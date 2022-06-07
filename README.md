# ✔️ Rainmeter To-Do

While searching for a Rainmeter todo skin for my personal needs, I found a skin named [rainmeter-todo-list](https://github.com/Pernickety/rainmeter-todo-list). This project has been developed based on [rainmeter-todo-list](https://github.com/Pernickety/rainmeter-todo-list).  I developed this code with various performance fixes and features (delete, order, trash etc...).

## 🎞️ Preview

You can watch the YouTube video by clicking the following image.

[![Rainmeter To-Do](https://img.youtube.com/vi/OSRlsK0ABI4/0.jpg)](https://www.youtube.com/watch?v=OSRlsK0ABI4 "Rainmeter To-Do")


## 📝 Features

- Add, Delete and Reorder Tasks
- Mark the task as recurring and important
- Recover deleted tasks from the trash bin
- Highly customizable

## Install

###### Via Installer

+ Go to the [release](https://github.com/alperenozlu/rainmeter-todo/releases) page and download the latest .rmskin file.
+ Install skin with a double click to the downloaded file.
+ [Activate the skin](#activate-skin)

###### Via Source Code

- Download this source code and place the entire `rainmeter-todo` folder in the location of your Rainmeter skin. Generally it is look like `C:\Users\<USERNAME>\Documents\Rainmeter\Skins\`
- [Activate the skin](#activate-skin)

##### Activate Skin

- Activate `rainmeter-todo` skin
  - You can do this by right-clicking on an already active skin to bring up the Rainmeter menu
  - Navigate to `Rainmeter > Skins > rainmeter-todo > todo > todo.ini`
    - If you do not see `rainmeter-todo` in the skin selection, try navigating to `Rainmeter > Refresh all`

## 🖋️ Customize

1. Go to `Rainmeter > Skins > rainmeter-todo > todo > todo.ini` and click `Edit` button.
2. Edit the values you want to change. You can find information about which fields you can change in the table below.
3. After saving the file, you can see the changes by clicking the refresh button twice.

| Name                	| Description                                      	| Possible Values   	| Default Value   	|
|---------------------	|--------------------------------------------------	|-------------------	|-----------------	|
| SolidColor          	| Background color of the skin                     	| Color Code        	| 0,0,0,150       	|
| SkinWidth           	| Width of the skin                                	| Number            	| 600             	|
| SHOW_RECURRING      	| Show/Hide Recurring column                       	| 0: False, 1: True 	| 1               	|
| SHOW_IMPORTANT      	| Show/Hide Important column                       	| 0: False, 1: True 	| 1               	|
| ACTIVE_TASK_COLOR   	| Color of the active task                         	| Color Code        	| FFFFFF          	|
| COMLETED_TASK_COLOR 	| Color of the completed task                      	| Color Code        	| 255,255,255,170 	|
| TRASH_LIMIT         	| Maximum number of deleted tasks to keep in trash 	| Number            	| 10              	|
| BUTTON_SIZE         	| Font size of icon buttons                        	| Number (px)       	| 18              	|
| BUTTON_COLOR        	| Font color of icon buttons                       	| Color Code        	| FEFEFE          	|
| FONT_FACE           	| Font type to be used                             	| Inter or Roboto   	| Inter           	|
| FONT_SIZE           	| Font size of texts                               	| Number (px)       	| 15              	|


## 🤖 Technical Details & Notes

### 🗒️ Tasks and Editing Tasks Manually

In an emergency, you may want to edit the task file manually. For this, you must first know the structure of the task file.

- In the first line of the `tasks.txt` file, there is `task|x|x` information. This line should never be deleted. The program accepts this line as the title.

- Each line in the file is a task.

- Task's information is separated by  `|` character. The attribute belonging to a column is shown in the table below.  

| 1         | 2            | 3            | 4            |
| --------- | ------------ | ------------ | ------------ |
| Task Text | Is Completed | Is Recurring | Is Important |

For example, a completed and important task would look like this `task title|x||x` 
    
If it's just a completed task, it's look like `task title|x||` 

### ☁️ Sync With Multiple Device

Added and deleted tasks are stored on a file basis. Since there is no database connection, you can use programs such as Google Drive, Dropbox, and OneDrive to synchronize between multiple devices.

- Go to `rainmeter-todo` folder in your Rainmeter skins location
- Start the sync process for the `todo` folder through the cloud program you use.

### Notes

- You can contact me on GitHub or Deviantart for your ideas and comments.
- Recurring tasks cannot be deleted. It's a feature I added to prevent the content of this recurring task from being deleted. 

### 😔 Known Bugs and Issues
- Encoding problems.
- If Windows commands are entered as a task, the relevant command is triggered.
- If the task contains the `'` character, it's not saved.

PS: I continue to work on the errors I mentioned above, not in a short time, but I will try to solve them one day 😂. 