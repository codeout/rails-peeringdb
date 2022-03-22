CREATE TABLE IF NOT EXISTS "django_migrations" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "app" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "applied" datetime NOT NULL
);

CREATE TABLE IF NOT EXISTS "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL
);

CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");

CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");

CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");

CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");

CREATE TABLE IF NOT EXISTS "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "codename" varchar(100) NOT NULL,
    "name" varchar(255) NOT NULL
);

CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");

CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");

CREATE TABLE IF NOT EXISTS "peeringdb_ix_facility" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NOT NULL,
    "facility_id" integer NOT NULL REFERENCES "peeringdb_facility" ("id") DEFERRABLE INITIALLY DEFERRED,
    "ix_id" integer NOT NULL REFERENCES "peeringdb_ix" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "peeringdb_network_facility" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "local_asn" integer unsigned NULL CHECK ("local_asn" >= 0),
    "avail_sonet" bool NULL,
    "avail_ethernet" bool NULL,
    "avail_atm" bool NULL,
    "facility_id" integer NOT NULL,
    "network_id" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "peeringdb_organization_merge" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "created" datetime NOT NULL,
    "from_org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "to_org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "peeringdb_organization_merge_entity" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "object_id" integer unsigned NOT NULL CHECK ("object_id" >= 0),
    "note" varchar(32) NULL,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "merge_id" integer NOT NULL REFERENCES "peeringdb_organization_merge" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "peeringdb_user_password_reset" (
    "user_id" integer NOT NULL PRIMARY KEY REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "token" varchar(255) NOT NULL,
    "created" datetime NOT NULL
);

CREATE INDEX "peeringdb_ix_facility_facility_id_fd485654" ON "peeringdb_ix_facility" ("facility_id");

CREATE INDEX "peeringdb_ix_facility_ix_id_59b7a91d" ON "peeringdb_ix_facility" ("ix_id");

CREATE INDEX "peeringdb_network_facility_facility_id_ce0983c1" ON "peeringdb_network_facility" ("facility_id");

CREATE INDEX "peeringdb_network_facility_network_id_8fd2a425" ON "peeringdb_network_facility" ("network_id");

CREATE INDEX "peeringdb_organization_merge_from_org_id_57057f42" ON "peeringdb_organization_merge" ("from_org_id");

CREATE INDEX "peeringdb_organization_merge_to_org_id_b83662fe" ON "peeringdb_organization_merge" ("to_org_id");

CREATE INDEX "peeringdb_organization_merge_entity_content_type_id_6113ee4d" ON "peeringdb_organization_merge_entity" ("content_type_id");

CREATE INDEX "peeringdb_organization_merge_entity_merge_id_c3aa5dd5" ON "peeringdb_organization_merge_entity" ("merge_id");

CREATE TABLE IF NOT EXISTS "peeringdb_user_groups" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "peeringdb_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE UNIQUE INDEX "peeringdb_network_facility_network_id_facility_id_local_asn_0fbf8d25_uniq" ON "peeringdb_network_facility" ("network_id", "facility_id", "local_asn");

CREATE UNIQUE INDEX "peeringdb_ix_facility_ix_id_facility_id_e278756c_uniq" ON "peeringdb_ix_facility" ("ix_id", "facility_id");

CREATE UNIQUE INDEX "peeringdb_user_groups_user_id_group_id_f396c584_uniq" ON "peeringdb_user_groups" ("user_id", "group_id");

CREATE INDEX "peeringdb_user_groups_user_id_78e1438e" ON "peeringdb_user_groups" ("user_id");

CREATE INDEX "peeringdb_user_groups_group_id_788d58eb" ON "peeringdb_user_groups" ("group_id");

CREATE UNIQUE INDEX "peeringdb_user_user_permissions_user_id_permission_id_66c191cd_uniq" ON "peeringdb_user_user_permissions" ("user_id", "permission_id");

CREATE INDEX "peeringdb_user_user_permissions_user_id_90822aed" ON "peeringdb_user_user_permissions" ("user_id");

CREATE INDEX "peeringdb_user_user_permissions_permission_id_e6a6330d" ON "peeringdb_user_user_permissions" ("permission_id");

CREATE TABLE IF NOT EXISTS "account_emailconfirmation" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "created" datetime NOT NULL,
    "sent" datetime NULL,
    "key" varchar(64) NOT NULL UNIQUE,
    "email_address_id" integer NOT NULL REFERENCES "account_emailaddress" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "account_emailconfirmation_email_address_id_5b7f8c58" ON "account_emailconfirmation" ("email_address_id");

CREATE TABLE IF NOT EXISTS "account_emailaddress" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "verified" bool NOT NULL,
    "primary" bool NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "email" varchar(254) NOT NULL UNIQUE
);

CREATE INDEX "account_emailaddress_user_id_2c513194" ON "account_emailaddress" ("user_id");

