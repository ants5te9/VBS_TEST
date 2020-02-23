import re

print("hello")
saddr=''
size=0
odata=bytearray()

def byte2int(cha1,cha2):
	#num=int(cha1,16)*16+int(cha2,16)
	num=int(cha1+cha2,16)
	return num
	
def parseLn(lineStr):
	global saddr
	global size
	if 'S'==lineStr[0]:
		type=lineStr[1]
		#print('; ',type)
		if '1'==type:
			size=byte2int(lineStr[2],lineStr[3])
			saddr=lineStr[4:8]
			sout=re.sub(r'S\d[0-9a-fA-F]{6}([0-9a-fA-F]+)[0-9a-fA-F]{2}$',r'\1',lineStr)
		elif '3'==type:
			size=byte2int(lineStr[2],lineStr[3])
			saddr=lineStr[4:12]
			sout=re.sub(r'S\d[0-9a-fA-F]{10}([0-9a-fA-F]+)[0-9a-fA-F]{2}$',r'\1',lineStr)
		else:
			sout=''
	else:
		sout=''
		
	return sout

def calcSum(sz,dstr):
	v = [dstr[i: i+2] for i in range(0, len(dstr), 2)]
	sum=sz
	for tgt in v:
		sum+=byte2int(tgt[0],tgt[1])
	return hex(255-(sum%256))

def str2bytearray(dstr):
	global odata
	v = [dstr[i: i+2] for i in range(0, len(dstr), 2)]
	for tgt in v:
		odata.append(byte2int(tgt[0],tgt[1]))

#with open('s1sample.txt') as f:
with open('s3sample.txt') as f:
	for read_data in f:
		saddr=''
		size=0
		str=read_data.replace('\n', '')
		print('>',str)
		tmp=parseLn(str)
		sm=calcSum(size,saddr+tmp)
		if size>0:
			print(size,'#',saddr,'#',tmp,'#',sm)
			str2bytearray(tmp)
 
 
print('out')
outf=open('test.bin','wb')
outf.write(odata)
outf.close