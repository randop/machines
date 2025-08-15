USE pdns;
INSERT INTO domains (name, type) VALUES ('google.com', 'NATIVE');
INSERT INTO domains (name, type) VALUES ('microsoft.com', 'NATIVE');
INSERT INTO domains (name, type) VALUES ('apple.com', 'NATIVE');

INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'google.com'), 'google.com', 'SOA', 'ns1.blocked.domains hostmaster.blocked.domains 1 7200 900 1209600 86400', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'microsoft.com'), 'microsoft.com', 'SOA', 'ns1.blocked.domains hostmaster.blocked.domains 1 7200 900 1209600 86400', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'apple.com'), 'apple.com', 'SOA', 'ns1.blocked.domains hostmaster.blocked.domains 1 7200 900 1209600 86400', 3600, 0, 0);

INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'microsoft.com'), 'microsoft.com', 'A', '0.0.0.0', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'microsoft.com'), 'www.microsoft.com', 'A', '0.0.0.0', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'microsoft.com'), '*.microsoft.com', 'A', '0.0.0.0', 3600, 0, 0);

INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'google.com'), 'google.com', 'A', '0.0.0.0', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'google.com'), 'www.google.com', 'A', '0.0.0.0', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'google.com'), '*.google.com', 'A', '0.0.0.0', 3600, 0, 0);

INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'apple.com'), 'apple.com', 'A', '0.0.0.0', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'apple.com'), 'www.apple.com', 'A', '0.0.0.0', 3600, 0, 0);
INSERT INTO records (domain_id, name, type, content, ttl, prio, disabled) VALUES ((SELECT id FROM domains WHERE name = 'apple.com'), '*.apple.com', 'A', '0.0.0.0', 3600, 0, 0);
