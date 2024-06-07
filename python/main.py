from tkinter import *

root=Tk()

root.title("myLinuxBase")

root.resizable(1,1)

##root.iconbitmap("icono.ico")

#root.geometry("700x400")

root.config(bg="#555555")

## Creacion del frame
miFrame = Frame()

## Enpaquetarlo/Instrducir a root
#miFrame.pack(fill="both", expand="1")
miFrame.pack()

## Configuracion
miFrame.config(bg="red")
miFrame.config(width="500",height="500")

miFrame.config(bd="35")
miFrame.config(relief="groove")

miFrame.config(cursor="hand2")
#miFrame.config(cursor="pirate")



#import subprocess

#subprocess.call(['sudo', 'apt', 'install', 'geany'])

#subprocess.call(['sudo', 'apt', 'install', 'nano'])



root.mainloop()
