class MapCfg:
	def __init__(self,field,bytes):
		self.field=field
		self.bytes=bytes

class Test:
    def __init__(self, len, buf):
        print('コンストラクタが呼ばれました')
        print(buf)
        self.len=len
        self.head=buf[:6]
        self.buf=buf[6:14]
        self.tail=buf[14:]
        self.dt=()
        self.dt2=()
        self.parse()

    def __del__(self):
        print('デストラクタが呼ばれました')
    
    def prt(self):
    	print('head:'+self.head)
    	print('dt1:', self.dt)
    	print('dt2:', self.dt2)
    	print('tail:'+self.tail)
    
    def parse(self):
    	self.dt+= (self.buf[:2],)
    	self.dt+= (self.buf[2:4],)
    	self.dt+= (self.buf[4:6],)
    	self.dt+= (self.buf[6:],)
    
    def prs(self,map):
    	tbuf=self.buf
    	for m in map:
    		#print(tbuf)
    		self.dt2+= (tbuf[:m.bytes],)
    		tbuf=tbuf[m.bytes:]

map=(MapCfg('u1_dt1',1),MapCfg('u1_dt2',1),MapCfg('u2_dt3',2),MapCfg('u4_dt4',4))
test=Test(10,'01023154876045723590')
test.prt()
test.prs(map)
test.prt()