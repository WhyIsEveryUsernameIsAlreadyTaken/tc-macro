from ahk import AHK
import os
import base64
from tkinter import *
from tkinter import messagebox
from tkinter import ttk

ahk = AHK(version='v2')
cwd = os.getcwd()
icon = \
"""
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
DAD/AB4B//////8=
"""
icondata= base64.b64decode(icon)
tempFile= "icon.ico"
iconfile= open(tempFile,"wb")
iconfile.write(icondata)
iconfile.close()
textFile = cwd + '\copypastamsg.txt'
saveTextFile = cwd + '\savedcopypastamsg.txt'


########          ########
######## EDIT GUI ########
########          ########


def parseMsgs(file):
    with open(file, 'r') as f:
        msgsRaw = f.readlines()
    msgs = []
    for sub in msgsRaw:
        msgs.append(sub.replace("\n", ""))
    return msgs

startUp = True
selfInvoke = True
activeState = 1

def changeState(ent, var):
        if var.get() == 0:
            ent.configure(state=DISABLED)
        else:
            ent.configure(state=NORMAL)
def changeStateChk1(b, var1, var2, var3, c2, c3):
    global startUp, selfInvoke, activeState
    if var1.get() == 0:
        if var2.get() == 2:
            c2.invoke()
        if var3.get() == 3:
            c3.invoke()
        if not startUp and not selfInvoke:
            activeState = 0
            b.configure(state=DISABLED)
    else:
        if not startUp and not selfInvoke:    
            activeState = 1
            b.configure(state=NORMAL)
def changeStateChk2(b, var1, var2, var3, c1, c3):
    global startUp, selfInvoke, activeState
    if var2.get() == 0:
        if var3.get() == 3:
            c3.invoke()
        if not startUp and not selfInvoke:
            activeState = 1
            b.configure(state=NORMAL)
    else:
        if var1.get() == 0:
            c1.invoke()
        if not startUp and not selfInvoke:
            activeState = 2
            b.configure(state=NORMAL)

def changeStateChk3(b, var1, var2, var3, c1, c2):
    global startUp, selfInvoke, activeState
    if var3.get() == 3:
        if var1.get() == 0:
            c1.invoke()   
        if var2.get() == 0:
            c2.invoke()
        if not startUp and not selfInvoke:    
            activeState = 3
            b.configure(state=NORMAL)
    else:
        if not startUp and not selfInvoke:
            activeState = 2
            b.configure(state=NORMAL)

def EditMessages():
    editRoot = Tk()
    editRoot.withdraw()
    editRoot.title("Message Input")
    editRoot.wm_iconbitmap(tempFile)
    editRoot.resizable(width=False, height=False)
    editRoot.geometry("467x222")
    editFrame = ttk.Frame(editRoot, padding="3 3 12 12")
    editFrame.grid(column=0, row=0, sticky=('N', 'W', 'E', 'S'))
    editRoot.columnconfigure(0, weight=1)
    editRoot.rowconfigure(0, weight=1)
    ttk.Label(editFrame, text="Message 1:", font=('Arial', 8)).grid(column=1, row=0, sticky='W')
    ttk.Label(editFrame, text="Message 2:", font=('Arial', 8)).grid(column=1, row=2, sticky='W')
    ttk.Label(editFrame, text="Message 3:", font=('Arial', 8)).grid(column=1, row=4, sticky='W')

    msg1A = IntVar()
    msg1 = StringVar()
    msg2A = IntVar()
    msg2 = StringVar()
    msg3A = IntVar()
    msg3 = StringVar()

    msg1_entry = ttk.Entry(editFrame, width=50, textvariable=msg1, state=DISABLED)

    msg1_entry.grid(column=1, row=1, sticky='W')
    msg2_entry = ttk.Entry(editFrame, width=50, textvariable=msg2, state=DISABLED)

    msg2_entry.grid(column=1, row=3, sticky='W')
    msg3_entry = ttk.Entry(editFrame, width=50, textvariable=msg3, state=DISABLED)

    msg3_entry.grid(column=1, row=5, sticky='W')

    def SaveMessages():
        msg = [msg1.get(), msg2.get(), msg3.get()]
        msgA = [msg1A.get(), msg2A.get(), msg3A.get()]

        if msgA[1] == 0:
            with open(textFile, 'w') as f:
                f.write(f'{msg[0]}')
        elif msgA[1] == 2 and msgA[2] == 0:
            with open(textFile, 'w') as f:
                f.write(f'{msg[0]}\n{msg[1]}')
        elif msgA[2] == 3:
            with open(textFile, 'w') as f:
                f.write(f'{msg[0]}\n{msg[1]}\n{msg[2]}')
        elif msgA[0] == 0:
            with open(textFile, 'w') as f:
                pass
        with open(saveTextFile, 'w') as s:
            s.write(f'{msg[0]}\n{msg[1]}\n{msg[2]}')

    def continueApp():
        SaveMessages()
        editRoot.destroy()
        ScriptToggle()

    def quitAppE():
        SaveMessages()
        editRoot.destroy()
    contBtn = ttk.Button(editFrame, text="Save & Continue", command=continueApp, state=NORMAL)
    contBtn.grid(column=2, row=6, sticky='E')
    ttk.Button(editFrame, text="Save & Quit", command=quitAppE).grid(column=1, row=6, sticky='E')

    check1 = ttk.Checkbutton(editFrame, variable=msg1A, onvalue = 1, offvalue= 0)
    check1.grid(column=0, row=1, sticky='W')
    check2 = ttk.Checkbutton(editFrame, variable=msg2A, onvalue = 2, offvalue= 0)
    check2.grid(column=0, row=3, sticky='W')
    check3 = ttk.Checkbutton(editFrame, variable=msg3A, onvalue = 3, offvalue= 0)
    check3.grid(column=0, row=5, sticky='W')
    check1.configure(command=lambda btn=contBtn, e=msg1_entry, v1=msg1A, v2=msg2A, v3=msg3A, c2=check2, c3=check3: [changeState(e, v1), changeStateChk1(btn, v1, v2, v3, c2, c3)])
    check2.configure(command=lambda btn=contBtn, e=msg2_entry, v1=msg1A, v2=msg2A, v3=msg3A, c1=check1, c3=check3: [changeState(e, v2), changeStateChk2(btn, v1, v2, v3, c1, c3)])
    check3.configure(command=lambda btn=contBtn, e=msg3_entry, v1=msg1A, v2=msg2A, v3=msg3A, c1=check1, c2=check2: [changeState(e, v3), changeStateChk3(btn, v1, v2, v3, c1, c2)])

    global selfInvoke; selfInvoke = True
    check3.invoke()
    try:
        msgs = parseMsgs(saveTextFile)
    except:
        msgs = []
    try:
        msg1_entry.insert(1,msgs[0])
    except:
        msg1_entry.insert(1,"")
    try:
        msg2_entry.insert(1,msgs[1])
    except:
        msg2_entry.insert(1,"")
    try:
        msg3_entry.insert(1,msgs[2])
    except:
        msg3_entry.insert(1,"")

    check1.invoke()
    global startUp, activeState
    if activeState == 1:
        check1.invoke()
    elif activeState == 2:
        check2.invoke()
    elif activeState == 3:
        check3.invoke()
    selfInvoke = False
    startUp = False

    for child in editFrame.winfo_children():
        child.grid_configure(padx=5, pady=5)
    
    editRoot.eval('tk::PlaceWindow . center')
    editRoot.deiconify()
    editRoot.mainloop()


