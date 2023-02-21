#!/bin/bash


# In order connect with ssh to phone:
# 1. start termux
# 2. run sshd
# 3. run: `ssh -p8022 u0_a465@192.168.0.102`

# In order to copy files to phone:
# 1. start termux
# 2. run sshd
# 3. run folowing lines

## TODO:
# 1. to make option with argument to update igor_docs or igor_data
# 2. the default will be updating the igor_docs

rsync -rvz -e 'ssh -p 8022' --progress	--delete \
	~/igorba/phone/igor_docs/			        \
	u0_a465@192.168.0.101:~/storage/shared/igor_docs/

# delete files on phone is they are not present in local folder
rsync -rvz -e 'ssh -p 8022' --progress --delete \
	~/igorba/phone/igor_data/music/				\
	u0_a465@192.168.0.101:~/storage/shared/igor_data/music/

# the flags -LK ensure folliwng links for directories
rsync -rvz -e 'ssh -p 8022' -LK --progress \
	~/igorba/phone/igor_data/books		\
	~/igorba/phone/igor_data/videos		\
	u0_a465@192.168.0.101:~/storage/shared/igor_data/

