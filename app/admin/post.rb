ActiveAdmin.register Post do
  controller do
    actions :all, :except => [:edit]
  end
end