########            ########
######## TOGGLE GUI ########
########            ########


hasRan = False
lineit = 0

def ahkPasteLoop(r):
    global lineit, hasRan
    mlist = parseMsgs(textFile)
    mxl = len(mlist) - 1
    if hasRan:
        if not paused:
            r.after(100)
            ahk.key_wait("Control")
            ahk.key_wait("Alt")
            ahk.key_wait("Tab")
            ahk.key_wait("Space")
            ahk.key_wait("Enter")
            ahk.key_wait("Esc")
            ahk.key_wait("BS")
            ahk.key_wait("Shift")
            ahk.block_input('On')
            active_title = ahk.win_get_pid('A')
            mouse_coords = ahk.get_mouse_position('Screen')
            ahk.win_activate("ahk_exe Warframe.x64.exe")
            r.after(20)

            if lineit != mxl:
                ahk.send_raw(mlist[lineit])
                lineit += 1
            else:
                ahk.send_raw(mlist[lineit])
                lineit = 0
            r.after(50)
            ahk.send_input('{enter}')
            r.after(50)
            ahk.send_input('{t}')
            r.after(50)
            ahk.send_input('{Backspace}')
            r.after(50)
            ahk.win_activate(f"ahk_pid {active_title}")
            ahk.mouse_move(x=mouse_coords[0], y=mouse_coords[1])
            ahk.block_input('Off')
        r.after(120000, lambda: ahkPasteLoop(r))

def editApp(r):
    r.destroy()
    EditMessages()

def quitAppT(r):
    r.destroy()

def ScriptToggle():
    togRoot = Tk()
    togRoot.withdraw()
    togRoot.title("TCLazyPy")
    togRoot.wm_iconbitmap(tempFile)
    togRoot.resizable(width=False, height=False)
    togRoot.geometry("234x31")
    togFrame = ttk.Frame(togRoot, padding="3 3 12 12")
    togFrame.grid(column=0, row=0, sticky=('N', 'W', 'E', 'S'))
    togRoot.columnconfigure(0, weight=1)
    togRoot.rowconfigure(0, weight=1)

    def startApp(r, b):
        if not os.path.isfile(textFile) or os.path.getsize(textFile) == 0:
            messagebox.showinfo("TCLazyPy", "Storage File Empty/Not Found.\nPress OK to continue")
            r.destroy()
            EditMessages()
        else:
            b.configure(text="Stop", command=lambda root=r, button=b: stopApp(root, button))
            global hasRan
            if not hasRan:
                hasRan = True
                togRoot.after(250, lambda: ahkPasteLoop(togRoot))
            global paused
            paused = False

    def stopApp(r, b):
        b.configure(text="Start", command=lambda root=r, button=b: startApp(root, button))
        global hasRan
        hasRan = False
        global paused
        paused = True

    ttk.Button(togFrame, text="Edit", command=lambda: editApp(togRoot)).grid(column=0, row=0, sticky='W')
    toggleBtn = ttk.Button(togFrame, text="Start")
    toggleBtn.configure(command=lambda root=togRoot, b=toggleBtn: startApp(togRoot, b))
    toggleBtn.grid(column=1, row=0, sticky='W')
    ttk.Button(togFrame, text="Quit", command=lambda: quitAppT(togRoot)).grid(column=2, row=0, sticky='W')
    global paused; paused = True
    togRoot.eval('tk::PlaceWindow . center')
    togRoot.deiconify()
    togRoot.mainloop()


########            ########
######## MAIN START ########
########            ########


def script_start():
    if not os.path.isfile(textFile) or os.path.getsize(textFile) == 0:
        messagebox.showinfo("TCLazyPy", "Storage File Empty/Not Found.\nPress OK to continue")
        EditMessages()
    else:
       ScriptToggle()

script_start()
os.remove(tempFile)
