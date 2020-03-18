import numpy as np

# 複合データ型の定義
# U12:最大長12のUnicode文字列
# i1:1バイト整数(=np.int8)
# u4:(=np.uint32)
dtype = [("field", "U12"), ("bytes", "i1"), ("data", "u4")]

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
    
    def prs(self,bytes):
    	tbuf=self.buf
    	for m in bytes:
    		#print(tbuf)
    		self.dt2+= (tbuf[:m],)
    		tbuf=tbuf[m:]


# 構造化配列を作成
data = np.zeros(4, dtype = dtype)
# 構造化配列へのデータの書き込み
#data["field"] = ["u1_dt1", "u1_dt2", "u2_dt3", "u4_dt4"]
#data["bytes"] = [1, 1, 2, 4]
#             'field',  'bytes',  'data'
data[0]=('u1_dt1', 1, 0)
data[1]=('u1_dt2', 1, 0)
data[2]=('u2_dt3', 2, 0)
data[3]=('u4_dt4', 4, 0)

test=Test(10,'01023154876045723590')
test.prt()
test.prs(data["bytes"])
test.prt()