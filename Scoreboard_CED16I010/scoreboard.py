#Steps
#Read from a text file the set of instructions or take from command line. Make a class for this.
#Instruction parameters op, dest,s1,s2, 4 time values- issue, read, exec, write result
#Above will give instruction status
# Function unit status- class, parameters - name, busy, op,fi,fj,fk,qj(func unit for j),qk(func unit for k), rj,rk (yes/no)
# 7 functions - cla, wm, fpa, fpm, ld, str, boolean (and, or, xor, nor), 6 func units
# Register result status - array for the registers- store the functional unit which will has that as destination
import run

global inst
global funcUnits
global current
global issueDone
global n
global registers


class Instruction():
	def __init__(self, op, dest, s1, s2):
		self.op =  op
		self.dest = dest
		self.s1 = s1
		self.s2 = s2
		self.issueTime=self.readTime=self.execTime=self.writeTime=0
		self.delay=self.getdelay()
	def getdelay(self): #assume 190ps=19cc
		switch = {
		"LDR": 1,
		"STR": 1,
		"ADD": 5, #22
		"SUB": 5, #22
		"MUL": 10, #58
		"FADD": 6, #144
		"FMUL": 6, #107
		"FSUB": 6, #144
		"AND": 1,
		"OR": 1,
		"NOT": 1
		}
		return switch[self.op]


class FunctionalUnit():
	def __init__(self,name):
		self.name = name
		self.busy = "no"
		self.op = self.fi = self.fj = self.fk = self.qj = self.qk = self.rj = self.rk = ""
		self.ins=-1



def get_operation(op):
	operations = {
	"LDR": 0,
	"STR": 0,
	"ADD": 1,
	"SUB": 1,
	"MUL": 2,
	"FADD": 3,
	"FMUL": 4,
	"FSUB": 3,
	"AND": 5,
	"OR": 5,
	"NOT": 5
	}
	return operations.get(op)

def get_function(op):
	functions={
		"LDR": "Integer",
		"STR": "Integer",
		"ADD": "Add",
		"SUB": "Add",
		"MUL": "Mult",
		"FADD": "FPA",
		"FMUL": "FPM",
		"FSUB": "FPA",
		"AND": "Bool",
		"OR": "Bool",
		"NOT": "Bool"
	}
	return functions.get(op)

def check(reg,reqUnit):
	for i in range(6):
		if(i!=reqUnit and reg==funcUnits[i].fi):
			return funcUnits[i].name
	return "nil"


def sets1(reqUnit):
	if(inst[current].s1[0]=="R"):
		funcUnits[reqUnit].fj=inst[current].s1
		fu=check(inst[current].s1,reqUnit)
		print('\ns1: fu: '+fu)
		if(fu!="nil"):
			funcUnits[reqUnit].qj=fu
			funcUnits[reqUnit].rj="no"
		else:
			funcUnits[reqUnit].qj=""
			funcUnits[reqUnit].rj="yes"
	else:
		funcUnits[reqUnit].fj=""
		funcUnits[reqUnit].qj=""
		funcUnits[reqUnit].rj=""

def sets2(reqUnit):
	funcUnits[reqUnit].fk=inst[current].s2
	fu=check(inst[current].s2,reqUnit)
	print('\ns2: fu: '+fu)
	if(fu!="nil"):
		funcUnits[reqUnit].qk=fu
		funcUnits[reqUnit].rk="no"
	else:
		print('\nadded')
		funcUnits[reqUnit].qk=""
		funcUnits[reqUnit].rk="yes"



def issue():
	global current
	global issueDone
	reqUnit=get_operation(inst[current].op)
	#check for waw hazard and don't issue if found
	waw=0;
	for i in funcUnits:
		if(i.fi==inst[current].dest):
			waw=1;
	if(funcUnits[reqUnit].busy=="no" and waw==0):
		inst[current].issueTime = clk
		funcUnits[reqUnit].ins=current
		funcUnits[reqUnit].busy="yes"
		funcUnits[reqUnit].op=inst[current].op
		funcUnits[reqUnit].fi=inst[current].dest
		sets1(reqUnit)
		sets2(reqUnit)
		current=(current+1)%n

		if(current==0):
			issueDone=1
		#print('\nCurrent:'+str(current)+' IssueDone:'+str(issueDone))



def read():
	for i in range(6):
		instNumber=funcUnits[i].ins
		if(instNumber!=-1 and inst[instNumber].issueTime!=clk and inst[instNumber].readTime==0 and funcUnits[i].rk=="yes" and funcUnits[i].rj!="no" ):
			 inst[funcUnits[i].ins].readTime=clk


def get_regvalue(reg):
	global registers
	index=int(reg[1:])
	return int(registers[index])

def set_regvalue(dest,val):
	global registers
	registers[dest]=val

