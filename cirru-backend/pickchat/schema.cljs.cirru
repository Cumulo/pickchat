
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

def user $ {}
  :id nil
  :name nil
  :avatar nil

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
  :name nil
  :data nil
