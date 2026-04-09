def unique_string(s):
    res = ""
    for char in s:
        if char not in res: res += char
    return res
print(unique_string("programming"))
