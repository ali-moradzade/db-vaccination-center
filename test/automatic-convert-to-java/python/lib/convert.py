import re


def extract_method_name_arguments(contents):
    result = []
    pattern = re.compile(r'create procedure\s+(\w+)\(\n(.*?)^\)$', re.IGNORECASE | re.DOTALL | re.MULTILINE)
    for method_name, args in pattern.findall(contents):
        arguments = re.findall(r'^\s+(\w+)\s.*$', args, re.MULTILINE)
        result.append((method_name, arguments))

    return result


contents = ''
with open('../../nurse.sql', 'r') as f:
    contents = f.read()

print("_" * 50)
print(contents, end='')
print("_" * 50)

for method_name, arguments in extract_method_name_arguments(contents):
    print(method_name)
    print(arguments)
    print()
