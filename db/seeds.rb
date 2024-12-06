user = User.create(email: "admin@quequeo.com", password: "quequeo123")
puts user.errors.full_messages
puts user
# Create roles
admin_role = Role.create(name: "admin")
editor_role = Role.create(name: "editor")

# Assign roles to user
user.roles << admin_role
user.roles << editor_role

# Create projects for user
user.projects.create(title: "Quequeo", description: "The best project ever")
user.projects.create(title: "Rails", description: "The best framework ever")
user.projects.create(title: "Ruby", description: "The best language ever")
