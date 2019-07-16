import os

iverilog = "iverilog"
A = " -DA="
B = " -DB="
C = " -DC="

output="outputFiles/"
Path_ADD = " CLA/carryLookAhead.v"
Path_MUL = " WM/wallaceMultiplier.v"
Path_FADD = " FPA/floatingPointAdder.v"
Path_FMUL = " FPM/multiplier.v"
Path_AND = " Bool/and.v"
Path_OR = " Bool/or.v"
Path_XOR = " Bool/xor.v"



def call_verilog_function(op,a,b,index):

    if(op=="ADD"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + Path_ADD
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a+b)
    if(op=="SUB"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B +"-"+ str(b) + Path_ADD
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a-b)
    if(op=="MUL"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + Path_MUL
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a*b)
    if(op=="FADD"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + C + "0 " + Path_FADD
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a+b)
    if(op=="FSUB"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + C + "1 " + Path_FADD
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a-b)
    if(op=="FMUL"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + Path_MUL
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a*b)
    if(op=="AND"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + Path_AND
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a&b)
    if(op=="OR"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + Path_OR
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a|b)
    if(op=="XOR"):
        Sys1 = iverilog + " -o output"+ A + str(a) + B + str(b) + Path_XOR
        os.system(Sys1)
        os.system("./output > "+output+str(index)+".txt")
        file=open(output+str(index)+".txt","r")
        print (file.read())
        file.close()
        return(a^b)
