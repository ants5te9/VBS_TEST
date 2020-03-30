size = 1*1024
offset = 1*1024
mem=[255 for x in range(0, size)]


def parse(line):
    if line[0] != 'S':
        return -1, []
    try:
        nibbles = [int(ch, 16) for ch in line[1:]]
    except ValueError:
        return -1, []
    type = nibbles[0]
    bytes = [int(nibbles[i*2+1] * 16 + nibbles[i*2+2])
             for i in range(0, int(len(nibbles) / 2))
            ]
    if bytes[0] != len(bytes) - 1:
        return -1, []
    csum = sum(bytes) & 255
    #if csum != 255:
    #   return -1, []
    return type, bytes[1:-1]

def type0(payload):
	print(payload[2:])

def prtln(buf,addr):
	print('ad:'+str(addr)+'> '+hex(buf[addr])+' '+hex(buf[addr+1])+' '+hex(buf[addr+2])+' '+hex(buf[addr+3]))
	return

def write(address, data):
	global mem
	#address -= offset
	for x in data:
		#print "WRITE %02X to %08X" % (x, address)
		if address < 0:
			return False
		if address >= size:
			return False
		mem[address] = x
		address = address + 1
	
	#prtln(mem,address-16)
	return True

def type1(payload):
    address = payload[0] * 256 + payload[1]
    return write(address, payload[2:])
    
def type2(payload):
    address = (payload[0] * 256 + payload[1]) * 256 + payload[2]
    return write(address, payload[3:])

def type3(payload):
    address = ((payload[0] * 256 + payload[1]) * 256 + payload[2]) * 256 + payload[3]
    #print('type3: '+hex(address))
    return write(address, payload[4:])

def type5(payload):
    return True

def type7(payload):
    address = ((payload[0] * 256 + payload[1]) * 256 + payload[2]) * 256 + payload[3]
    #print ("Entry Point=%08X" % address)
    return True

def type8(payload):
    address = (payload[0] * 256 + payload[1]) * 256 + payload[2]
    #print "Entry Point=%06X" % address
    return True

def type9(payload):
    address = payload[0] * 256 + payload[1]
    #print "Entry Point=%04X" % address
    return True

def loadLine(line):
    if not line:
        return True
    (type, payload) = parse(line)
    if type == 0:
        return type0(payload)
    elif type == 1:
        return type1(payload)
    elif type == 2:
        return type2(payload)
    elif type == 3:
        return type3(payload)
    elif type == 5:
        return type5(payload)
    elif type == 7:
        return type7(payload)
    elif type == 8:
        return type8(payload)
    elif type == 9:
        return type9(payload)
    else:
        print ("INVALID: %s\n" % line)
        return False

def loadFile(fileName):
    #hhmem=[255 for x in range(0, size)]
    f = open(fileName, 'r')
    for line in f.readlines():
        loadLine(line.strip('\n'))
    f.close()

def saveFile(fileName):
	global mem
	f = open(fileName, 'wb')
	for ch in mem:
		f.write(bytes([ch]))
	f.close()

#####'main
loadFile('s3sample.txt')
saveFile('s3.bin')
