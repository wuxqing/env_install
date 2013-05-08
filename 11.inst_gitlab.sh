# create git user
adduser -r --shell /bin/bash --comment 'Git Version Control' --create-home --home-dir /home/git git

# switch to git
su git

# go to home dir
cd /home/git

#clone gitlab shel
git clone https://github.com/gitlabhq/gitlab-shell.git 
cd gitlab-shell

# switch to version v5.0
# git checkout -b v1.1.0

cp config.yml.example config.yml

#edit config and replace gitlab_url
# with something like "http:/domain.com"
vim config.yml

#do setup
./bin/install

###################################
# to git home dir
cd /home/git

# clone gitlab repo
git clone https://github.com/gitlabhq/gitlabhq.git gitlab 

#cd gitlab 

#checkout v5.0
#git checkout 5-0-stable

# copy the example gitlab config
cp config/gitlab.yml.example config/gitlab.yml 

# config gitlab.yml
vim config/gitlab.yml

chmod -R u+rwX log/
chmod -R u+rwX tmp/

# create dir for satellites
mkdir /home/git/gitlab-satellites

# create dir for pids and make sure gitlab can write to it
mkdir tmp/pids/
chmod -R u+rwX tmp/pids

# copy example unicorn config
cp config/unicorn.rb.example config/unicorn.rb
