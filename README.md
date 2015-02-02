# ip-tester

It tests IPs for validity and vacancy.

# How to install.
##Prereqs

You will need Ruby. The most recent version will work.

###For Linux Users:
Use the package manager:
```
sudo apt install ruby-full

sudo yum install ruby
```

or rvm
```
rvm install <latest>/*; rvm use <latest>/*
```  
An asterisk means that the version would have to be known.

###For Windows
You can get Ruby using the one-click installer from http://rubyinstaller.org/

##Gems
After you install Ruby, next would be the gems. One can do this with Bundler.

```
gem install bundler && bundle install
```

#Install Done!

#Running
```
ruby ip_tester.rb
```
Just follow the gui prompts and test away!
