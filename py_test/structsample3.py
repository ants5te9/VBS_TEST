#!/usr/bin/env python
# -*- coding: utf-8 -*-

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
        self.buf=buf
        self.header=''
        self.footer=''
        self.data=''
        self.crc=''

    def __del__(self):
        print('デストラクタが呼ばれました')
    
    def prt8(self,s):
    	print([s[i: i+8] for i in range(0, len(s), 8)])
    
    def prt(self):
    	print('header:', self.header)
    	print('data:')
    	self.prt8(self.data)
    	print('crc:', self.crc)
    	print('footer:', self.footer)
    
    def prs(self,names,bytes):
    	tbuf=self.buf
    	i=0
    	for m in bytes:
    		#print(tbuf)
    		if i==0:
    			self.header= tbuf[:m]
    		elif i==1:
    			self.data= tbuf[:m]
    		elif i==2:
    			self.crc= tbuf[:m]
    		else:
    			self.footer= tbuf[:m]
    		tbuf=tbuf[m:]
    		i+=1
    
    def prs_h(self):
    	ids=self.header[:3]
    	idxs=self.header[2:5]
    	srls=self.header[5:]
    	id=(int(ids,16)>>1)
    	print('ID: ', str(id))
    	index=(int(idxs,16))&0x1FF
    	print('Index: ', str(index))
    	print('Serial: ', str(int(srls,16)))
    
    def chk_h(self):
    	chk=int(self.header,16)^int(self.footer,16)
    	if (chk)==0xFFFFFFFF:
    		print('ok')
    	else:
    		print('ng', hex(chk))


# 構造化配列を作成
data = np.zeros(4, dtype = dtype)
# 構造化配列へのデータの書き込み
#data["field"] = ["u1_dt1", "u1_dt2", "u2_dt3", "u4_dt4"]
#data["bytes"] = [1, 1, 2, 4]
#             'field',  'bytes',  'data'
data[0]=('header', 8, 0)
data[1]=('data', 108, 0)
data[2]=('crc', 4, 0)
data[3]=('footer', 8, 0)

test=Test(64,
'01323154876045723590010231548760'
'45723590010231548760457235900102'
'31548760457235900102315487604572'
'359001023154010231548760FECDCEAB')
test.prs(data["field"],data["bytes"])
test.prt()
test.prs_h()
test.chk_h()