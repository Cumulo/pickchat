
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
  :channel-id nil
  :modals $ []
  :notifications $ []
  :user nil
  :visibility-state true

def user $ {}
  :id nil
  :username nil
  :nickname nil
  :avatar |http://tp3.sinaimg.cn/2091311042/180/5599392933/1
  :password nil
  :time 0

def channel $ {}
  :id nil
  :title nil
  :time nil
  :author-id nil
  :member-ids $ []
  :last-message-id nil
  :last-message-time nil
  :last-author nil
  :is-private false

def message $ {}
  :id nil
  :text nil
  :time nil
  :channel-id nil
  :author-id nil

def store $ {}
  :state state
  :channel-id nil
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

def scene $ {}
  :channels $ {}
  :seen-messages $ {}
  :grouped-users $ {}
