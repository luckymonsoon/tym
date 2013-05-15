#!/usr/bin/env ruby
require "redis"
####Username validation

def username_check
  redis = Redis.new
  nextuid = redis.get("global:nextUserId")
  puts "Please enter a username."
  usern = gets.chomp
  username_uid = "username:"+usern+":uid"
  #puts username_uid
  #puts "passed username_uid variable."
  if redis.exists(username_uid) == true
    puts "That username is already in use !"
  else
    redis.setnx(username_uid, nextuid)
    redis.setnx("uid:"+nextuid+":username", usern)
    redis.incr(nextuid)
    puts usern+" has been added!"
  end
end

username_check
