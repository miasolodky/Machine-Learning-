import os
import sys
import shutil
import fnmatch
#This program reads the files and saves them as .txt files in a new folder.
path= os.path.dirname(os.path.realpath(__file__))
files_list=os.listdir(path)
files_list= files_list[2:-3]

# open and read each file
for filename in files_list:
    with open(filename) as f:
        content = f.read()
    print(content)
    # create a new .txt file amd insert the content. add 's' or 'n' as prefix to indicate spam or non-spam.
    new_file_name=('s'+filename + "." + "txt")
    new=open(new_file_name,'w')
    new.write(content)

# moving all the new files to a subfolder
dir1 = os.path.dirname(os.path.realpath(__file__))
dir2 = os.path.join(dir1, 'spamtxt')
for entry in os.listdir(dir1):
    if (os.path.isfile(os.path.join(dir1, entry)) and (fnmatch.fnmatch(entry, '*.txt'))):
        shutil.move(os.path.join(dir1, entry), dir2)
