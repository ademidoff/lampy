# A simple LAMP Stack

*This is a very basic repository for php devs*


Packages
--------

    Ubuntu 14.04 (base image)
    Apache 2.5.7
    Mysql 5.5.43
    PHP 5.5.9

Installation
------------
docker pull atymchuk/lampy

Running a container from this image
-----------------------------------
`docker run --name lampy -d -p 80:80 atymchuk/lampy`

The default timezone is `Etc/UTC`. Should you need to set a different timezone, you have to pass a TIMEZONE environment variable, i.e:

`docker run --name lampy -d -p 80:80 -e TIMEZONE=Europe/Amsterdam atymchuk/lampy`

Point your browser to http://localhost to launch your app

Database
--------
user: root

password: [leave blank]
