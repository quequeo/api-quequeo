# Find or initialize user
user = User.find_or_initialize_by(email: "admin@quequeo.com")

# Create roles
admin_role  = Role.find_or_create_by(name: "admin")
editor_role = Role.find_or_create_by(name: "editor")

unless user.persisted?
  user.password = "quequeo123"
  user.save

  # Assign roles to user
  user.roles << admin_role unless user.has_role?("admin")
  user.roles << editor_role unless user.has_role?("editor")
end