CREATE TABLE IF NOT EXISTS "django_admin_log" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "action_time" datetime NOT NULL,
    "object_id" text NULL,
    "object_repr" varchar(200) NOT NULL,
    "change_message" text NOT NULL,
    "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "action_flag" smallint unsigned NOT NULL CHECK ("action_flag" >= 0)
);

CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");

CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");

CREATE TABLE IF NOT EXISTS "auth_group" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS "captcha_captchastore" (
    "challenge" varchar(32) NOT NULL,
    "response" varchar(32) NOT NULL,
    "hashkey" varchar(40) NOT NULL UNIQUE,
    "expiration" datetime NOT NULL,
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE IF NOT EXISTS "corsheaders_corsmodel" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cors" varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS "django_grainy_grouppermission" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "namespace" varchar(255) NOT NULL,
    "permission" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "django_grainy_userpermission" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "namespace" varchar(255) NOT NULL,
    "permission" integer NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "django_grainy_grouppermission_group_id_a1211009" ON "django_grainy_grouppermission" ("group_id");

CREATE INDEX "django_grainy_userpermission_user_id_41afe948" ON "django_grainy_userpermission" ("user_id");

CREATE TABLE IF NOT EXISTS "security_keys_user_handle" (
    "user_id" integer NOT NULL PRIMARY KEY REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "handle" varchar(255) NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS "security_keys_2fa_device" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(64) NOT NULL,
    "confirmed" bool NOT NULL,
    "throttling_failure_timestamp" datetime NULL,
    "throttling_failure_count" integer unsigned NOT NULL CHECK ("throttling_failure_count" >= 0),
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "security_keys_2fa_device_user_id_4f0c59bf" ON "security_keys_2fa_device" ("user_id");

CREATE TABLE IF NOT EXISTS "security_keys_security_key" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(255) NULL,
    "credential_id" varchar(255) NOT NULL UNIQUE,
    "credential_public_key" text NOT NULL,
    "sign_count" integer unsigned NOT NULL CHECK ("sign_count" >= 0),
    "type" varchar(64) NOT NULL,
    "passwordless_login" bool NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "attestation" text NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL
);

CREATE INDEX "security_keys_security_key_user_id_d5159e6d" ON "security_keys_security_key" ("user_id");

CREATE TABLE IF NOT EXISTS "oauth2_provider_refreshtoken" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "token" varchar(255) NOT NULL,
    "access_token_id" bigint NULL UNIQUE REFERENCES "oauth2_provider_accesstoken" ("id") DEFERRABLE INITIALLY DEFERRED,
    "application_id" bigint NOT NULL REFERENCES "oauth2_provider_application" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "revoked" datetime NULL
);

CREATE UNIQUE INDEX "oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq" ON "oauth2_provider_refreshtoken" ("token", "revoked");

CREATE INDEX "oauth2_provider_refreshtoken_application_id_2d1c311b" ON "oauth2_provider_refreshtoken" ("application_id");

CREATE INDEX "oauth2_provider_refreshtoken_user_id_da837fce" ON "oauth2_provider_refreshtoken" ("user_id");

CREATE TABLE IF NOT EXISTS "oauth2_provider_application" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "client_id" varchar(100) NOT NULL UNIQUE,
    "redirect_uris" text NOT NULL,
    "client_type" varchar(32) NOT NULL,
    "client_secret" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "skip_authorization" bool NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "algorithm" varchar(5) NOT NULL,
    "authorization_grant_type" varchar(32) NOT NULL
);

CREATE INDEX "oauth2_provider_application_client_secret_53133678" ON "oauth2_provider_application" ("client_secret");

CREATE INDEX "oauth2_provider_application_user_id_79829054" ON "oauth2_provider_application" ("user_id");

CREATE TABLE IF NOT EXISTS "oauth2_provider_idtoken" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "jti" char(32) NOT NULL UNIQUE,
    "expires" datetime NOT NULL,
    "scope" text NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "application_id" bigint NULL REFERENCES "oauth2_provider_application" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "oauth2_provider_accesstoken" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "token" varchar(255) NOT NULL UNIQUE,
    "expires" datetime NOT NULL,
    "scope" text NOT NULL,
    "application_id" bigint NULL REFERENCES "oauth2_provider_application" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "source_refresh_token_id" bigint NULL UNIQUE REFERENCES "oauth2_provider_refreshtoken" ("id") DEFERRABLE INITIALLY DEFERRED,
    "id_token_id" bigint NULL UNIQUE REFERENCES "oauth2_provider_idtoken" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "oauth2_provider_idtoken_application_id_08c5ff4f" ON "oauth2_provider_idtoken" ("application_id");

CREATE INDEX "oauth2_provider_idtoken_user_id_dd512b59" ON "oauth2_provider_idtoken" ("user_id");

CREATE INDEX "oauth2_provider_accesstoken_application_id_b22886e1" ON "oauth2_provider_accesstoken" ("application_id");

CREATE INDEX "oauth2_provider_accesstoken_user_id_6e4c9a65" ON "oauth2_provider_accesstoken" ("user_id");

