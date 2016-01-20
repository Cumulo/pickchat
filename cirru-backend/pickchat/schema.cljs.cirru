
ns pickchat.schema
  :require
    [] cljs.nodejs :as nodejs

def database $ {}
  :states $ {}
  :tasks $ {}
  :users $ {}

def task $ {}
  :text |
  :done false
  :id nil
  :time nil

def state $ {}
  :user-id nil
  :counter 0

def store $ {}
  :state state
  :tasks (:tasks database)
  :users (:users database)
