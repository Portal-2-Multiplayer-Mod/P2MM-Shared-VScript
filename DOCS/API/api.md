# $$\text{\color{lightgreen}P2MM  SHARED  VSCRIPT  DOCS}$$
## 1. <span style="color: rgb(0 148 100)">**HOOKS**</span>

Hooks is a table of all **engine**>**vscript** or **vscript**>**vscript** hook classes.

### **USAGE :**

| TYPE | ARGS | DESCRIPTION |
| ----------- | ----------- | ----------- |
| **void** addCallback | ( **function** InputFunction(arrayArgs), **bool** replace = false, **str** name = null) | Takes a pre-defined function as an input and will call it when the hook is triggered. Your function recives an array with all of the hooks paramiters *array will be empty if the hook has no args, name will be the InputFunction name if set to null, replace will replace any current hooks with the current name* |
| **void** addHookCallback | ( **function** InputFunction(arrayArgs), **str** nameOfCallbackToHook, **bool** replace = false, **str** name = null) | Same as addCallback but will make your callback only run after the callback defined in nameOfCallbackToHook runs or if the callback with the name associated with nameOfCallbackToHook doesn't exist it will wait until it exists then postHook it on creation |
| **void** callCallbacks | ( **array** arrayArgs ) | Executes all hooked callbacks and gives them an array that act as args |

### **PREDEFINED HOOKS LIST :**

| NAME | DATA | CONDITION |
| ----------- | ----------- | ----------- |
| playerInit | [ int **player_index** ] | Runs when player <u>first</u> spawns in |
| postMapSpawn | [ ] | Runs when the  <u>**first player** first</u> spawns in |
| chatMessage | [ int **player_index**, str **message** ] | Runs when a player sends a chat message |

### **EXAMPLE** :

*code*:
```javascript
local myChatMessageCallback = function(array) {
    printl("\n===VSCRIPT MESSAGE CALLBACK===")
    printl("index: " + array[0].tostring())
    printl("message: " + array[1])
}
hooks.chatMessage.addCallback(myChatMessageCallback)
```
*output*:
```
player2: Hello World!

===VSCRIPT MESSAGE CALLBACK===
index: 2
message: Hello World!
```

### **CREATING CUSTOM HOOKS :**

To create your own hook use the GenericHook class and run callCallback in your functions. you can then hook that hook normally.

### **EXAMPLE** :
```javascript
hooks.myCustomHook <- GenericHook(); // Create a generic hook class
function myCustomHookLogic(someTest1, someData1, someData2) {
    if (!someTest1) hook.postMapLoad.callCallbacks([someData1, someData2])
}
```
