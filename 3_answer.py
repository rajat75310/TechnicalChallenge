def ObjVal(dict1, key):
    keys = key.split('/')
    obj = dict1 
    
    for k in keys:
        if k in obj:
            obj = obj[k]            
            print(obj,": " ,k)
            print("----------------------------") 
        else:
            return None
    
    return obj


print()

# Example 1
dict1 = {"this": {"is": {"new": "example"}}}
key1 = "this/is/new"
result1 = ObjVal(dict1, key1)
print("Example 1 Result:", result1) 

print()
# Example 2
dict2 = {"x": {"y": {"z": "a"}}}
key2 = "x/y/z"
result2 = ObjVal(dict2, key2)
print("Example 2 Result:", result2) 