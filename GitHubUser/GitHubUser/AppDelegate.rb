#
#  AppDelegate.rb
#  OctocatBox
#
#  Created by Watson on 11/05/30.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'net/http'
require 'json'

class AppDelegate
    attr_accessor :window
    attr_accessor :text_user

    attr_accessor :avator, :name, :created_at
    attr_accessor :blog, :company, :location, :public_repo_count
    attr_accessor :public_gist_count, :email, :following_count, :followers_count

    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end

    def get_user_info(sender)
        user = get_user_id
        req = Net::HTTP::Get.new('/api/v2/json/user/show/' + user)

        response = ""
        Net::HTTP.start('github.com', 80) {|http|
            res = http.request(req)
            response = res.body
        }

        json = JSON.parse(response)
        user = json['user']

        avator_url = NSURL.URLWithString("http://gravatar.com/avatar/#{user['gravatar_id']}")
        avator.image = NSImage.alloc.initWithContentsOfURL(avator_url)

        display(user, "name")
        display(user, "created_at")
        display(user, "blog")
        display(user, "company")
        display(user, "location")
        display(user, "public_repo_count")
        display(user, "public_gist_count")
        display(user, "email")
        display(user, "following_count")
        display(user, "followers_count")
    end

    private

    def get_user_id
        text_user.stringValue
    end
    
    def display(obj, key)
        eval "#{key}.stringValue = obj['#{key}'].to_s" unless obj[key].nil?
    end
end