CREATE TABLE IF NOT EXISTS "oauth2_provider_grant" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "code" varchar(255) NOT NULL UNIQUE,
    "expires" datetime NOT NULL,
    "redirect_uri" text NOT NULL,
    "scope" text NOT NULL,
    "application_id" bigint NOT NULL REFERENCES "oauth2_provider_application" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "code_challenge" varchar(128) NOT NULL,
    "code_challenge_method" varchar(10) NOT NULL,
    "nonce" varchar(255) NOT NULL,
    "claims" text NOT NULL
);

CREATE INDEX "oauth2_provider_grant_application_id_81923564" ON "oauth2_provider_grant" ("application_id");

CREATE INDEX "oauth2_provider_grant_user_id_e8f62af8" ON "oauth2_provider_grant" ("user_id");

CREATE TABLE IF NOT EXISTS "otp_email_emaildevice" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(64) NOT NULL,
    "confirmed" bool NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "token" varchar(16) NULL,
    "valid_until" datetime NOT NULL,
    "email" varchar(254) NULL,
    "throttling_failure_count" integer unsigned NOT NULL CHECK ("throttling_failure_count" >= 0),
    "throttling_failure_timestamp" datetime NULL
);

CREATE INDEX "otp_email_emaildevice_user_id_0215c274" ON "otp_email_emaildevice" ("user_id");

CREATE TABLE IF NOT EXISTS "otp_static_statictoken" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "token" varchar(16) NOT NULL,
    "device_id" integer NOT NULL REFERENCES "otp_static_staticdevice" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "otp_static_statictoken_token_d0a51866" ON "otp_static_statictoken" ("token");

CREATE INDEX "otp_static_statictoken_device_id_74b7c7d1" ON "otp_static_statictoken" ("device_id");

CREATE TABLE IF NOT EXISTS "otp_static_staticdevice" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(64) NOT NULL,
    "confirmed" bool NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "throttling_failure_count" integer unsigned NOT NULL CHECK ("throttling_failure_count" >= 0),
    "throttling_failure_timestamp" datetime NULL
);

CREATE INDEX "otp_static_staticdevice_user_id_7f9cff2b" ON "otp_static_staticdevice" ("user_id");

CREATE TABLE IF NOT EXISTS "otp_totp_totpdevice" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(64) NOT NULL,
    "confirmed" bool NOT NULL,
    "key" varchar(80) NOT NULL,
    "step" smallint unsigned NOT NULL CHECK ("step" >= 0),
    "t0" bigint NOT NULL,
    "digits" smallint unsigned NOT NULL CHECK ("digits" >= 0),
    "tolerance" smallint unsigned NOT NULL CHECK ("tolerance" >= 0),
    "drift" smallint NOT NULL,
    "last_t" bigint NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "throttling_failure_count" integer unsigned NOT NULL CHECK ("throttling_failure_count" >= 0),
    "throttling_failure_timestamp" datetime NULL
);

CREATE INDEX "otp_totp_totpdevice_user_id_0fb18292" ON "otp_totp_totpdevice" ("user_id");

CREATE TABLE IF NOT EXISTS "reversion_revision" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date_created" datetime NOT NULL,
    "comment" text NOT NULL,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "reversion_version" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "object_id" varchar(191) NOT NULL,
    "format" varchar(255) NOT NULL,
    "serialized_data" text NOT NULL,
    "object_repr" text NOT NULL,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "revision_id" integer NOT NULL REFERENCES "reversion_revision" ("id") DEFERRABLE INITIALLY DEFERRED,
    "db" varchar(191) NOT NULL
);

CREATE UNIQUE INDEX "reversion_version_db_content_type_id_object_id_revision_id_b2c54f65_uniq" ON "reversion_version" (
    "db",
    "content_type_id",
    "object_id",
    "revision_id"
);

CREATE INDEX "reversion_revision_date_created_96f7c20c" ON "reversion_revision" ("date_created");

CREATE INDEX "reversion_revision_user_id_17095f45" ON "reversion_revision" ("user_id");

CREATE INDEX "reversion_version_content_type_id_7d0ff25c" ON "reversion_version" ("content_type_id");

CREATE INDEX "reversion_version_revision_id_af9f6a9d" ON "reversion_version" ("revision_id");

CREATE TABLE IF NOT EXISTS "peeringdb_server_ixlanixfmemberimportattempt" (
    "ixlan_id" integer NOT NULL PRIMARY KEY REFERENCES "peeringdb_ixlan" ("id") DEFERRABLE INITIALLY DEFERRED,
    "updated" datetime NOT NULL,
    "info" text NULL
);

CREATE TABLE IF NOT EXISTS "peeringdb_server_ixlanixfmemberimportlog" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "ixlan_id" integer NOT NULL REFERENCES "peeringdb_ixlan" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "peeringdb_server_ixlanixfmemberimportlog_ixlan_id_d40590dd" ON "peeringdb_server_ixlanixfmemberimportlog" ("ixlan_id");

