object @post

attribute uuid: :id
attributes :title, :body, :created_at, :updated_at
child :user do
  extends 'api/v1/users/show'
end
node :permissions do |p|
  {
    update: can?(:update, p),
    destroy: can?(:destroy, p)
  }
end
