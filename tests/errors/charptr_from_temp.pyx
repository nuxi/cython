# mode: error
# tag: werror, charptr, conversion, temp, py_unicode_strings

cdef bytes c_s = b"abc"
s = b"abc"

cdef char* cptr

# constant => ok
cptr = b"xyz"

# global cdef variable => ok
cptr = c_s

# pyglobal => warning
cptr = s

# temp => error
cptr = s + b"cba"

# indexing => error
cptr = s[0]
cdef char* x = <char*>s[0]

# slicing => error
cptr = s[:2]


cdef unicode  c_u = u"abc"
u = u"abc"

cdef Py_UNICODE* cuptr

# constant => ok
cuptr = u"xyz"

# global cdef variable => ok
cuptr = c_u

# pyglobal => warning
cuptr = u

# temp => error
cuptr = u + u"cba"


_ERRORS = """
16:8: Obtaining 'char *' from externally modifiable global Python value
19:9: Storing unsafe C derivative of temporary Python reference
22:8: Storing unsafe C derivative of temporary Python reference
23:5: Storing unsafe C derivative of temporary Python reference
26:8: Storing unsafe C derivative of temporary Python reference
41:9: Obtaining 'Py_UNICODE *' from externally modifiable global Python value
44:10: Storing unsafe C derivative of temporary Python reference
"""