CREATE TABLE IF NOT EXISTS "peeringdb_server_ixlanixfmemberimportlogentry" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "log_id" integer NOT NULL REFERENCES "peeringdb_server_ixlanixfmemberimportlog" ("id") DEFERRABLE INITIALLY DEFERRED,
    "netixlan_id" integer NOT NULL REFERENCES "peeringdb_network_ixlan" ("id") DEFERRABLE INITIALLY DEFERRED,
    "version_after_id" integer NOT NULL REFERENCES "reversion_version" ("id") DEFERRABLE INITIALLY DEFERRED,
    "version_before_id" integer NULL REFERENCES "reversion_version" ("id") DEFERRABLE INITIALLY DEFERRED,
    "action" varchar(255) NULL,
    "reason" varchar(255) NULL
);

CREATE INDEX "peeringdb_server_ixlanixfmemberimportlogentry_log_id_ee6e3beb" ON "peeringdb_server_ixlanixfmemberimportlogentry" ("log_id");

CREATE INDEX "peeringdb_server_ixlanixfmemberimportlogentry_netixlan_id_3babee67" ON "peeringdb_server_ixlanixfmemberimportlogentry" ("netixlan_id");

CREATE INDEX "peeringdb_server_ixlanixfmemberimportlogentry_version_after_id_e369069b" ON "peeringdb_server_ixlanixfmemberimportlogentry" ("version_after_id");

CREATE INDEX "peeringdb_server_ixlanixfmemberimportlogentry_version_before_id_d11aa699" ON "peeringdb_server_ixlanixfmemberimportlogentry" ("version_before_id");

CREATE TABLE IF NOT EXISTS "peeringdb_sponsorship" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "start_date" datetime NOT NULL,
    "end_date" datetime NOT NULL,
    "notify_date" datetime NULL,
    "level" integer unsigned NOT NULL CHECK ("level" >= 0)
);

CREATE TABLE IF NOT EXISTS "peeringdb_server_commandlinetool" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "arguments" text NOT NULL,
    "result" text NULL,
    "created" datetime NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "description" varchar(255) NULL,
    "status" varchar(255) NOT NULL,
    "tool" varchar(255) NOT NULL
);

CREATE INDEX "peeringdb_server_commandlinetool_user_id_a6a414aa" ON "peeringdb_server_commandlinetool" ("user_id");

CREATE TABLE IF NOT EXISTS "peeringdb_network_contact" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NOT NULL,
    "role" varchar(27) NOT NULL,
    "name" varchar(254) NOT NULL,
    "phone" varchar(100) NOT NULL,
    "email" varchar(254) NOT NULL,
    "url" varchar(255) NOT NULL,
    "network_id" integer NOT NULL REFERENCES "peeringdb_network" ("id") DEFERRABLE INITIALLY DEFERRED,
    "visible" varchar(64) NOT NULL
);

CREATE INDEX "peeringdb_network_contact_network_id_03faf0f9" ON "peeringdb_network_contact" ("network_id");

CREATE TABLE IF NOT EXISTS "peeringdb_partnership" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "level" integer unsigned NOT NULL CHECK ("level" >= 0),
    "url" varchar(200) NULL,
    "org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "logo" varchar(100) NULL
);

CREATE INDEX "peeringdb_partnership_org_id_3ea4cdcc" ON "peeringdb_partnership" ("org_id");

CREATE TABLE IF NOT EXISTS "peeringdb_server_sponsorshiporganization" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" varchar(200) NULL,
    "org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "sponsorship_id" integer NOT NULL REFERENCES "peeringdb_sponsorship" ("id") DEFERRABLE INITIALLY DEFERRED,
    "logo" varchar(100) NULL
);

CREATE INDEX "peeringdb_server_sponsorshiporganization_org_id_bfdb3343" ON "peeringdb_server_sponsorshiporganization" ("org_id");

CREATE INDEX "peeringdb_server_sponsorshiporganization_sponsorship_id_155c182e" ON "peeringdb_server_sponsorshiporganization" ("sponsorship_id");

CREATE TABLE IF NOT EXISTS "peeringdb_user" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "password" varchar(128) NOT NULL,
    "last_login" datetime NULL,
    "is_superuser" bool NOT NULL,
    "username" varchar(254) NOT NULL UNIQUE,
    "email" varchar(254) NOT NULL,
    "first_name" varchar(254) NOT NULL,
    "last_name" varchar(254) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "date_joined" datetime NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "locale" varchar(62) NULL,
    "status" varchar(254) NOT NULL
);

CREATE TABLE IF NOT EXISTS "peeringdb_user_org_affil_request" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "org_name" varchar(255) NULL,
    "asn" integer unsigned NULL CHECK ("asn" >= 0),
    "created" datetime NOT NULL,
    "org_id" integer NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "status" varchar(254) NOT NULL
);

CREATE INDEX "peeringdb_user_org_affil_request_org_id_4fdf168d" ON "peeringdb_user_org_affil_request" ("org_id");

CREATE INDEX "peeringdb_user_org_affil_request_user_id_9829a94e" ON "peeringdb_user_org_affil_request" ("user_id");

