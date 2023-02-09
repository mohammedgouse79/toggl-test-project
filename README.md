## Toggl Track Apple Engineer Test Project
This repository contains the code for the Apple Engineer Home Assignment for Toggl Track. The project is an iOS or macOS application that allows users to track and manage their time.

## Instructions
You are required to implement an iOS or macOS application. 

### Requirements:
- User can start and stop tracking time
- Time entry can have a description
- User can see a list of previously tracked time entries
- User can remove time entries
- Time entries are persisted between app launches
- Written in Swift
- You can choose a UI framework: UIKit/AppKit or SwiftUI
- There are no requirements on what persistence method to use

### Evaluation Criteria

We’re looking for code that is:
- Clean
- Well structured
- Easy to extend
- Easy to modify
- Easy to understand for others
- Unit tested

While a polished solution is not expected for this assignment, bonus points will be given for using The Composable Architecture or any other REDUX-like architecture.

### Steps for Running the App in the Simulator: ###
1. Clone the repository: Download it as a zip file or use Git.
2. Open the repository in Xcode.
3. Select a simulator (iPhone or iPad) as the target device.
4. Click the "Run" button in the Xcode toolbar to build the project and launch it in the simulator.

Note: To run the app on an actual device, you'll need to manage the signing and capabilities for the project.

### Features: ###
- Create new activities using the "Create New Activity" button.
- All activities are persisted using Core Data.
- A summary of existing activities is displayed on an "Info Card".
- Delete activities using the trash icon in the activity detail view. Access the detail view by clicking the respective activity.
- Edit the activity note by clicking on it in the activity detail view. Remember to click "Return" on the keyboard to save changes. Changes will not be persisted if you tap away from the text field.
- Each activity card displays the date and time when the timer was created or the latest resumed instance.
- The view for iPads and iPhones is slightly different for the "Info Card".
