
ns pickchat.schema
  :require
    [] cljs.nodejs :as nodejs

def database $ {}
  :states $ {}
  :channels $ {}
  :messages $ {}
  :users $ {}

def state $ {}
  :user-id nil
  :modals $ []
  :notifications $ []
  :user nil

def user $ {}
  :id nil
  :username nil
  :avatar nil
  :password nil

def channel $ {}
  :id nil
  :title nil
  :time nil
  :author-id nil
  :member-ids $ []

def message $ {}
  :id nil
  :text nil
  :time nil
  :author-id nil

def store $ {}
  :state state
  :channels $ []
  :router $ {}
    :name :home
    :data $ {}

def modal $ {}
  :id nil
  :type nil
  :name nil
  :data nil

def notification $ {}
  :id nil
  :type :info
  :text nil