CREATE TABLE IF NOT EXISTS "peeringdb_network_ixlan" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "asn" integer unsigned NOT NULL CHECK ("asn" >= 0),
    "ipaddr4" varchar(39) NULL,
    "ipaddr6" varchar(39) NULL,
    "is_rs_peer" bool NOT NULL,
    "notes" varchar(255) NOT NULL,
    "speed" integer unsigned NOT NULL CHECK ("speed" >= 0),
    "ixlan_id" integer NOT NULL,
    "network_id" integer NOT NULL,
    "operational" bool NULL
);

CREATE INDEX "peeringdb_network_ixlan_ixlan_id_521451ed" ON "peeringdb_network_ixlan" ("ixlan_id");

CREATE INDEX "peeringdb_network_ixlan_network_id_70dd346f" ON "peeringdb_network_ixlan" ("network_id");

CREATE TABLE IF NOT EXISTS "peeringdb_server_ixfimportemail" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "subject" varchar(255) NOT NULL,
    "message" text NOT NULL,
    "recipients" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "sent" datetime NULL,
    "ix_id" integer NULL REFERENCES "peeringdb_ix" ("id") DEFERRABLE INITIALLY DEFERRED,
    "net_id" integer NULL REFERENCES "peeringdb_network" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "peeringdb_server_ixfimportemail_ix_id_4a00cbf5" ON "peeringdb_server_ixfimportemail" ("ix_id");

CREATE INDEX "peeringdb_server_ixfimportemail_net_id_c59e81a7" ON "peeringdb_server_ixfimportemail" ("net_id");

CREATE TABLE IF NOT EXISTS "peeringdb_ixlan" (
    "id" integer NOT NULL PRIMARY KEY,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "name" varchar(255) NOT NULL,
    "descr" text NOT NULL,
    "mtu" integer unsigned NULL CHECK ("mtu" >= 0),
    "vlan" integer unsigned NULL CHECK ("vlan" >= 0),
    "dot1q_support" bool NOT NULL,
    "rs_asn" integer unsigned NULL CHECK ("rs_asn" >= 0),
    "arp_sponge" varchar(17) NULL UNIQUE,
    "ix_id" integer NOT NULL REFERENCES "peeringdb_ix" ("id") DEFERRABLE INITIALLY DEFERRED,
    "ixf_ixp_member_list_url" varchar(200) NULL,
    "ixf_ixp_import_enabled" bool NULL,
    "ixf_ixp_import_error" text NULL,
    "ixf_ixp_import_error_notified" datetime NULL,
    "ixf_ixp_member_list_url_visible" varchar(64) NULL,
    "ixf_ixp_import_protocol_conflict" integer NULL
);

CREATE INDEX "peeringdb_ixlan_ix_id_3ba4157a" ON "peeringdb_ixlan" ("ix_id");

CREATE TABLE IF NOT EXISTS "peeringdb_ixf_member_data" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NOT NULL,
    "asn" integer unsigned NOT NULL CHECK ("asn" >= 0),
    "ipaddr4" varchar(39) NULL,
    "ipaddr6" varchar(39) NULL,
    "notes" varchar(255) NOT NULL,
    "speed" integer unsigned NOT NULL CHECK ("speed" >= 0),
    "operational" bool NOT NULL,
    "data" text NOT NULL,
    "log" text NOT NULL,
    "dismissed" bool NOT NULL,
    "error" text NULL,
    "reason" varchar(255) NOT NULL,
    "fetched" datetime NOT NULL,
    "ixlan_id" integer NOT NULL REFERENCES "peeringdb_ixlan" ("id") DEFERRABLE INITIALLY DEFERRED,
    "deskpro_id" integer NULL,
    "deskpro_ref" varchar(32) NULL,
    "is_rs_peer" bool NULL,
    "requirement_of_id" integer NULL REFERENCES "peeringdb_ixf_member_data" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "peeringdb_ixf_member_data_ixlan_id_aa09b9f6" ON "peeringdb_ixf_member_data" ("ixlan_id");

CREATE INDEX "peeringdb_ixf_member_data_requirement_of_id_702643dc" ON "peeringdb_ixf_member_data" ("requirement_of_id");

CREATE TABLE IF NOT EXISTS "peeringdb_ixlan_prefix" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NOT NULL,
    "notes" varchar(255) NOT NULL,
    "protocol" varchar(64) NOT NULL,
    "prefix" varchar(43) NOT NULL UNIQUE,
    "ixlan_id" integer NOT NULL REFERENCES "peeringdb_ixlan" ("id") DEFERRABLE INITIALLY DEFERRED,
    "in_dfz" bool NOT NULL
);

CREATE INDEX "peeringdb_ixlan_prefix_ixlan_id_d8e99297" ON "peeringdb_ixlan_prefix" ("ixlan_id");

