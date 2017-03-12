import time
start_time = time.time()
import hashlib
import re
inp = "ahsbgdzn"

lastTriple = -1
index = 0
triples = dict()
keys = []
while True:
    code = inp + str(index)
    hash = code
    for i in range (0,2017):
        md5 = hashlib.md5()
        hash = md5.update(hash)
        hash = md5.hexdigest()
    #print hash
    # "([a-z\\d])\\1\\1"
    m = re.search("([a-z\\d])\\1\\1",hash)
    #print m
    if m is not None:
        lastTriple = index
        key = m.group(0)[0]
        if not triples.has_key(key):
            l = [index]
            triples[key] = l
        else:
            triples[key].append(index)

        m = re.search("([a-z\\d])\\1\\1\\1\\1",hash)
        if m is not None:
            key5 = m.group(0)[0]
            #print hash
            if triples.has_key(key5):
                for i in triples[key]:
                    ix = int(i)
                    if ix + 1000 > index and ix is not index:
                        keys.append(ix)
                        #print "found from " + str(ix)
                        if len(keys) >= 64 and index > lastTriple + 1000:
                            break
    index += 1

    if index > 50000:
        break
keys.sort()
print keys[63]
print "took: " + str(time.time() - start_time)