def exec():
	global registers
	for i in range(6):
		instNumber=funcUnits[i].ins
		if(instNumber!=-1 and inst[instNumber].readTime!=clk and inst[instNumber].readTime!=0 and inst[instNumber].execTime==0):
			if(inst[instNumber].readTime+inst[instNumber].delay==clk):
				op=inst[instNumber].op
				dest=inst[instNumber].dest
				s1=inst[instNumber].s1
				s2=inst[instNumber].s2
				if(op=="LDR"): #LDR R1,#8,R2 -> register[1]=register[2+2]
					offset=int(int(s1[1:])/4)
					srcIndex=offset+int(s2[1:])
					val=registers[srcIndex]
					destIndex=int(dest[1:])
				elif(op=="STR"):
					val=get_regvalue(dest)
					offset=int(int(s1[1:])/4)
					destIndex=offset+int(s2[1:])
				else:
					a=get_regvalue(s1)
					b=get_regvalue(s2)
					destIndex=int(dest[1:])
					val=run.call_verilog_function(op,a,b,instNumber)
				set_regvalue(destIndex,val)
				inst[instNumber].execTime=clk


def commit():
	for i in range(6):
		instNumber=funcUnits[i].ins
		if(instNumber!=-1 and inst[instNumber].execTime!=clk
		    and inst[instNumber].execTime!=0 and inst[instNumber].writeTime==0):
			war=0
			for j in range(instNumber):
				if((inst[j].readTime==0 or inst[j].readTime==clk) and
				(inst[instNumber].dest==inst[j].s1 or inst[instNumber].dest==inst[j].s2)): #found war hazard, do nothing
					war=1
			if(war==0):
				inst[instNumber].writeTime=clk
				for k in range(6):
					if (k!=i and funcUnits[i].fi==funcUnits[k].fj):
						funcUnits[k].rj="yes"
						funcUnits[k].qj=""
					if (k!=i and funcUnits[i].fi==funcUnits[k].fk):
						funcUnits[k].rk="yes"
						funcUnits[k].qk=""
				funcUnits[i].busy="no"
				funcUnits[i].op=""
				funcUnits[i].fi=""
				funcUnits[i].fj=""
				funcUnits[i].fk=""
				funcUnits[i].rj=""
				funcUnits[i].rk=""
				funcUnits[i].ins=-1



def printScoreboard():
	print("\nInstruction Status:")
	print("\nSno\t|Ins\t|i\tj\t|k\t|I\t|R\t|E\t|W\n")
	for i in range(n):
		print(str(i+1)+'\t|'+inst[i].op+'\t|'+ inst[i].dest+'\t|'+inst[i].s1+'\t|'+inst[i].s2+'\t|'+str(inst[i].issueTime)+'\t|'+str(inst[i].readTime)+'\t|'+str(inst[i].execTime)+'\t|'+str(inst[i].writeTime))

def printFunctionalUnit():
	print("\nFunctional Unit status:")
	print("\nName\t|Busy\t|op\t|fi\t|fj\t|fk\t|qj\t|qk\t|rj\t|rk\t|ins")
	for i in range(6):
		print(funcUnits[i].name+'\t|'+funcUnits[i].busy+'\t|'+funcUnits[i].op+'\t|'+funcUnits[i].fi+'\t|'+funcUnits[i].fj+'\t|'+funcUnits[i].fk+'\t|'+funcUnits[i].qj+'\t|'+funcUnits[i].qk+'\t|'+funcUnits[i].rj+'\t|'+funcUnits[i].rk+'\t|'+str(funcUnits[i].ins))

def main():
	global funcUnits
	global inst
	global n
	global current
	global issueDone
	global clk
	global registers
	current = 0
	issueDone=0
	funcUnits=[]
	clk=1
	registers=[1,2,3,4,5,6,7,8,9,10]
	inst=[]
	funcUnits.append(FunctionalUnit("Integer")) #Ldr/str
	funcUnits.append(FunctionalUnit("Add"))
	funcUnits.append(FunctionalUnit("Mult"))
	funcUnits.append(FunctionalUnit("FPA"))
	funcUnits.append(FunctionalUnit("FPM"))
	funcUnits.append(FunctionalUnit("Bool"))
	"""
	n=int(input("Enter the number of instructions"))
	for i in range(n):
		[op,regSet]=input().split()
		[dest,s1,s2]=regSet.split(",")
		inst.append(Instruction(op,dest,s1,s2))
	"""
	f = open("instructions.txt", "r")
	setOfInstructions = [line.strip() for line in f]
	n=len(setOfInstructions)
	f.close()
	for i in setOfInstructions:
		[op,regSet]=i.split()
		[dest,s1,s2]=regSet.split(",")
		inst.append(Instruction(op,dest,s1,s2))

	notDone=0
	while(notDone==0):
		#print('\nissueMain: '+str(issueDone))
		if(issueDone==0):
			issue()
		read()
		exec()
		commit()
		print("\nClk:"+str(clk))
		printScoreboard()
		printFunctionalUnit()
		notDone=1
		for i in range(n):
			if(inst[i].writeTime==0):
				notDone=0
				break
		clk=clk+1


if __name__=='__main__':
	main()