CREATE TABLE IF NOT EXISTS "peeringdb_server_deskproticketcc" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" varchar(254) NOT NULL,
    "ticket_id" integer NOT NULL REFERENCES "peeringdb_server_deskproticket" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE UNIQUE INDEX "peeringdb_server_deskproticketcc_ticket_id_email_b5d2ba56_uniq" ON "peeringdb_server_deskproticketcc" ("ticket_id", "email");

CREATE INDEX "peeringdb_server_deskproticketcc_ticket_id_d9150f6e" ON "peeringdb_server_deskproticketcc" ("ticket_id");

CREATE TABLE IF NOT EXISTS "peeringdb_user_api_key" (
    "id" varchar(100) NOT NULL PRIMARY KEY,
    "prefix" varchar(8) NOT NULL UNIQUE,
    "hashed_key" varchar(100) NOT NULL,
    "created" datetime NOT NULL,
    "name" varchar(50) NOT NULL,
    "revoked" bool NOT NULL,
    "expiry_date" datetime NULL,
    "readonly" bool NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "peeringdb_server_organizationapipermission" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "namespace" varchar(255) NOT NULL,
    "permission" integer NOT NULL,
    "org_api_key_id" varchar(100) NOT NULL REFERENCES "peeringdb_org_api_key" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "peeringdb_user_api_key_created_fff46c48" ON "peeringdb_user_api_key" ("created");

CREATE INDEX "peeringdb_user_api_key_user_id_f6eaf10c" ON "peeringdb_user_api_key" ("user_id");

CREATE INDEX "peeringdb_server_organizationapipermission_org_api_key_id_6efc2912" ON "peeringdb_server_organizationapipermission" ("org_api_key_id");

CREATE TABLE IF NOT EXISTS "peeringdb_verification_queue" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "object_id" integer unsigned NOT NULL CHECK ("object_id" >= 0),
    "created" datetime NOT NULL,
    "notified" bool NOT NULL,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "org_key_id" varchar(100) NULL REFERENCES "peeringdb_org_api_key" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE UNIQUE INDEX "peeringdb_verification_queue_content_type_id_object_id_3ddbe4b2_uniq" ON "peeringdb_verification_queue" ("content_type_id", "object_id");

CREATE INDEX "peeringdb_verification_queue_content_type_id_52229dd3" ON "peeringdb_verification_queue" ("content_type_id");

CREATE INDEX "peeringdb_verification_queue_user_id_80c3f747" ON "peeringdb_verification_queue" ("user_id");

CREATE INDEX "peeringdb_verification_queue_org_key_id_688aaddf" ON "peeringdb_verification_queue" ("org_key_id");

CREATE TABLE IF NOT EXISTS "peeringdb_server_deskproticket" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "subject" varchar(255) NOT NULL,
    "body" text NOT NULL,
    "created" datetime NOT NULL,
    "published" datetime NULL,
    "deskpro_id" integer NULL,
    "deskpro_ref" varchar(32) NULL,
    "email" varchar(254) NULL,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX "peeringdb_server_deskproticket_user_id_576a36ba" ON "peeringdb_server_deskproticket" ("user_id");

CREATE TABLE IF NOT EXISTS "peeringdb_org_api_key" (
    "id" varchar(100) NOT NULL PRIMARY KEY,
    "prefix" varchar(8) NOT NULL UNIQUE,
    "hashed_key" varchar(100) NOT NULL,
    "created" datetime NOT NULL,
    "name" varchar(50) NOT NULL,
    "revoked" bool NOT NULL,
    "expiry_date" datetime NULL,
    "org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "email" varchar(254) NOT NULL
);

CREATE INDEX "peeringdb_org_api_key_created_a57e7d9a" ON "peeringdb_org_api_key" ("created");

CREATE INDEX "peeringdb_org_api_key_org_id_df69501e" ON "peeringdb_org_api_key" ("org_id");

CREATE TABLE IF NOT EXISTS "peeringdb_geocoord_cache" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "country" varchar(2) NOT NULL,
    "city" varchar(255) NULL,
    "address1" varchar(255) NULL,
    "state" varchar(255) NULL,
    "zipcode" varchar(255) NULL,
    "latitude" decimal NULL,
    "longitude" decimal NULL,
    "fetched" datetime NOT NULL
);

CREATE TABLE IF NOT EXISTS "peeringdb_organization" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "address1" varchar(255) NOT NULL,
    "address2" varchar(255) NOT NULL,
    "city" varchar(255) NOT NULL,
    "state" varchar(255) NOT NULL,
    "zipcode" varchar(48) NOT NULL,
    "country" varchar(2) NOT NULL,
    "name" varchar(255) NOT NULL UNIQUE,
    "website" varchar(255) NOT NULL,
    "notes" text NOT NULL,
    "logo" varchar(100) NULL,
    "latitude" decimal NULL,
    "longitude" decimal NULL,
    "floor" varchar(255) NULL,
    "suite" varchar(255) NULL,
    "geocode_date" datetime NULL,
    "geocode_status" bool NULL,
    "aka" varchar(255) NULL,
    "name_long" varchar(255) NULL,
    "flagged" bool NULL,
    "flagged_date" datetime NULL
);

