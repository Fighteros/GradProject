#Graduation Project Repository 

---

Here all the Project Files including the source files and Diagrams 

Carefully read the following instruction to insure that everything will be going in the correct direction 


##Repo Tree 

Project Structure

```
├── backend
│   ├── config
│   ├── db.sqlite3
│   ├── manage.py
│   ├── Pipfile
│   └── Pipfile.lock
├── diagrams
│   ├── Context Diagram .pdf
│   ├── Context DiagramV3 .pdf
│   ├── ERD.eddx
│   ├── level 0 diagram .pdf
│   └── level 0 diagramv2.0.0 .pdf
├── mobile_app
│   ├── analysis_options.yaml
│   ├── android
│   ├── build
│   ├── ios
│   ├── lib
│   ├── mobile_app.iml
│   ├── pubspec.lock
│   ├── pubspec.yaml
│   ├── README.md
│   └── test
└── README .md
```



##Mobile App 
* to build the project for mobile app development
* ```
    $ git clone https://github.com/Fighteros/GradProject.git
    ```
* go to the cloned dir 
* ```
    $ cd GradProject
    ```
* then open the mobile app dir
* ``` 
    $ cd mobile_app
    ```
now you can use your favorite IDE and build or run the project 

##Backend 

* to build the project for backend app development
* ```
    $ git clone https://github.com/Fighteros/GradProject.git
    ```
* go to the cloned dir 
* ```
    $ cd GradProject
    ```
* then open the mobile app dir
* ``` 
    $ cd backend
    ```
now you can use your favorite IDE and build or run the project using the following commands 

```
$ python mange.py runserver
```
#Important Git Commands

this section is supposed to be project **team mates** only

these are important git commands we will use through developing the whole project 

**nobody pushes to master branch please!!**

1.  git clone < link > clones the repo 
2.  git add < path > adds a file or dir to your stashes so that u commit and push to remote repo 
3.  git commit -m "< comment >" comment your added files so that we can easily understand the files modified or add are modified or add for what reason, and to make it easy for us if at some point we wanted to revert back some steps 
4.  git branch -M < branch name > creates a new branch from where we are standing in the project 
5.  git pull origin < branch > get update from remote branch to local device 
6.  git push origin < branch > pushed your committed files to the remote repo (branch)

---
All Rights Reserved,  Copyright ©2022 xHealth

made with ❤️ by Ahmed M. Abd ElGhany