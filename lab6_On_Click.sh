#!/bin/bash
# how the command should look
#sudo bash lab6_On_Click.sh 'groups' 'usernames' 'password_sets' 'second_groups' 'comment_login'
#sudo ./lab6_On_Click.sh 'groups' 'usernames' 'password_sets' 'second_groups' 'comment_login'

# NOTE must first make the lab6 dir and move the script and required files to work!

# create the directory at the start
# only if you can get git hub to attach itself in another direcotry
#mkdir /home/io-ascii/CIT173_Lab6

# create new groups
groupfile=$1
for i in $(cat $groupfile)
do
groupadd $i
done

# create new users
usersfile=$2
for i in $(cat $usersfile)
do
useradd $i -s /bin/bash -m
done

# change user password
# username:newpassword
userpw=$3
cat $userpw | sudo chpasswd

# add secondary groups to users
# group,list:username
mixfile=$4
while IFS=':' read group_list user_list; do
usermod -a -G $group_list $user_list
done < "$mixfile"

# change user's login comment name
# new_comment_name:username
login_names=$5

while IFS=':' read login_name user_list; do
usermod -c $login_name $user_list
done < "$login_names"

# cp passwd groups
cp /etc/passwd /home/io-ascii/CIT173_Lab6/
cp /etc/group /home/io-ascii/CIT173_Lab6/

# save history one
history > /home/io-ascii/CIT173_Lab6/ex1-command-history.txt

# all of execsie 2 wget, archive, etc
mkdir -p /var/StarWars/{finance,directing,creative}
wget https://github.com/RenoTechnologyAcademy/CIT173_Lab6_Files/archive/master.tar.gz -P /home/io-ascii/CIT173_Lab6/
tar -zxvf /home/io-ascii/CIT173_Lab6/master.tar.gz -C ~/CIT173_Lab6/

# sed files before moving them part 3 that had to be moved down
sed -i -e 's/40%/35%/g' /home/io-ascii/CIT173_lab6/CIT173_Lab6_Files-master/star-wars-budget.txt
sed -i -e 's|1/2%|5.5%|g;' /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/StarWars/star-wars-budget.txt
sed -i -e 's/73,750/8,112,500/g' /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/star-wars-budget.txt

sed -i -e 's/60%/50%/g' /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/star-wars-budget.txt
sed -i -e 's/88,500,000/73,750,000/g' /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/star-wars-budget.txt
sed -i "48i George Lucas (10%)                                       14,750,000" /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/star-wars-budget.txt

# copy all files over to var dir
cp /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/star-wars-budget.txt /var/StarWars/finance
cp /home/io-ascii/CIT173_Lab6/CIT173_Lab6_Files-master/star-wars-journal.txt /var/StarWars/directing
cp /home/io-ascii/CIT173_Lab6_Files-master/star-wars-script.txt /var/StarWars/creative

# change /var/starwars permissions
chmod 750 /var/StarWars/finance
chmod 775 /var/StarWars/directing
chmod 750 /var/StarWars/creative

chown gkurtz:producers /var/StarWars/finance
chown glucas:directors /var/StarWars/directing
chown glucas:actors /var/StarWars/creative

# save history two
history > /home/io-ascii/CIT173_Lab6/ex2-command-history.txt

# retar /var/StarWars
tar -cvf /home/io-ascii/CIT173_Lab6/StarWars.tar /var/StarWars

# auto github
git init
git remote add origin https://"your-github-username":"your-github-password"@github.com/Nuclearpr0/3test.git
git add -A
git commit -m "will it work now?"
#git commit -m "Lab 6 assignment"
git push origin master