CREATE TABLE IF NOT EXISTS "peeringdb_settings" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value_str" varchar(255) NULL,
    "value_int" integer NULL,
    "value_bool" bool NOT NULL,
    "value_float" real NULL,
    "updated" datetime NULL,
    "created" datetime NULL,
    "user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "setting" varchar(255) NOT NULL UNIQUE
);

CREATE INDEX "peeringdb_settings_user_id_42ce9304" ON "peeringdb_settings" ("user_id");

CREATE TABLE IF NOT EXISTS "peeringdb_facility" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "address1" varchar(255) NOT NULL,
    "address2" varchar(255) NOT NULL,
    "city" varchar(255) NOT NULL,
    "state" varchar(255) NOT NULL,
    "zipcode" varchar(48) NOT NULL,
    "country" varchar(2) NOT NULL,
    "name" varchar(255) NOT NULL UNIQUE,
    "website" varchar(200) NOT NULL,
    "clli" varchar(18) NOT NULL,
    "rencode" varchar(18) NOT NULL,
    "npanxx" varchar(21) NOT NULL,
    "notes" text NOT NULL,
    "org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "geocode_date" datetime NULL,
    "geocode_status" bool NULL,
    "latitude" decimal NULL,
    "longitude" decimal NULL,
    "sales_email" varchar(254) NULL,
    "sales_phone" varchar(192) NULL,
    "tech_email" varchar(254) NULL,
    "tech_phone" varchar(192) NULL,
    "floor" varchar(255) NULL,
    "suite" varchar(255) NULL,
    "aka" varchar(255) NULL,
    "name_long" varchar(255) NULL,
    "ix_count" integer unsigned NULL,
    "net_count" integer unsigned NOT NULL CHECK ("net_count" >= 0),
    "available_voltage_services" varchar(255) NULL,
    "diverse_serving_substations" bool NULL,
    "property" varchar(27) NULL,
    "region_continent" varchar(255) NULL,
    "status_dashboard" varchar(255) NULL
);

CREATE INDEX "peeringdb_facility_org_id_3420d8f7" ON "peeringdb_facility" ("org_id");

CREATE TABLE IF NOT EXISTS "peeringdb_ix" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "name" varchar(64) NOT NULL UNIQUE,
    "name_long" varchar(255) NOT NULL,
    "city" varchar(192) NOT NULL,
    "country" varchar(2) NOT NULL,
    "notes" text NOT NULL,
    "region_continent" varchar(255) NOT NULL,
    "media" varchar(128) NOT NULL,
    "proto_unicast" bool NOT NULL,
    "proto_multicast" bool NOT NULL,
    "proto_ipv6" bool NOT NULL,
    "website" varchar(255) NOT NULL,
    "url_stats" varchar(255) NOT NULL,
    "tech_email" varchar(254) NOT NULL,
    "tech_phone" varchar(192) NOT NULL,
    "policy_email" varchar(254) NOT NULL,
    "policy_phone" varchar(192) NOT NULL,
    "org_id" integer NOT NULL REFERENCES "peeringdb_organization" ("id") DEFERRABLE INITIALLY DEFERRED,
    "ixf_last_import" datetime NULL,
    "ixf_net_count" integer NULL,
    "aka" varchar(255) NULL,
    "service_level" varchar(60) NULL,
    "terms" varchar(60) NULL,
    "fac_count" integer unsigned NULL,
    "net_count" integer unsigned NULL,
    "ixf_import_request" datetime NULL,
    "ixf_import_request_status" varchar(32) NULL,
    "ixf_import_request_user_id" integer NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "sales_email" varchar(254) NULL,
    "sales_phone" varchar(192) NULL,
    "status_dashboard" varchar(255) NULL
);

CREATE INDEX "peeringdb_ix_org_id_7c888cd3" ON "peeringdb_ix" ("org_id");

CREATE INDEX "peeringdb_ix_ixf_import_request_user_id_183bc40f" ON "peeringdb_ix" ("ixf_import_request_user_id");

