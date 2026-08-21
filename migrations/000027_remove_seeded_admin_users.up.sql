DELETE FROM admin_users
WHERE username = 'admin'
  AND role = 'super_admin'
  AND password_hash = '$2a$10$H1G08Ra8bCzSMcY0VQE3eeh.G.iuD0E5FlfnP0B2XTQisxUKbAM0q';