CREATE TABLE IF NOT EXISTS "peeringdb_network" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status" varchar(255) NOT NULL,
    "created" datetime NOT NULL,
    "updated" datetime NOT NULL,
    "version" integer NULL,
    "asn" integer unsigned NOT NULL UNIQUE CHECK ("asn" >= 0),
    "name" varchar(255) NOT NULL UNIQUE,
    "aka" varchar(255) NOT NULL,
    "irr_as_set" varchar(255) NOT NULL,
    "website" varchar(255) NOT NULL,
    "looking_glass" varchar(255) NOT NULL,
    "route_server" varchar(255) NOT NULL,
    "notes" text NOT NULL,
    "notes_private" text NULL,
    "info_traffic" varchar(39) NOT NULL,
    "info_ratio" varchar(45) NOT NULL,
    "info_scope" varchar(39) NOT NULL,
    "info_type" varchar(60) NOT NULL,
    "info_prefixes4" integer unsigned NULL CHECK ("info_prefixes4" >= 0),
    "info_prefixes6" integer unsigned NULL CHECK ("info_prefixes6" >= 0),
    "info_unicast" bool NOT NULL,
    "info_multicast" bool NOT NULL,
    "info_ipv6" bool NOT NULL,
    "policy_url" varchar(255) NOT NULL,
    "policy_general" varchar(72) NOT NULL,
    "policy_locations" varchar(72) NOT NULL,
    "policy_ratio" bool NOT NULL,
    "policy_contracts" varchar(36) NOT NULL,
    "org_id" integer NOT NULL,
    "allow_ixp_update" bool NULL,
    "info_never_via_route_servers" bool NULL,
    "netfac_updated" datetime NULL,
    "netixlan_updated" datetime NULL,
    "poc_updated" datetime NULL,
    "name_long" varchar(255) NULL,
    "fac_count" integer unsigned NULL,
    "ix_count" integer unsigned NULL,
    "status_dashboard" varchar(255) NULL
);

CREATE INDEX "peeringdb_network_org_id_404d6106" ON "peeringdb_network" ("org_id");

CREATE TABLE IF NOT EXISTS "rest_framework_api_key_apikey" (
    "id" varchar(100) NOT NULL PRIMARY KEY,
    "created" datetime NOT NULL,
    "name" varchar(50) NOT NULL,
    "revoked" bool NOT NULL,
    "expiry_date" datetime NULL,
    "hashed_key" varchar(100) NOT NULL,
    "prefix" varchar(8) NOT NULL UNIQUE
);

CREATE INDEX "rest_framework_api_key_apikey_created_c61872d9" ON "rest_framework_api_key_apikey" ("created");

CREATE INDEX "reversion_v_content_f95daf_idx" ON "reversion_version" ("content_type_id", "db");

CREATE TABLE IF NOT EXISTS "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" datetime NOT NULL
);

CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");

CREATE TABLE IF NOT EXISTS "django_site" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(50) NOT NULL,
    "domain" varchar(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS "socialaccount_socialapp_sites" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "socialapp_id" integer NOT NULL REFERENCES "socialaccount_socialapp" ("id") DEFERRABLE INITIALLY DEFERRED,
    "site_id" integer NOT NULL REFERENCES "django_site" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "socialaccount_socialtoken" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "token" text NOT NULL,
    "token_secret" text NOT NULL,
    "expires_at" datetime NULL,
    "account_id" integer NOT NULL REFERENCES "socialaccount_socialaccount" ("id") DEFERRABLE INITIALLY DEFERRED,
    "app_id" integer NOT NULL REFERENCES "socialaccount_socialapp" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE UNIQUE INDEX "socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq" ON "socialaccount_socialtoken" ("app_id", "account_id");

CREATE UNIQUE INDEX "socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq" ON "socialaccount_socialapp_sites" ("socialapp_id", "site_id");

CREATE INDEX "socialaccount_socialapp_sites_socialapp_id_97fb6e7d" ON "socialaccount_socialapp_sites" ("socialapp_id");

CREATE INDEX "socialaccount_socialapp_sites_site_id_2579dee5" ON "socialaccount_socialapp_sites" ("site_id");

CREATE INDEX "socialaccount_socialtoken_account_id_951f210e" ON "socialaccount_socialtoken" ("account_id");

CREATE INDEX "socialaccount_socialtoken_app_id_636a42d7" ON "socialaccount_socialtoken" ("app_id");

CREATE TABLE IF NOT EXISTS "socialaccount_socialapp" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "provider" varchar(30) NOT NULL,
    "name" varchar(40) NOT NULL,
    "client_id" varchar(191) NOT NULL,
    "key" varchar(191) NOT NULL,
    "secret" varchar(191) NOT NULL
);

CREATE TABLE IF NOT EXISTS "socialaccount_socialaccount" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "provider" varchar(30) NOT NULL,
    "uid" varchar(191) NOT NULL,
    "last_login" datetime NOT NULL,
    "date_joined" datetime NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "extra_data" text NOT NULL
);

CREATE UNIQUE INDEX "socialaccount_socialaccount_provider_uid_fc810c6e_uniq" ON "socialaccount_socialaccount" ("provider", "uid");

CREATE INDEX "socialaccount_socialaccount_user_id_8146e70c" ON "socialaccount_socialaccount" ("user_id");

CREATE TABLE IF NOT EXISTS "two_factor_phonedevice" (
    "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" varchar(64) NOT NULL,
    "confirmed" bool NOT NULL,
    "number" varchar(128) NOT NULL,
    "key" varchar(40) NOT NULL,
    "method" varchar(4) NOT NULL,
    "user_id" integer NOT NULL REFERENCES "peeringdb_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "throttling_failure_count" integer unsigned NOT NULL CHECK ("throttling_failure_count" >= 0),
    "throttling_failure_timestamp" datetime NULL
);

CREATE INDEX "two_factor_phonedevice_user_id_54718003" ON "two_factor_phonedevice" ("user_id");